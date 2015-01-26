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
import java.net.MalformedURLException;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;

public class ApacheHttpClientPost {

    public static void main(String[] args) {

        try {

            DefaultHttpClient httpClient = new DefaultHttpClient();
            HttpPost postRequest = new HttpPost(
                    "http://172.16.3.51/~mtchuente/police/ws.php");

            String charset = "UTF-8";
            String params;
            String op = "addOfficer";
            String officerID = "INSP16";
            String fullName = "Martial Tchuente P.";
            String gender = "m";
            String userName = "tester";
            params = "op=" + op + "&officerID=" + officerID + "&fullName=" + fullName + "&gender=" + gender + "&userName=" + userName;
            
          // StringEntity input = new StringEntity("{\"qty\":100,\"name\":\"iPad 4\"}");
            StringEntity input = new StringEntity(params);
           // StringEntity input = new StringEntity("{\"op=\" + op + \"&officerID=\" + officerID + \"&fullName=\" + fullName + \"&gender=\" + gender + \"&userName=\" + userName}");
           // input.setContentType("application/json");
          //  postRequest.setEntity(input);
          //  System.out.println(input);
            postRequest.addHeader("Accept" , "text/xml");
            postRequest.setEntity(input);
            

            HttpResponse response = httpClient.execute(postRequest);
                //System.out.println(response);
            if (response.getStatusLine().getStatusCode() != 201) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + response.getStatusLine().getStatusCode());
            }

            BufferedReader br = new BufferedReader(
                    new InputStreamReader((response.getEntity().getContent())));

            String output;
            System.out.println("Output from Server .... \n");
            while ((output = br.readLine()) != null) {
                System.out.println(output);
            }

            httpClient.getConnectionManager().shutdown();

        } catch (MalformedURLException e) {

            e.printStackTrace();

        } catch (IOException e) {

            e.printStackTrace();

        }

    }

}
