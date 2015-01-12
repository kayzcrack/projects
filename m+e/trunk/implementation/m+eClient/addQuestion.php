<?php require_once("includes/session.php"); ?>
<?php

 if (empty($_SESSION["fullName"]))
    {
       header("Location:../index.php");
    }
?>
<?php  
	if(isset($_POST['submit'])){
		
	$indicatorId = $_POST['iid'];
	$questionId = $_POST['iid'];
	$description = $_POST['desc'];
	$instruction = $_POST['instruction'];
	$hint = $_POST['hint'];
	$resultType = $_POST['rtype'];
	
	$username = $_SESSION["username"];
	$permission = $_SESSION["permission"];

	$url = "http://localhost/m+eWebService/addQuestion";
		$post = "indicatorid=$indicatorId&questionid=$questionId&qstatusid=$questionId&description=$description&instruction=$instruction&hint=$hint&resulttype=$resultType&username=$username&permission=$permission";
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
						 
						  $msg = "Question added successfully";
						  
							
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
<script>
function showUser(str)
{
	if(str=="")
	{
		document.getElementById("txtHint").innerHTML="";
		return;
		}
		if(str=="select" || str=="select_many")
	{
		if(window.XMLHttpRequest)
		{
			xmlhttp=new XMLHttpRequest();
			}
			else
			{
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
				}
				xmlhttp.onreadystatechange=function()
				{
					if(xmlhttp.readyState==4 && xmlhttp.status==200)
					{
						document.getElementById("txtHint").innerHTML=xmlhttp.responseText;
						}
				}
	}
	xmlhttp.open("GET", "getTextFields.php", true);
	xmlhttp.send();
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
      <h3>Add Question</h3>  <h6>Note: fields with * are required.</h6></div></td>
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
          <td width="27%">indicator id</td>
          <td width="34%"><strong class="asterix">
            <input type="text" name="iid" id="textfield5" tabindex="10" />
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
          <td>question status id</td>
          <td><strong class="asterix">
            <input type="text" name="qsid" id="textfield4" tabindex="15" />
            * </strong></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>description</td>
          <td><strong class="asterix">
            <input type="text" name="desc" id="textfield6" tabindex="20" />
          *</strong></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>instruction</td>
          <td><select name="instruction" id="select" tabindex="25" onchange="showUser(this.value)">
         	 <option>-select-</option>
            <option value="yes/no">yes/no</option>
            <option value="number">number</option>
            <option value="true/false">true/false</option>
            <option value="select">select</option>
            <option value="select_many">select many</option>
          </select>            
            <strong class="asterix">*</strong></td>
          <td>&nbsp;
          <table id="txtHint">
          
          </table>
          </td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>hint</td>
          <td><input type="text" name="hint" id="textfield2" tabindex="30" />
            <strong class="asterix">*</strong></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>result type</td>
          <td><input type="text" name="rtype" id="textfield9" tabindex="32" />
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
