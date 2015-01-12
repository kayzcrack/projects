/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sync;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.URL;
import java.net.UnknownHostException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author voti
 */
public class Sync {

    public static void main(String[] args) {
        // TODO code application logic here
       // checkNewRecords();
        checkNewRecords1();
        //isInternetReachable();
    }
    
    // method to check if records exist in database
    public static boolean checkNewRecords() {
        int size = 0;
        try {

            // call data access object class,
            // that inturns call a procedure to check the database.
            ResultSet success = new DAO().fetchUnflaggedRecords();
            if (success.next()) {
                success.last();
                size = success.getRow();
                success.beforeFirst();
                System.out.println(size + " New records where found");
            } else {
                System.out.println("No new records where found.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Sync.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    
     public static void checkNewRecords1() {
        int size = 0;
        int timeout = 2000;
        try {
          
            // call data access object class,
            // that inturns call a procedure to check the database.
            ResultSet success = new DAO().checkUnflaggedRecords();
            ResultSet success1 = new DAO().fetchUnflaggedRecords();

            if (success.next()) {
                success.last();
                size = success.getRow();
                success.beforeFirst();
                System.out.println(size + " New records where found");
                if (success1.next()) {
                    success1.last();
                    size = success1.getRow();
                    success1.beforeFirst();
                    while (success1.next()) {
//                        String name = success1.getString("name");
//                        int flag = success1.getInt("flag");
//                        System.out.println("name: " + name + " flag: " + flag);
                    }
                    System.out.println(size + " Records fetched");
                    
                    // check for internet connection
                    InetAddress[] addresses = InetAddress.getAllByName("www.google.com");
                    for(InetAddress  address : addresses){
                        if(address.isReachable(timeout))
                            System.out.printf("%s could not be contacted%n", address);
                        else{
                            System.out.printf("%s is reachable%n", address);
                        }
                    }
                   
                } else {
                    System.out.println(size + "Records fetched");
                }

            } else {
                System.out.println(size + "New records where found");
            }

        } catch (SQLException ex) {
            Logger.getLogger(Sync.class.getName()).log(Level.SEVERE, null, ex);
        } catch (UnknownHostException ex) {
            System.out.println("Site unreachable!");
        } catch (IOException ex) {
            Logger.getLogger(Sync.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }
    
    // method to fetch records from database.

    //method to check for connection to the internet through dummy request.
    public static boolean isInternetReachable() {

        try {
            //make a URL to a known source
            URL url = new URL("http://www.google.com");

            //open a connection to the source i.e the url
            HttpURLConnection urlConnect = (HttpURLConnection) url.openConnection();

            //try to receive data from the source
            // if there is no connection this would fail
            Object objData = urlConnect.getContent();
          //  System.out.println(objData);

            // if data is collected from the source it returns a success message.
            if (!objData.equals("")) {
                System.out.println("Success!, there is internet connection");
            }

        } catch (UnknownHostException e) {
            System.out.println("No internet connection, please check connection and try again");
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

}
