<?php require_once("includes/session.php"); ?>
<?php

 if (empty($_SESSION["fullName"]))
    {
       header("Location:../index.php");
    }
?>
<?php  
	if(isset($_POST['submit'])){
		
	$scheduleId = $_POST['sid'];
	$questionId = $_POST['iid'];
	$indicatorId = $_POST['iid'];
	$dom = $_POST['dom'];
	$dateCollected = $_POST['dcollected'];
	$teamId = $_POST['tid'];
	$score = $_POST['score'];
	$respondentId = $_POST['resptid'];
	$collector = $_POST['collector'];	
	$username = $_SESSION["username"];
	$permission = $_SESSION["permission"];

	$url = "http://localhost/m+eWebService/addMeasure";
		$post = "sid=$scheduleId&qid=$questionId&indicatorid=$indicatorId&dateofmeasurement=$dom&datecollected=$dateCollected&collector=$collector&teamid=$teamId&score=$score&respondentid=$respondentId&username=$username&permission=$permission";
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
							//echo $string;
					if($string){
					$json = json_decode($string, true);
					  if($json['status'] == 200)
					  {
						 
						  $msg = "Measure added successfully";
						  
							
					  }else{
						  	$msg = "Your request could not be processed, try again";
							
						  }
					}else{
						throw new Exception("Error Occured Making API Call" . curl_error($handle));
					}
				}catch(Exception $e){
					$msg = ($e);
				}
					curl_close($handle);
		}
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
      <h3>Add Measure</h3>  <h6>Note: fields with * are required.</h6></div></td>
    </tr>
  <tr>
    <td><table width="90%" height="218" border="0" class="Menu">
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
      <tr>
        <td>&nbsp;</td>
        </tr>
    </table></td>
    <td><form id="form1" name="cuser" method="post" action="" onsubmit="return validateForm()">
      <table width="100%">
        <tr>
          <td>&nbsp;</td>
          <td colspan="2"><?php if(isset($msg)) echo "<strong class=\"asterix\">".$msg."</strong>";?>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td width="16%">&nbsp;</td>
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
          <td width="27%">schedule id</td>
          <td width="34%"><strong class="asterix">
            <input type="text" name="sid" id="textfield5" tabindex="10" />
          *</strong></td>
          <td width="23%">&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>question id</td>
          <td><strong class="asterix">
            <input type="text" name="qid" id="textfield" tabindex="15" />
            * </strong></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>indicator id</td>
          <td><strong class="asterix">
            <input type="text" name="iid" id="textfield6" tabindex="20" />
          *</strong></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>date of measurement</td>
          <td><input type="text" name="dom" id="textfield3" tabindex="25" />
            <strong class="asterix">*</strong></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>date collected</td>
          <td><input type="text" name="dcollected" id="textfield2" tabindex="30" />
            <strong class="asterix">*</strong></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>collector</td>
          <td><input type="text" name="collector" id="textfield9" tabindex="32" />
            <strong class="asterix">*</strong></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>team id</td>
          <td><input type="text" name="tid" id="textfield4" tabindex="35" />
            <strong class="asterix">*</strong></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>score</td>
          <td><input type="text" name="score" id="textfield7" tabindex="37 />
            <strong class="asterix">
            <strong class="asterix">*</strong></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>respondent id</td>
          <td><input type="text" name="resptid" id="textfield8" tabindex="39" />
            <strong class="asterix">*</strong></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td><input type="submit" name="submit" id="submit" value="submit" tabindex="40"  class="bt"/>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" name="button2" id="button2" value="  reset " tabindex="50"  class="bt"/></td>
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
