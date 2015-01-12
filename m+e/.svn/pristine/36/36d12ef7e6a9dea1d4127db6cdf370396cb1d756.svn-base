<?php require_once("includes/session.php"); ?>
<?php

 if (empty($_SESSION["fullName"]))
    {
       header("Location:../index.php");
    }
?>
<?php  
	if(isset($_POST['submit'])){
		$uname = trim($_POST['uname']);
		$roleId = trim($_POST['roleid']);
		$password = trim($_POST['psw']);
		$rpassword = trim($_POST['rpsw']);
		$sname = trim($_POST['sname']);
		$fname = trim($_POST['fname']);
		$cperiod = trim($_POST['cp']);
		$sourceid = trim($_POST['sid']);
		$userName = $_SESSION['full Name'];
		$permission = $_SESSION['permission'];
		$url = "http://localhost/m+eWebService/addUser";
$post = "uname=$uname&pword=$password&sname=$sname&fname=&fname&sourceid=$sourceid&roleid=$roleId&capturedperiod=$cperiod&username=$userName$permission=$permission";
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
						  $msg = "User successfully added";
						  
							
					  }else{
						  	$msg = "Your request could not be processed, try again";
						  }
					}else{
						throw new Exception("Error Occured Making Call" . curl_error($handle));
					}
				}catch(Exception $e){
					$msg = ($e);
				}
					curl_close($handle);
					
		}else{
?>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>M and E Syetem</title>
<link href="css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
function validateForm()
{
var x=document.forms["cuser"]["uname"].value;
if (x==null || x=="")
  {
  alert("userName name must be filled out");
  return false;
  }
}
</script>
</head>

<body>
<table width="90%" border="1" align="center" class="tbl">
      <tr>
        <td><table width="75%" border="0" align="center" class="tblInner">
  <tr>
    <td height="156" colspan="2"><table width="100%" border="0" class="header">
      <tr>
        <td width="89%" height="130">M and E System</td>
        <td width="11%"><img src="images/evaluation.jpg" width="198" height="123" alt="Evaluation" /></td>
      </tr>
    </table></td>
    </tr>
   <tr>
    <td width="11%"><img src="images/monitor1.jpg" width="162" height="128" alt="Monitoring Team" /></td>
    <td width="89%"><div id="msg">
      <?php
echo "You are welcome:  ";
echo $_SESSION['fullName'];

echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;log in time: ". $_SESSION['TimeOfLogin'];
?> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="logic/logout.php">sign out</a>
    </div><div>
      <h3>Create New User</h3>  <h6>Note: fields with * are required.</h6></div></td>
    </tr>
  <tr>
    <td><table width="90%" border="0" class="Menu">
      <tr>
        <td>register user</td>
        </tr>
      <tr>
        <td>&nbsp;</td>
        </tr>
      <tr>
        <td>&nbsp;</td>
        </tr>
      <tr>
        <td>&nbsp;</td>
        </tr>
      <tr>
        <td>&nbsp;</td>
        </tr>
      <tr>
        <td>&nbsp;</td>
        </tr>
      <tr>
        <td>&nbsp;</td>
        </tr>
    </table></td>
    <td><form id="form1" name="cuser" method="post" action="" onsubmit="return validateForm()">
      <table width="100%">
        <tr>
          <td>&nbsp;</td>
          <td colspan="2"><?php if(isset($msg)) echo $msg; ?>            &nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td width="15%">username</td>
          <td width="31%">
            <input type="text" name="uname" id="textfield" tabindex="5" />
            <strong class="asterix">* </strong></td>
          <td width="18%">role id</td>
          <td width="36%"><input type="text" name="roleid" id="textfield6" tabindex="30" /> <strong class="asterix">* </strong></td>
        </tr>
        <tr>
          <td>password</td>
          <td><input type="text" name="psw" id="textfield2" tabindex="10" /> <strong class="asterix">* </strong></td>
          <td>captured period</td>
          <td><input type="text" name="cp" id="textfield7" tabindex="35" /> <strong class="asterix">* </strong></td>
        </tr>
        <tr>
          <td>comfirm password</td>
          <td><input type="text" name="rpsw" id="textfield3" tabindex="15" /> <strong class="asterix">* </strong></td>
          <td>source id</td>
          <td><input type="text" name="sid" id="textfield8" tabindex="40" /> <strong class="asterix">* </strong></td>
        </tr>
        <tr>
          <td>surname</td>
          <td><input type="text" name="sname" id="textfield4" tabindex="20" /> <strong class="asterix">* </strong></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>firstname</td>
          <td><input type="text" name="fname" id="textfield5" tabindex="25" /> <strong class="asterix">* </strong></td>
          <td><label>
            <input type="submit" name="submit" id="submit" value="submit" tabindex="45"  class="bt"/>
          </label></td>
          <td><label>
            <input type="reset" name="button2" id="button2" value="  reset " tabindex="50"  class="bt"/>
          </label></td>
        </tr>
      </table>
    </form></td>
  </tr>
  <tr>
    <td colspan="2" class="tdFooter">&copy; 2013 M and E System, all right reserved.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; powered by Quanteq</td>
  </tr>
</table>
        <p>&nbsp;</p></td>
      </tr>
    </table>
</body>
</html>
<?php  

		}

?>