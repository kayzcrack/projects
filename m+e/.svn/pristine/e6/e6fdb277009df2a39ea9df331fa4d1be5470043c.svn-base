<?php require_once("includes/session.php"); ?>
<?php

 if (empty($_SESSION["fullName"]))
    {
       header("Location:../index.php");
    }
?>
<?php  
	if($_POST['submit'] != ""){
		
		$roleId = trim($_POST['rid']);
		$description = trim($_POST['desc']);
		$userName = trim($_POST['uname']);
		$permission = trim($_POST['permission']);
		$url = "http://localhost/m+eWebService/addUserRole";
		$post = "roleid=$roleId&description=$description&username=$userName&permission=&permission";
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
						  $msg = "User Role successfully added"];
						  
							
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
					
			
		}
		
	
		
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
      <h3>Add  User Role</h3>  <h6>Note: fields with * are required.</h6></div></td>
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
          <td colspan="2"><?php echo $msg; ?>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td width="15%">&nbsp;</td>
          <td width="15%">role id </td>
          <td width="30%"><input type="text" name="rid" id="textfield" tabindex="5" /></td>
          <td width="32%">&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>description</td>
          <td><input type="text" name="desc" id="textfield2" tabindex="10" /></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>Username</td>
          <td><input type="text" name="uname" id="textfield3" tabindex="15" /></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>permission</td>
          <td><input type="text" name="permission" id="textfield4" tabindex="20" /></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;&nbsp;&nbsp;</td>
          <td><input type="submit" name="submit" id="submit" value="submit" tabindex="25"  class="bt"/>
            <input type="reset" name="button2" id="button2" value="  reset " tabindex="30"  class="bt"/></td>
          <td>&nbsp;</td>
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