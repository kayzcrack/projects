/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.quanteq.syncmanager.model;

import java.util.Date;



/**
 *
 * @author voti
 */
public class Suspect {
    private String ID,SuspectID,Crime,FullName, GenderID,PhoneNumber,Enroller,group;
    private Date DateEnrolled, Crime_Date,DateReported;
    private int sync, Age, EntryNumber;
    
    
    // setters and getters for suspect model
    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public String getFullName() {
        return FullName;
    }

    public void setFullName(String FullName) {
        this.FullName = FullName;
    }

    public int getSync() {
        return sync;
    }

    public void setSync(int sync) {
        this.sync = sync;
    }

    public int getAge() {
        return Age;
    }

    public void setAge(int Age) {
        this.Age = Age;
    }

    public String getGenderID() {
        return GenderID;
    }

    public void setGenderID(String GenderID) {
        this.GenderID = GenderID;
    }

    public String getPhoneNumber() {
        return PhoneNumber;
    }

    public void setPhoneNumber(String PhoneNumber) {
        this.PhoneNumber = PhoneNumber;
    }

    public Date getDateEnrolled() {
        return DateEnrolled;
    }

    public void setDateEnrolled(Date DateEnrolled) {
        this.DateEnrolled = DateEnrolled;
    }


    public String getEnroller() {
        return Enroller;
    }

    public void setEnroller(String Enroller) {
        this.Enroller = Enroller;
    }

    public String getGroup() {
        return group;
    }

    public void setGroup(String group) {
        this.group = group;
    }
    
    // setters and getters for case model
    public String getSuspectID() {
        return SuspectID;
    }

    public void setSuspectID(String SuspectID) {
        this.SuspectID = SuspectID;
    }

    public String getCrime() {
        return Crime;
    }

    public void setCrime(String Crime) {
        this.Crime = Crime;
    }

    public Date getCrime_Date() {
        return Crime_Date;
    }

    public void setCrime_Date(Date Crime_Date) {
        this.Crime_Date = Crime_Date;
    }

    public Date getDateReported() {
        return DateReported;
    }

    public void setDateReported(Date DateReported) {
        this.DateReported = DateReported;
    }
    
    
    public int getEntryNumber() {
        return EntryNumber;
    }

    public void setEntryNumber(int EntryNumber) {
        this.EntryNumber = EntryNumber;
    }
    
    

}
