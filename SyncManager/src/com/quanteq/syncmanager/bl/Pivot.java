/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.quanteq.syncmanager.bl;

import com.quanteq.syncmanager.dao.DAO;
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
    ResultSet rs,rs1;
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
                
                System.out.println(rs.getString("ID"));
                System.out.println(rs.getString("FullName"));
                System.out.println(rs.getString("GenderID"));
                System.out.println(rs.getString("Age"));
                System.out.println("\n");
                
              
                // call for suspect case
                rs1 = dao.getSuspectCase(rs.getString("ID"));
                   while(rs1.next()){
                       s.setSuspectID(rs1.getString("SuspectID"));
                       s.setEntryNumber(rs1.getInt("EntryNumber"));
                       s.setCrime(rs1.getString("Crime"));
                       s.setCrime_Date(rs1.getDate("CrimeDate"));
                       
                       System.out.println(rs1.getString("SuspectID"));
                       System.out.println(rs1.getString("EntryNumber"));
                       System.out.println(rs1.getString("Crime"));
                       System.out.println(rs1.getString("CrimeDate"));
                   }
 
                   
                // call for suspect investigative officer
                // call for suspect crime statement
                // call for suspect properties
                // call for suspect standing
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
        
}
