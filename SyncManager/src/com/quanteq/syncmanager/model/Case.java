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
public class Case {
    
    private Date Crime_Date;
    private Date DateReported;
    String Crime;
    private int EntryNumber;
    String SuspectID;

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

    public String getCrime() {
        return Crime;
    }

    public void setCrime(String Crime) {
        this.Crime = Crime;
    }

    public int getEntryNumber() {
        return EntryNumber;
    }

    public void setEntryNumber(int EntryNumber) {
        this.EntryNumber = EntryNumber;
    }

    public String getSuspectID() {
        return SuspectID;
    }

    public void setSuspectID(String SuspectID) {
        this.SuspectID = SuspectID;
    }
}
