/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.quanteq.syncmanager.controller;

import com.quanteq.syncmanager.bl.Pivot;
import com.quanteq.syncmanager.model.Suspect;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.SQLException;
import java.util.ArrayList;
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
    
    public static void main(String[] args) {
        syncRecords();
        computeSleepTime();
    }

    public static void syncRecords() {
        
        List<Suspect> unsyncedRecord = new ArrayList();
        boolean newRecordsExist = false;
        final int BATCH_SIZE = 5;
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
                unsyncedRecord = new Pivot().fetchUnflaggedRecords(BATCH_SIZE);
                System.out.println(BATCH_SIZE + " Unsynchronized records fetched");
               // System.out.println(unsyncedRecord);
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
                System.out.println("Uploading " + BATCH_SIZE + " records to online database ....");
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
    
    public static void goToSleep(int duration){
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
           if(SEED >= MAX_DELAY){
               SEED = 1;
               System.out.println("Maximum delay reached");
           }else{
              SEED = SEED * 2; 
           }
            
        } else {
            SEED = 1;
        }

        System.out.println("Time to sleep is: " + SEED + " seconds");
        //goToSleep(SEED);
        return SEED;
    }

}
