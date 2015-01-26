/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.quanteq.syncmanager.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author voti
 */
public class TestService {

    public static void main(String[] args) {
        Consume();
    }

    public static void Consume() {
         BufferedReader reader=null;
        try {
            String url = "http://sdg.quanteq.com/~mtchuente/police/ws.php";
            String charset = "UTF-8";  // Or in Java 7 and later, use the constant: java.nio.charset.StandardCharsets.UTF_8.name()
            String params;
            String op = "addOfficer";
            String officerID = "INSP15";
            String fullName = "Martial Tchuente P.";
            String gender = "m";
            String userName = "tester";
            params = "op=" + op + "&officerID=" + officerID + "&fullName=" + fullName + "&gender=" + gender + "&userName=" + userName;            // ...


            URLConnection connection = new URL(url).openConnection();
            connection.setDoOutput(true); // Triggers POST.
            connection.setRequestProperty("Accept-Charset", charset);
            connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=" + charset);

            try (OutputStream output = connection.getOutputStream()) {
                output.write(params.getBytes(charset));
                            System.out.println(output);

            }
            
            InputStream response = connection.getInputStream();
            
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(TestService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (MalformedURLException ex) {
            Logger.getLogger(TestService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(TestService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
