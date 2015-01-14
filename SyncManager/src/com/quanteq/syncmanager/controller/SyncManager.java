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
        syncedRecords();
    }

    public static void syncedRecords() {
        int size = 0;
        short SLEEP_TIME = 10000;
        final int BATCH_SIZE = 5;
        boolean newRecordsExist = new Pivot().checkUnflaggedRecords();
        List<Suspect> unsyncedRecord = new ArrayList();
        if (newRecordsExist) {
            System.out.println("Found new records");
            unsyncedRecord = new Pivot().fetchUnflaggedRecords(BATCH_SIZE);

            // check if unsynchrecords where fecthed.
            if (!unsyncedRecord.isEmpty()) {
                //System.out.println(unsyncedRecordList);
                System.out.println(BATCH_SIZE + " Unsynchronized records fetched");

                if (isNetworkAvailable()) {
                    System.out.printf("Network connection OK!");
                } else {
                    System.out.printf("No network connection, please check connection and try again");
                    System.out.println("Going to sleep for  "  + SLEEP_TIME + "  Milliseconds");
                    sleepTime(SLEEP_TIME);
                }

            } else {
                System.out.println(size + "Records fetched");
                System.out.println("Going to sleep for  "  + SLEEP_TIME + "  Milliseconds");
                sleepTime(SLEEP_TIME);
            }

        } else {
            System.out.println(size + "  New records where found");
            System.out.println("Going to sleep for  "  + SLEEP_TIME + "  Milliseconds");
            sleepTime(SLEEP_TIME);
            syncedRecords();
            
        }
    }
    
    public static boolean isNetworkAvailable() {
        boolean check = false;
        try {
            
            InetAddress[] addresses = InetAddress.getAllByName("www.google.com");
            if (addresses != null) {
                check = true;
            } else {
                check = false;
            }
        } catch (UnknownHostException ex) {
             System.out.println("No network connection, please check connection and try again");
           // Logger.getLogger(SyncManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        return check;
    }
    
    public static void sleepTime(short duration){
        try {
            Thread.sleep(duration);
        } catch (InterruptedException ex) {
            Logger.getLogger(SyncManager.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
