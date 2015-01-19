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
    public static void main(String[] args) {
        syncRecords();
    }

    public static void syncRecords() {
        List<Suspect> unsyncedRecord = new ArrayList();
        boolean newRecordsExist = false;
        int size = 0;
        short SLEEP_TIME = 10000;
        final int BATCH_SIZE = 5;
        System.out.println("Checking for unsynchronized records ....");
        try {
            newRecordsExist = new Pivot().checkUnflaggedRecords();
        } catch (SQLException ex) {
            // print error here
            System.out.println(ex);
            // compute time to sleep
        }
        if (newRecordsExist) {
            System.out.println("Found unsynchronized  records");
            try {
                System.out.println("Fetching unsynchronized records in batches of " + BATCH_SIZE);
                unsyncedRecord = new Pivot().fetchUnflaggedRecords(BATCH_SIZE);
                System.out.println(BATCH_SIZE + " Unsynchronized records fetched");
            } catch (SQLException ex) {
                // print log
                System.out.println(ex);
                // compute time to sleep
            }
            // check if unsynchrecords where fecthed.

            System.out.println("Checking for network connection ....");
            if (isNetworkAvailable()) {
                System.out.println("Network connection OK!");
                System.out.println("Uploading " + BATCH_SIZE + " records to online database ....");
            } else {
                System.out.printf("No network connection, retrying after " + SLEEP_TIME + "  Milliseconds");
                System.out.println("\n");
                // compute time to sleep
                goToSleep(SLEEP_TIME);
            }

        } else {
            System.out.println("No new record found");
            System.out.println("Going to sleep for  " + SLEEP_TIME + "  Milliseconds");
            System.out.println("\n");
            goToSleep(SLEEP_TIME);

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
    
    public static void goToSleep(short duration){
        try {
            Thread.sleep(duration);
            syncRecords();
        } catch (InterruptedException ex) {
            Logger.getLogger(SyncManager.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
