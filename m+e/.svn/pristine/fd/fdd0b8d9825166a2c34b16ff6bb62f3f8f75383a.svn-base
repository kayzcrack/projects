/* 
*---James. This console programme test the ease of using SQlite as an alternative to MySQL for writing embedded databases
-- This is the JDBC, the prior was the connector
**/
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class SQliteJDBC
{
  public static void main(String[] args) throws ClassNotFoundException
  {
    // load the sqlite-JDBC driver using the current class loader
    Class.forName("org.sqlite.JDBC");
    
    Connection connection = null;
    try
    {
      // create a database connection
	  //One remarkable thing about this db connection is that if the database does not exist
	  // the DriverManager automatically creates it
      connection = DriverManager.getConnection("jdbc:sqlite:IndicatorsMonitors.db");
      Statement statement = connection.createStatement();
      statement.setQueryTimeout(30);  // set timeout to 30 sec.
      
      statement.executeUpdate("drop table if exists M_EDataSet");
      statement.executeUpdate("create table M_EDataSet (indicatorName string, value string, remark string)");
      statement.executeUpdate("insert into M_EDataSet values('Data Availability', '20', 'This measures data availableness')");
      statement.executeUpdate("insert into M_EDataSet values('Data Consistency', '30', 'This measures alignment between captured data')");
	  statement.executeUpdate("insert into M_EDataSet values('Data Validity', '45', 'This measures correctness of captured data')");
      ResultSet rs = statement.executeQuery("select * from M_EDataSet");
      
	  while(rs.next())
      {
        // read the result set
        System.out.println("name = " + rs.getString("indicatorName"));
        System.out.println("value = " + rs.getString("value"));
		System.out.println("remarks = " + rs.getString("remark"));
		
		//System.out.println("id = " + rs.getInt("value"));
		//System.out.println("id = " + rs.getInt("remark"));
		
      }
    }
    catch(SQLException e)
    {
      // if the error message is "out of memory", 
      // it probably means no database file is found
      System.err.println(e.getMessage());
    }
    finally
    {
      try
      {
        if(connection != null)
          connection.close();
      }
      catch(SQLException e)
      {
        // connection close failed.
        System.err.println(e);
      }
    }
  }
}