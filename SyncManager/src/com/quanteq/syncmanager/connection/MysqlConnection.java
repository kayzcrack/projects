/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.quanteq.syncmanager.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author voti
 */
public class MysqlConnection {
    private static Connection mysqlConn;

    public static Connection getConnection() {
        if (mysqlConn == null) {
            try {
                String host = "jdbc:mysql://172.16.3.20:3306/policelockupdiary_online";
                String uname = "sdg";
                String password = "sdg2009";
                mysqlConn = DriverManager.getConnection(host, uname, password);
            } catch (SQLException ex) {
                Logger.getLogger(MysqlConnection.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return mysqlConn;
    }
}
