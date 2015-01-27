/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.quanteq.syncmanager.dao;

import com.quanteq.syncmanager.connection.MysqlConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author voti
 */
public class DAO {
    private final String CHECK_UNSYNCED_RECORDS = "{call checkRecordsForSync()}";
    private final String FETCH_UNSYNCED_RECORDS = "{call getSuspectForSync(?)}";
    private final String GET_SUSPECT_CASE = "{call getCase(?)}";
    private final String GET_ALL_CASES = "{call getAllCases()}";
    private final String GET_SUSPECT_CASES = "{call getCases(?)}";
    private final String FLAG_SUSPECT = "{call flagSyncedRecord(?)}";
    
    ResultSet rs;
    CallableStatement cs;
    Connection conn;
    
    public boolean checkUnflaggedRecords() throws SQLException {
        int count = 0;
        boolean check = false;
            conn = MysqlConnection.getConnection();
            cs = conn.prepareCall(CHECK_UNSYNCED_RECORDS);
            rs = cs.executeQuery();
            while (rs.next()) {
                count = rs.getInt("ReadyForSync");
            }
            //System.out.println(rs);
            if (count > 0) {
                check = true;
                //System.out.println(check);
            } else {
                check = false;
                //System.out.println(check);
            }
        return check;
    }



    public ResultSet fetchUnflaggedRecords(int batch_size) throws SQLException {
        try{
            conn = MysqlConnection.getConnection();
            cs = conn.prepareCall(FETCH_UNSYNCED_RECORDS);
            cs.setInt(1, batch_size);
            rs = cs.executeQuery();
        }catch(SQLException ex){
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getSuspectCase(String string) throws SQLException {
        try{
        conn = MysqlConnection.getConnection();
        cs = conn.prepareCall(GET_SUSPECT_CASE);
        cs.setString(1, string);
        rs = cs.executeQuery();
        }catch(SQLException ex){
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

//    public ResultSet getCase() throws SQLException{
//        conn = MysqlConnection.getConnection();
//        cs = conn.prepareCall(GET_ALL_CASES);
//        rs = cs.executeQuery();
//        return rs;
//    }

    public ResultSet getCase(String string) throws SQLException{
        conn = MysqlConnection.getConnection();
        cs = conn.prepareCall(GET_SUSPECT_CASES);
        cs.setString(1, string);
        rs = cs.executeQuery();
        return rs;
    }

    public boolean flagRecord(String suspectID)throws SQLException {
        boolean check = false;
        conn = MysqlConnection.getConnection();
        cs = conn.prepareCall(FLAG_SUSPECT);
        cs.setString(1, suspectID);
        rs = cs.executeQuery();
        return false;
        
    }
    
}
