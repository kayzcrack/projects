/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package sync;

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
    private final String CHECK_UNSYNCED_RECORDS = "{call checkFlag()}";
    private final String FETCH_UNSYNCED_RECORDS = "{call fetchFlag()}";
    
    ResultSet rs;
    CallableStatement cs;
    Connection conn;
    
    public ResultSet checkUnflaggedRecords(){
        try {
            conn = MySQLConnection.getConnection();
            cs = conn.prepareCall(CHECK_UNSYNCED_RECORDS);
            rs = cs.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
    
      public ResultSet fetchUnflaggedRecords(){
        try {
            conn = MySQLConnection.getConnection();
            cs = conn.prepareCall(FETCH_UNSYNCED_RECORDS);
            rs = cs.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
    
}
