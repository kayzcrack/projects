/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sync;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author voti
 */
public class MySQLConnection {

    private static Connection mysqlConn;

    public static Connection getConnection() {
        if (mysqlConn == null) {
            try {
                String host = "jdbc:mysql://localhost:3306/sync";
                String uname = "root";
                String password = "password";
                mysqlConn = DriverManager.getConnection(host, uname, password);
            } catch (SQLException ex) {
                Logger.getLogger(MySQLConnection.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return mysqlConn;
    }
}
