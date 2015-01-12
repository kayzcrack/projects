import java.sql.*;
import javax.sql.*;
import java.math.*;

public class BasicMySqlDB{

    static Connection con;
    static PreparedStatement pstmt;
    static Statement stmt;
    static ResultSet rs;

    public static void main(String[] args){

        try{
        
        Class.forName("com.mysql.jdbc.Driver").newInstance();
	
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/me?user=root&password=james");
        
        pstmt = con.prepareStatement("insert into monitoring values (?,?,?)");		
		
		String num = " Total number of visits";
		String num2 = " rookies";
		String num3 = " marcus";
		
       
            pstmt.setString(1, num);
			pstmt.setString(2, num2);
			pstmt.setString(3, num3);
			
            pstmt.executeUpdate();
            System.out.println(num);     

        } 
		
		catch(Exception ex)
		
		{
            System.out.println(ex);
        }
    }
}