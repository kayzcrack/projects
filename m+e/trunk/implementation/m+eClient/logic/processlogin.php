<?php require_once("includes/session.php"); ?>
<?php

if(isset($_POST['submit'])){
	
	$userName = trim($_POST['uname']);
	$password = trim($_POST['psw']);
	if(($userName!="") &&($password!=""))
	{
		
		//$url = "http://172.16.3.253/~ahassan/rwswork/addUser";
		$url = "http://localhost/m+eWebService/loginUser";
		$post = "username=$userName&password=$password";
			$handle = curl_init();
			curl_setopt_array(
			$handle,
			array(
					CURLOPT_URL => $url,
					CURLOPT_POST=> true,
					CURLOPT_POSTFIELDS => $post,
					CURLOPT_RETURNTRANSFER => true
			)
		);
			try{
					$string = curl_exec($handle);
					if($string){
					$json = json_decode($string, true);
					  if($json['status'] == 200)
					  {
						  $msg = "You are successfully loged in  " . $json['fullName'];
						  $_SESSION['username'] = $userName;
						   $_SESSION['fullName'] = $json['fullName'];
			 				$_SESSION['TimeOfLogin'] = $json['TimeOfLogin'];
							
							header("Location:../adminArea.php");
							
					  }else{
						  	$msg = "Log in failed, Please try again";
						  }
					}else{
						throw new Exception("Error Occured Making Call" . curl_error($handle));
					}
				}catch(Exception $e){
					$msg = ($e);
				}
					curl_close($handle);
					
			
		}
		echo $msg;
	
?>
<?php
	
	
}else{
	header("Location:../index.php");
}
?>

