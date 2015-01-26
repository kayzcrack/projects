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
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
 
public class ApacheHttpClientGet {
 
	public static void main(String[] args) {
	  try {
 
		DefaultHttpClient httpClient = new DefaultHttpClient();
		HttpGet getRequest = new HttpGet(
			"http://sdg.quanteq.com/~mtchuente/police/ws.php");
		getRequest.addHeader("accept", "application/json");
		HttpResponse response = httpClient.execute(getRequest);
                
            String op = "officer";
            String officerID = "INSP17";
            String params = "op=" + op + "&officerID=" + officerID;
            
            
            
                 
		if (response.getStatusLine().getStatusCode() != 200) {
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
 
	  } catch (ClientProtocolException e) {
 
		e.printStackTrace();
 
	  } catch (IOException e) {
 
		e.printStackTrace();
	  }
 
	}
 
}
