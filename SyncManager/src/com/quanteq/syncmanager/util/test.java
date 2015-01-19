/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.quanteq.syncmanager.util;

import com.quanteq.syncmanager.controller.SyncManager;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author voti
 */
public class test {

    static int SEED = 1;
    
    static int MAX_DELAY = 21600000; // not yet used
    static boolean SHOULD_CONTINUE = true; // not yet used

    public static void main(String[] args) {
        computeSleepTime();
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
        goToSleep(SEED);
        return SEED;
    }

    public static void goToSleep(int duration) {
        try {
            Thread.sleep(duration);
            computeSleepTime();
        } catch (InterruptedException ex) {
            Logger.getLogger(SyncManager.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
