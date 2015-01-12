<?php require_once("includes/session.php"); ?>
<?php

 if (empty($_SESSION["fullName"]))
    {
       header("Location:../index.php");
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
      <h3> Enter respondent type</h3></div></td>
    </tr>
  <tr>
    <td><table width="90%" border="0" class="Menu">
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
          <td width="16%">&nbsp;</td>
          <td width="20%">respondent type</td>
          <td width="36%">
            <input type="text" name="rtype" id="textfield" tabindex="5" /></td>
          <td width="28%"><input type="submit" name="submit" id="submit" value="submit" tabindex="40"  class="bt"/></td>
        </tr>
        </table>
    </form>
    <?php
    	if(isset($_POST['rtype']))
		$respondenttype = $_POST['rtype'];
	?>
     <?php 
	   if(isset($respondenttype) &&($respondenttype == 'human')){
		include("viewRespondentInfo.php");   
	   }elseif(isset($respondenttype) &&($respondenttype == 'facility')){
		include("viewRespondentInfo_id_facility.php");    
	   }else
		   include("viewRespondentInfo_id_nil.php");
	   
		  ?>
     <table width="100%" id="viewIndicators">
        
      </table>
    </td>
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
