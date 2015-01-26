/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.quanteq.syncmanager.util;

/**
 *
 * @author voti
 */
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

public class JavaNetURLRESTFulClient {

    private static final String targetURL = "http://sdg.quanteq.com/~mtchuente/police_v8/ws.php";

    public static void main(String[] args) {

        try {

            URL targetUrl = new URL(targetURL);

            HttpURLConnection httpConnection = (HttpURLConnection) targetUrl.openConnection();
            httpConnection.setDoOutput(true);
            httpConnection.setRequestMethod("POST");
            httpConnection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            httpConnection.setDoInput(true);

           
            String op = "addOfficer";
            String officerID = "INSP17";
            String fullName = "Oti Vincent O.";
            String gender = "m";
            String userName = "tester";
            String params = "op=" + op + "&officerID=" + officerID + "&fullName=" + fullName + "&gender=" + gender + "&userName=" + userName;
            
            
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
