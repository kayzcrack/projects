/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.quanteq.syncmanager.controller;

import com.quanteq.syncmanager.bl.Pivot;
import com.quanteq.syncmanager.model.Biometric;
import com.quanteq.syncmanager.model.Case;
import com.quanteq.syncmanager.model.Suspect;
import java.io.BufferedReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.UnknownHostException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 *
 * @author voti
 */
public class SyncManager {

    // static String output = "";
    static int SEED = 1;
    //21600000
    static int MAX_DELAY = 10000;
    static boolean SHOULD_CONTINUE = false;
    static boolean CHECK_ADD_SUSPECT = true;
    private static final String targetURL = "http://sdg.quanteq.com/~mtchuente/police_v12/ws.php";

    static String suspectID;
    static String fullName;
    static String group;
    static String phoneNumber;
    static int age;
    static Date dateEnrolled;
    static String enroller;
    static String genderID;
    static String caseID = null; //same as suspectID
    static String crime = null;
    static int entryNumber = 0;
    static Date dateReported = null;
    static Date crimeDate = null;
    static String id;
    static String type;
    static String subType;
    static String data;
    static String msg;
    static String msg2;
    static String addSuspectt = "addSuspect";
    static String addCasee = "addCase";
    static String addBioo = "addBio";

    static List<Suspect> unsyncedRecords = new ArrayList();
    static boolean newRecordsExist = false;
    final static int BATCH_SIZE = 5;
    static int count = 0;

    public static void main(String[] args) {
        syncRecords();
        computeSleepTime();
    }

    public static void syncRecords() {
        // SHOULD_CONTINUE = false;
        System.out.println("Checking for unsynchronized records ....");

        try {
            newRecordsExist = new Pivot().checkUnflaggedRecords();
            SHOULD_CONTINUE = false;
        } catch (SQLException ex) {
            // print error here
            String txt = ex.toString();
//            printLog(txt);
            System.out.println(ex);
            SHOULD_CONTINUE = true;
            // compute time to sleep
            goToSleep(computeSleepTime());
        }
        if (newRecordsExist) {
            System.out.println("Found unsynchronized  records");
            SHOULD_CONTINUE = false;
            try {
                System.out.println("Fetching unsynchronized records in batches of " + BATCH_SIZE);
                unsyncedRecords = new Pivot().fetchUnflaggedRecords(BATCH_SIZE);
                count = unsyncedRecords.size();
                System.out.println(count + " Unsynchronized records fetched");
                // System.out.println(unsyncedRecords);
            } catch (SQLException ex) {
                // print log
                String txt = ex.toString();
//                printLog(txt);
                System.out.println(ex);
                SHOULD_CONTINUE = true;
                // compute time to sleep
                goToSleep(computeSleepTime());
            }
            // check if unsynchrecords where fecthed.

            System.out.println("Checking for network connection ....");
            if (isNetworkAvailable()) {
                System.out.println("Network connection OK!");
                System.out.println("Uploading " + count + " records to online database ....");
                System.out.println("\n");

                // should loop through list here
                for (Suspect suspect : unsyncedRecords) {
                    suspectID = suspect.getID();
                    fullName = suspect.getFullName();
                    group = suspect.getGroup();
                    phoneNumber = suspect.getPhoneNumber();
                    age = suspect.getAge();
                    dateEnrolled = suspect.getDateEnrolled();
                    enroller = suspect.getEnroller();
                    genderID = suspect.getGenderID();

                    try {
                        // call a service here to send to ODB
                        msg = addSuspect(addSuspectt, suspectID, fullName, age, enroller, genderID, dateEnrolled);
                        //  System.out.println("bbbbbbbbbbbbbbbbb: " + msg);
                        if (msg.isEmpty()) {
                            // System.out.println("yessssssssssssssssssssssssssss");
                            SHOULD_CONTINUE = false;
                            //  System.out.println(suspects.getCaseList());
                            for (Case suspectCase : suspect.getCaseList()) {
                                suspectID = suspectCase.getSuspectID();
                                crime = suspectCase.getCrime();
                                entryNumber = suspectCase.getEntryNumber();
                                dateReported = suspectCase.getDateReported();
                                crimeDate = suspectCase.getCrime_Date();
                                //  System.out.println("mcmcmcmcmcmcmcmcmc" + dateReported);
                                System.out.println("Suspect personal data sent to online database");
                                try {
                                    // call a service here to send to ODB
                                    msg2 = addCase(addCasee, suspectID, entryNumber, crime, crimeDate, dateReported);
                                    if (msg2.isEmpty()) {
                                        SHOULD_CONTINUE = false;
                                        System.out.println(SHOULD_CONTINUE);
                                        System.out.println("Suspect case(s)  sent to online database.");

                                        // add biometrics goes here.
                                        for (Biometric biometric : suspect.getBiometricList()) {
                                            id = biometric.getId();
                                            type = biometric.getTypeid();
                                            subType = biometric.getSubtypeid();
                                            data = biometric.getData();
                                            //  System.out.println(data);
                                            String userName = "ochoski";
                                            // call a web service.
                                            try {
                                                // call a service here to send to ODB
                                                String msg3 = addBiometric(addBioo, subType, type, id, data, userName);
                                                if (msg3.isEmpty()) {
                                                    SHOULD_CONTINUE = false;
                                                    System.out.println(SHOULD_CONTINUE);
                                                    System.out.println("Suspect biometric  sent to online database.");
                                                } else {
                                                    System.out.println("An error occur while sending biometric to online database. " + msg3);
                                                }
                                            } catch (IOException ex) {
                                                System.out.println(ex);
                                                SHOULD_CONTINUE = true;
                                                goToSleep(computeSleepTime());
                                            }
                                        }

                                    } else {
                                        System.out.println("An error occur while sending case to online database. " + msg2);
                                    }
                                } catch (IOException ex) {
                                    System.out.println(ex);
                                    SHOULD_CONTINUE = true;
                                    goToSleep(computeSleepTime());
                                }
                            }

                            // call procedure to flag records as sync in local database
                            for (Suspect suspectToFlag : unsyncedRecords) {
                                try {
                                    suspectID = suspectToFlag.getID();
                                    ResultSet flagSuspect = new Pivot().flagSuspect(suspectID);
                                    SHOULD_CONTINUE = false;
                                    System.out.println("Suspect" + suspectID + "flagged as sync.");

                                    //  System.out.println("Suspect " + suspectID + " flagged in database");
                                } catch (SQLException ex) {
                                    System.out.println(ex);
                                    SHOULD_CONTINUE = true;
                                    System.out.println("Going to sleep...");
                                    goToSleep(computeSleepTime());
                                }
                            }

                        } else {
                            System.out.println("An error occur");
                        }
                    } catch (RuntimeException ex) {
                        // Logger.getLogger(SyncManager.class.getName()).log(Level.SEVERE, null, ex);
                        System.out.println("This is a message from the web service: " + ex);
                        SHOULD_CONTINUE = true;
                        System.out.println("Going to sleep...");
                        goToSleep(computeSleepTime());
                    } catch (IOException ex) {
                        // Logger.getLogger(SyncManager.class.getName()).log(Level.SEVERE, null, ex);
                        System.out.println("This is a message from the web service: " + ex);
                        SHOULD_CONTINUE = true;
                        System.out.println("Going to sleep...");
                        goToSleep(computeSleepTime());
                    }

                }

                // call syncRecords to continue process
                syncRecords();
                SHOULD_CONTINUE = true;
                goToSleep(computeSleepTime());
            } else {
                System.out.printf("No network connection, retrying after " + SEED + "  seconds");
                System.out.println("\n");
                SHOULD_CONTINUE = true;
                // compute time to sleep
                goToSleep(computeSleepTime());
            }

        } else {
            System.out.println("No new record found");
            System.out.println("Checking again after  " + SEED + "  seconds");
            SHOULD_CONTINUE = true;
            System.out.println("\n");
            // SEED = SEED + 1;
            goToSleep(++SEED);
        }
    }

    public static boolean isNetworkAvailable() {
        boolean isAvailable = false;
        try {

            InetAddress[] addresses = InetAddress.getAllByName("www.google.com");
            if (addresses != null) {
                isAvailable = true;
            } else {
                isAvailable = false;
            }
        } catch (UnknownHostException ex) {
            // System.out.println("No network connection, please check connection and try again");
            // Logger.getLogger(SyncManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        return isAvailable;
    }

    public static void goToSleep(int duration) {
        try {
            Thread.sleep(duration);
            syncRecords();
        } catch (InterruptedException ex) {
            Logger.getLogger(SyncManager.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static int computeSleepTime() {
        System.out.println(SHOULD_CONTINUE);
        if (SHOULD_CONTINUE) {
            if (SEED >= MAX_DELAY) {
                SEED = 1;
                System.out.println("Maximum delay reached");
            } else {
                SEED = SEED * 2;
            }

        } else {
            SEED = 1;
        }

        System.out.println("Time to sleep is: " + SEED + " seconds");
        //goToSleep(SEED);
        return SEED;
    }

    public static String addSuspect(String operation, String suspectID, String fullName,
            int age, String enroller, String gender, Date dateEnrolled) throws IOException, RuntimeException {
        // code to call web service for saving data.
        String message = "";
        try {

            URL targetUrl = new URL(targetURL);

            HttpURLConnection httpConnection = (HttpURLConnection) targetUrl.openConnection();
            httpConnection.setDoOutput(true);
            httpConnection.setRequestMethod("POST");
            httpConnection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            httpConnection.setDoInput(true);

            String params = "op=" + operation + "&suspectID=" + suspectID + "&fullName=" + fullName
                    + "&age" + age
                    + "&userName=" + enroller + "&gender=" + gender + "&dateEnrolled=" + dateEnrolled;
            OutputStreamWriter wr = new OutputStreamWriter(httpConnection.getOutputStream());
            wr.write(params);
            wr.flush();

            if (httpConnection.getResponseCode() != 200) {
                // wia to catch this exception.
                throw new RuntimeException("Failed : HTTP error code : "
                        + httpConnection.getResponseCode());
            }

            BufferedReader responseBuffer = new BufferedReader(new InputStreamReader(
                    (httpConnection.getInputStream())));

            System.out.println("Output from Server:\n");
            String output;
            StringBuilder sb = new StringBuilder();
            while ((output = responseBuffer.readLine()) != null) {
                System.out.println(output);
                sb.append(output);
            }
            System.out.println("this is our output: " + output);
            httpConnection.disconnect();

            // convert json string to json object and get msg status.
            JSONParser parser = new JSONParser();
            Object obj = parser.parse(sb.toString());
            JSONObject jsonObject = (JSONObject) obj;
            JSONObject jsonObjectResult = (JSONObject) jsonObject.get("error");

            message = (String) jsonObjectResult.get("msg");
            System.out.println("xxxxxxxxxxxxxxxx: " + message);
            System.out.println(jsonObject.get("error"));
        } catch (MalformedURLException e) {
            CHECK_ADD_SUSPECT = false;
            e.printStackTrace();

        } catch (IOException e) {
            CHECK_ADD_SUSPECT = false;
            e.printStackTrace();

        } catch (ParseException ex) {
            Logger.getLogger(SyncManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        System.out.println("vvvvvvvvvvvvvv:" + message);
        return message;
    }

    public static String addCase(String operation, String suspectID, int entryNo, String crime, Date date, Date ddate)
            throws IOException {
        String message = "";
        try {

            URL targetUrl = new URL(targetURL);

            HttpURLConnection httpConnection = (HttpURLConnection) targetUrl.openConnection();
            httpConnection.setDoOutput(true);
            httpConnection.setRequestMethod("POST");
            httpConnection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            httpConnection.setDoInput(true);

            String params = "op=" + operation + "&suspectID=" + suspectID + "&entryNo=" + entryNo
                    + "&crime=" + crime + "&date=" + date + "&dateReported=" + ddate;

            OutputStreamWriter wr = new OutputStreamWriter(httpConnection.getOutputStream());
            wr.write(params);
            wr.flush();

            if (httpConnection.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + httpConnection.getResponseCode());
            }

            BufferedReader responseBuffer = new BufferedReader(new InputStreamReader(
                    (httpConnection.getInputStream())));

            String output;
            //  System.out.println("Output from Server:\n");
            StringBuilder sb = new StringBuilder();
            while ((output = responseBuffer.readLine()) != null) {
                //  System.out.println(output);
                sb.append(output);
            }

            httpConnection.disconnect();

            // convert json string to json object and get msg status.
            JSONParser parser = new JSONParser();
            Object obj = parser.parse(sb.toString());
            JSONObject jsonObject = (JSONObject) obj;
            JSONObject jsonObjectResult = (JSONObject) jsonObject.get("error");

            message = (String) jsonObjectResult.get("msg");
            System.out.println("xxxxxxxxxxxxxxxx: " + message);
            System.out.println(jsonObject.get("error"));

        } catch (MalformedURLException e) {

            e.printStackTrace();

        } catch (IOException e) {

            e.printStackTrace();

        } catch (ParseException ex) {
            Logger.getLogger(SyncManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        return message;
    }

    public static String addBiometric(String operation, String subType, String type, String id, String data, String userName)
            throws IOException {
        String message = "";
        try {

            URL targetUrl = new URL(targetURL);

            HttpURLConnection httpConnection = (HttpURLConnection) targetUrl.openConnection();
            httpConnection.setDoOutput(true);
            httpConnection.setRequestMethod("POST");
            httpConnection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            httpConnection.setDoInput(true);

            String params = "op=" + operation + "&subType=" + subType + "&type=" + type + "&id=" + id
                    + "&data=" + data + "&userName=" + userName;

            OutputStreamWriter wr = new OutputStreamWriter(httpConnection.getOutputStream());
            wr.write(params);
            wr.flush();

            if (httpConnection.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + httpConnection.getResponseCode());
            }

            BufferedReader responseBuffer = new BufferedReader(new InputStreamReader(
                    (httpConnection.getInputStream())));

            String output;
            //  System.out.println("Output from Server:\n");
            StringBuilder sb = new StringBuilder();
            while ((output = responseBuffer.readLine()) != null) {
                //  System.out.println(output);
                sb.append(output);
            }

            httpConnection.disconnect();

            // convert json string to json object and get msg status.
            JSONParser parser = new JSONParser();
            Object obj = parser.parse(sb.toString());
            JSONObject jsonObject = (JSONObject) obj;
            JSONObject jsonObjectResult = (JSONObject) jsonObject.get("error");

            message = (String) jsonObjectResult.get("msg");
            System.out.println("xxxxxxxxxxxxxxxx: " + message);
            System.out.println(jsonObject.get("error"));

        } catch (MalformedURLException e) {

            e.printStackTrace();

        } catch (IOException e) {

            e.printStackTrace();

        } catch (ParseException ex) {
            Logger.getLogger(SyncManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        return message;
    }

//    public static void printLog(String host){
//        try{
//            FileWriter outFile = new FileWriter("SyncManagerErrorLogFile.txt");
//            PrintWriter out = new PrintWriter(outFile);
//            out.println(host);
//            out.close();
//        }catch(IOException ex){
//            
//        }
//    }
}
