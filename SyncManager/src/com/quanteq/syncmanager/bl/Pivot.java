/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.quanteq.syncmanager.bl;

import com.quanteq.syncmanager.dao.DAO;
import com.quanteq.syncmanager.model.Biometric;
import com.quanteq.syncmanager.model.Case;
import com.quanteq.syncmanager.model.Suspect;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author voti
 */
public class Pivot {
    ResultSet rs,rs1,rs2;
    CallableStatement cs;
    Connection conn;
    DAO dao = new DAO();
    
   public List<Suspect> fetchUnflaggedRecords(int BATCH_SIZE) throws SQLException{
        List<Suspect> suspectList = new ArrayList();
        rs = dao.fetchUnflaggedRecords(BATCH_SIZE);
            while(rs.next()){
                Suspect s = new Suspect();
                s.setID(rs.getString("ID"));
                s.setFullName(rs.getString("FullName"));
                s.setGenderID(rs.getString("GenderID"));
                s.setAge(rs.getInt("Age"));
                s.setPhoneNumber(rs.getString("PhoneNumber"));
                s.setDateEnrolled(rs.getDate("DateEnrolled"));
                s.setEnroller(rs.getString("Enroller"));
                s.setGroup(rs.getString("Class"));
                s.setSync(rs.getInt("Sync"));
               
//                System.out.println(rs.getString("ID"));
//                System.out.println(rs.getString("FullName"));
//                System.out.println(rs.getInt("Age"));
                
                List<Case> caseList = new ArrayList();
                rs1 = dao.getCase(rs.getString("ID"));
                while (rs1.next()) {
                    Case c = new Case();
                    c.setSuspectID(rs1.getString("SuspectID"));
                    c.setEntryNumber(rs1.getInt("EntryNumber"));
                    c.setCrime(rs1.getString("Crime"));
                    c.setCrime_Date(rs1.getDate("CrimeDate"));
                    c.setDateReported(rs1.getDate("DateReported"));
                  //  System.out.println(rs1.getDate(4));
                   // c.setDateReported(rs1.getDate("DateReported"));
                    caseList.add(c);

//                    System.out.println(rs1.getString("SuspectID"));
//                    System.out.println(rs1.getString("EntryNumber"));
//                    System.out.println(rs1.getString("Crime"));
//                   System.out.println("ffffffffffffffffff:" + rs1.getString("DateReported"));
//                    System.out.println(" SuspectID  " +  rs.getString("ID") + " Name  " + rs.getString("FullName") + " Case  " +
//                            rs1.getString("Crime"));
               }
                
                List<Biometric> biometricList = new ArrayList();
                rs2 = dao.getBiometric(rs.getString("ID"));
                while(rs2.next()){
                    Biometric b = new Biometric();
                    b.setId(rs2.getString("ID"));
                    b.setTypeid(rs2.getString("TypeID"));
                    b.setSubtypeid(rs2.getString("SubTypeID"));
                    b.setData(rs2.getString("data"));
                    biometricList.add(b);
                    
                  //  System.out.println(rs2.getString("ID"));
                  //  System.out.println(rs2.getString("TypeID"));
                  //  System.out.println(biometricList);
                   // System.out.println(rs2.getString("data"));
                }
                 
                 s.setBiometricList(biometricList);
                 s.setCaseList(caseList);
                 suspectList.add(s);

            }
        return suspectList;
    }

    public boolean checkUnflaggedRecords() throws SQLException {
       boolean checkUnflagged = dao.checkUnflaggedRecords();
       if(checkUnflagged){
           return true;
       }else{
           return false;
       }
    }

    public ResultSet flagSuspect(String suspectID)throws SQLException {
        boolean flagRecord = dao.flagRecord(suspectID);
        return null;
    }
        
}
