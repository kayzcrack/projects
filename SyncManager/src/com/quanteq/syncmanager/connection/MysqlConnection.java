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
public class MysqlConnection{
    private static Connection mysqlConn;

    public static Connection getConnection() throws SQLException {
        if (mysqlConn == null) {
                String host = "jdbc:mysql://172.16.3.20:3306/policelockupdiary";
                String uname = "sdg";
                String password = "sdg2009";
                mysqlConn = DriverManager.getConnection(host, uname, password);   
        }
        return mysqlConn;
    }
}
