/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.quanteq.syncmanager.dao;

import com.quanteq.syncmanager.connection.MysqlConnection;
import com.quanteq.syncmanager.model.Suspect;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author voti
 */
public class DAO {
    private final String CHECK_UNSYNCED_RECORDS = "{call checkFlag()}";
    private final String FETCH_UNSYNCED_RECORDS = "{call fetchFlag(?)}";
    
    ResultSet rs;
    CallableStatement cs;
    Connection conn;
    
    public boolean checkUnflaggedRecords() {
        int count = 0;
        boolean check = false;
        try {
            conn = MysqlConnection.getConnection();
            cs = conn.prepareCall(CHECK_UNSYNCED_RECORDS);
            rs = cs.executeQuery();
            while (rs.next()) {
                count = rs.getInt("counts");
            }
            //System.out.println(rs);
            if (count > 0) {
                check = true;
                //System.out.println(check);
            } else {
                check = false;
                //System.out.println(check);
            }

        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return check;
    }



    public ResultSet fetchUnflaggedRecords(int batch_size) {
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
    
}
