/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.quanteq.syncmanager.controller;

import com.quanteq.syncmanager.bl.Pivot;
import com.quanteq.syncmanager.model.Case;
import com.quanteq.syncmanager.model.Suspect;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.UnknownHostException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author voti
 */
public class SyncManager {

    static int SEED = 1;
    static int MAX_DELAY = 21600000;
    static boolean SHOULD_CONTINUE = false;
    private static final String targetURL = "http://sdg.quanteq.com/~mtchuente/police_v8/ws.php";

    public static void main(String[] args) {
        syncRecords();
        computeSleepTime();
    }

    public static void syncRecords() {

        List<Suspect> unsyncedRecords = new ArrayList();
        boolean newRecordsExist = false;
        final int BATCH_SIZE = 10;
        int count = 0;

        String suspectID;
        String fullName;
        String group;
        String phoneNumber;
        int age;
        Date dateEnrolled;
        String enroller;
        String genderID;
        String caseID = null; //same as suspectID
        String crime = null;
        int entryNumber = 0;
        Date dateReported = null;
        Date crimeDate = null;

        System.out.println("Checking for unsynchronized records ....");

        try {
            newRecordsExist = new Pivot().checkUnflaggedRecords();
        } catch (SQLException ex) {
            // print error here
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
                 //   System.out.println(suspects);
                    String addSuspect = "addSuspect";
                    suspectID = suspect.getID();
                    fullName = suspect.getFullName();
                    group = suspect.getGroup();
                    phoneNumber = suspect.getPhoneNumber();
                    age = suspect.getAge();
                    dateEnrolled = suspect.getDateEnrolled();
                    enroller = suspect.getEnroller();
                    genderID = suspect.getGenderID();
                    // call a service here to send to ODB
                    try{
                    addSuspect(addSuspect,suspectID,fullName,age,enroller,genderID);
                        System.out.println("Suspect personal data sent to online database.");
                    }catch(Exception ex){
                        ex.printStackTrace();
                    }

                    //  System.out.println(suspects.getCaseList());
                    for (Case suspectCase : suspect.getCaseList()) {
                        // System.out.println("This is the case: " + cases);
                        String addCase = "addCase";
                        caseID = suspectCase.getSuspectID();
                        crime = suspectCase.getCrime();
                        entryNumber = suspectCase.getEntryNumber();
                        dateReported = suspectCase.getDateReported();
                        crimeDate = suspectCase.getCrime_Date();
                        // call a service here to send to ODB
                         try {
                            addSuspect(addCase, caseID, crime, entryNumber, dateReported);
                            System.out.println("Suspect case(s)  sent to online database.");
                        } catch (Exception ex) {
                            ex.printStackTrace();
                        }
                    }

//                    System.out.println("FullName: " + fullName);
//                   System.out.println("SuspectID: " + suspectID);
//                    System.out.println("Group: " + group);
//                    System.out.println("PhoneNumber: " + phoneNumber);
//                    System.out.println("Age: " + age);
//                    System.out.println("DateEnrolled: " + dateEnrolled);
//                    System.out.println("Enroller: " + enroller);
//                    System.out.println("Gender: " + genderID);
//
//                    System.out.println("Crime: " + crime);
//                    System.out.println("CaseID: " + caseID);
//                    System.out.println("EntryNumber: " + entryNumber);
//                    System.out.println("DateReported: " + dateReported);
//                    System.out.println("CrimeDate: " + crimeDate);
//                    System.out.println("\n");

                }

                SHOULD_CONTINUE = false;
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
            goToSleep(computeSleepTime());

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

    public static void addSuspect(String operation, String suspectID, String fullName, 
            int age,  String enroller, String gender) {
        // code to call web service for saving data.
        try {

            URL targetUrl = new URL(targetURL);

            HttpURLConnection httpConnection = (HttpURLConnection) targetUrl.openConnection();
            httpConnection.setDoOutput(true);
            httpConnection.setRequestMethod("POST");
            httpConnection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            httpConnection.setDoInput(true);

            String params = "op=" + operation + "&suspectID=" + suspectID + "&fullName=" + fullName
                     + "&age" + age
                    + "&userName=" + enroller + "&gender=" + gender;

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
            System.out.println("Output from Server:\n");
            while ((output = responseBuffer.readLine()) != null) {
                System.out.println(output);
            }

            httpConnection.disconnect();

        } catch (MalformedURLException e) {

            e.printStackTrace();

        } catch (IOException e) {

            e.printStackTrace();

        }
    }
    
    public static void addCase(String operation,String suspectID,int entryNo,String crime,Date date){
                try {

            URL targetUrl = new URL(targetURL);

            HttpURLConnection httpConnection = (HttpURLConnection) targetUrl.openConnection();
            httpConnection.setDoOutput(true);
            httpConnection.setRequestMethod("POST");
            httpConnection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            httpConnection.setDoInput(true);

            String params = "op=" + operation + "&suspectID=" + suspectID + "&entryNo=" + entryNo
                     + "&crime" + crime + "&date=" + date;
                    

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
            System.out.println("Output from Server:\n");
            while ((output = responseBuffer.readLine()) != null) {
                System.out.println(output);
            }

            httpConnection.disconnect();

        } catch (MalformedURLException e) {

            e.printStackTrace();

        } catch (IOException e) {

            e.printStackTrace();

        }
    }

}
