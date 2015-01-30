/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.quanteq.syncmanager.model;

import java.util.Date;
import java.util.List;



/**
 *
 * @author voti
 */
public class Suspect {
    private String ID;
    String FullName;
    String GenderID;
    String PhoneNumber;
    String Enroller;
    String group;
    private Date DateEnrolled;
  //  private Date DateEnrolled;
    private int sync;
    private int Age;
    private List<Case> caseList;
    private List<Biometric> biometricList;
    
    
    
    
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

    public List<Case> getCaseList(){
        return caseList;
    }

    public void setCaseList(List<Case> caseList) {
        this.caseList = caseList;
    }

    public List<Biometric> getBiometricList() {
        return biometricList;
    }

    public void setBiometricList(List<Biometric> biometricList) {
        this.biometricList = biometricList;
    }
}
