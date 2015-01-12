/** 
 * ConnectSQLite.java 
 */  
//package com.javaworkspace.;  
  
import java.sql.Connection;  
import java.sql.DriverManager;  
import java.sql.ResultSet;  
import java.sql.Statement; 
import java.sql.PreparedStatement;
  
/** 
 * @author www.javaworkspace.com 
 *  http://www.javaworkspace.com/connectdatabase/connectSQLite.do
 */  
public class SqliteBasic {  

	static PreparedStatement pstmt;
    public static void main(String[] args) {  
  
        Connection connection = null;  
        ResultSet resultSet = null;  
        Statement statement = null;  
  
        try {  
            Class.forName("org.sqlite.JDBC");  
            connection = DriverManager  
                    .getConnection("jdbc:sqlite:C:\\SQLite\\me.db");  
            /*statement = connection.createStatement();  
            resultSet = statement  
                    .executeQuery("SELECT indicator FROM Monitoring");  
            while (resultSet.next()) {  
                System.out.println("EMPLOYEE NAME:"  
                        + resultSet.getString("indicator"));  */
						
			pstmt = connection.prepareStatement("insert into monitoring values (?,?,?)");		
		
		String num = " Total number of visits";
		String num2 = " rookies";
		String num3 = " marcus";
		
       
            pstmt.setString(1, num);
			pstmt.setString(2, num2);
			pstmt.setString(3, num3);
			
            pstmt.executeUpdate();
            //System.out.println(num); 
           
        } catch (Exception e) {  
            e.printStackTrace();  
        } finally {  
            try {  
                //resultSet.close();  
                //statement.close();  
                connection.close();  
            } catch (Exception e) {  
                e.printStackTrace();  
            }  
        }  
    }  
}  