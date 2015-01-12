<?php require_once("includes/session.php"); ?>
<?php

 if (empty($_SESSION["fullName"]))
    {
       header("Location:../index.php");
    }
?>
<?php  
	if(isset($_POST['submit'])){
		$addresstypeId = trim($_POST['atypeid']);
		$countryCode = trim($_POST['ccode']);
		$AULevel1Id = trim($_POST['aul1']);
		$AULevel2Id = trim($_POST['aul2']);
		$AULevel3Id = trim($_POST['aul3']);
		$respondentId = trim($_POST['rid']);
		$address1 = trim($_POST['addr1']);
		$address2 = trim($_POST['addr2']);
		$userName = $_SESSION['full Name'];
		$permission = $_SESSION['permission'];
		$url = "http://localhost/m+eWebService/addAddress";
$post = "addresstypeid=$addresstypeId&ccode=$countryCode&aul1id=$AULevel1Id&aul2id=&AULevel2Id&aul3id=$AULevel3Id&respondentid=$respondentId&address1=$address1&address2=$address2&username=$userName$permission=$permission";
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
						  $msg = "Address successfully added";
						  
							
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
 <script type="text/javascript" src="jquery.js"></script>
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
      <h3>Add Address</h3>  <h6>Note: fields with * are required.</h6></div></td>
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
          <td width="17%">address type id</td>
          <td width="26%">
            <input type="text" name="atypeid" id="textfield" tabindex="5" />
            <strong class="asterix">* </strong></td>
          <td width="26%">AU level 2 id</td>
          <td width="31%"><input type="text" name="aul2" id="textfield6" tabindex="20" /> <strong class="asterix">* </strong></td>
        </tr>
        <tr>
        
<script>

$(document).ready(function(){
						   
$.post('http://localhost/m+eWebService/getCountries', function(data){
			var pushedData = jQuery.parseJSON(data);
			//document.write(data);
			var htmldata = "";
			htmldata = htmldata + '<option>select</option>';
			$.each(pushedData.response, function(i, serverData){
			htmldata = htmldata  + '<option value=' + serverData.CountryCode + '> ' + serverData.Name +'</option>'; 						
				});
				$('#show-list').html(htmldata);
					
		
			});
		
	
	}); 
</script>
          <td>country code</td>
          <td><select name="cc" id="show-list" tabindex="10">
          </select>            <strong class="asterix">* </strong></td>
          <td>AU level 3 id</td>
          <td><input type="text" name="aul3" id="textfield7" tabindex="25" /> <strong class="asterix">* </strong></td>
        </tr>
        <tr>
          <td>AU level 1 id</td>
          <td><input type="text" name="aul1" id="textfield3" tabindex="15" /> <strong class="asterix">* </strong></td>
          <td>respondent id</td>
          <td><input type="text" name="rid" id="textfield8" tabindex="30" /> <strong class="asterix">* </strong></td>
        </tr>
        <tr>
          <td>address line 1</td>
          <td colspan="3"><input name="addr1" type="text" id="textfield2" tabindex="17" size="70" /> <strong class="asterix">* </strong></td>
          </tr>
        <tr>
          <td>address line 2</td>
          <td colspan="2"><input name="addr2" type="text" id="textfield4" tabindex="19" size="40" /></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td><input type="submit" name="submit" id="submit" value="submit" tabindex="35"  class="bt"/></td>
          <td><input type="reset" name="button2" id="button2" value="  reset " tabindex="40"  class="bt"/></td>
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