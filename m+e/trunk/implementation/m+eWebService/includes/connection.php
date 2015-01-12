<?php

require("includes/constants.php");
error_reporting(E_ALL - E_WARNING);
	class dbConnect{

		public $db;
		function dbLink(){
			
				$db = new mysqli(DB_SERVER, DB_USER, DB_PASS, DB_NAME);
				 
				 if($db->connect_errno > 0){
					//die('Connection failed [' . $db->connect_error .']');
					throw new Exception("Cannot connect to the database");
				}
				return $db;
			}
                        
   
}
	class tblQuery extends dbConnect{
	
		function proCall($methodName){
				
			$conn = new dbConnect;
			$result = $conn->dbLink()->query("CALL {$methodName}");
			if($result){
				$fresult = array();
				$i = 0;
			while($row=$result->fetch_assoc()){
				$fresult[] = $row;
				$i++;
			}
			return $fresult;
			}else{
				 throw new Exception("Procedure call failed");
				}
					
		}
             function proCallNoValue($methodName){
				
			$conn = new dbConnect;
			$result = $conn->dbLink()->query("CALL {$methodName}");
			if($result){
				$fresult = "Success";
				
			return $fresult;
			}else{
				 throw new Exception("Procedure call failed");
				}
					
		}

		
	}
		
		
?>