/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.quanteq.syncmanager.bl;

import com.quanteq.syncmanager.controller.*;
import com.quanteq.syncmanager.dao.DAO;
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
public class Pivot {
    ResultSet rs;
    CallableStatement cs;
    Connection conn;

   public List<Suspect> fetchUnflaggedRecords(int BATCH_SIZE) {
        List<Suspect> suspectList = new ArrayList();
        rs = new DAO().fetchUnflaggedRecords(BATCH_SIZE);
                try{
            while(rs.next()){
                Suspect s = new Suspect();
                s.setCode(rs.getString("code"));
                s.setName(rs.getString("name"));
                s.setFlag(rs.getString("flag"));
                suspectList.add(s);
            }
        }catch(SQLException ex){
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE,null,ex);
        }
        return suspectList;
    }

    public boolean checkUnflaggedRecords() {
       boolean checkUnflagged = new DAO().checkUnflaggedRecords();
       if(checkUnflagged){
           return true;
       }else{
           return false;
       }
    }
        
}
