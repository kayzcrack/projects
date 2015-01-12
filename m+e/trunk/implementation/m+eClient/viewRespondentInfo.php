 <script type="text/javascript" src="jquery.js"></script>      
 <script type="text/javascript">
 // $('#submit').click(function() {
	//var human = "human";
	//});
 $(document).ready(function() {

 //if(human === compare){
$.post("http://localhost/m+eWebService/getRespondentInfo", {respondenttype:'Human'}, function(data){
			var pushedData = jQuery.parseJSON(data);
			//document.write('');
			var htmldata = "";
			htmldata = htmldata + '<tr><th>Human Id</th><th>Surname</th><th>MiddleName</th><th>FirstName</th><th>Date Of Birth</th><th>Gender</th><th>Marital Id</th><th>Address Type Id</th><th>Address Line 1</th><th>Address Line 2</th><th>Action</th></tr>';
			$.each(pushedData.response, function(i, serverData){
			htmldata = htmldata  + '<tr><td>' + serverData.HumanID + '</td><td> ' + serverData.Surname +'</td><td>' + serverData.MiddleName + '</td><td>' + serverData.FirstName + '</td><td>' + serverData.DateOfBirth + '</td><td>' + serverData.Sex + '</td><td>' + serverData.MaritalID + '</td><td>' + serverData.AddressTypeID + '</td><td>' + serverData.AddressLine1 + '</td><td>' + serverData.AddressLine2 + '</td><td><a href="logic/updateQuestions.php?iid='+ serverData.HumanID +'&qid='+ serverData.Surname +'&qsid='+ serverData.MiddleName +'&desc='+ serverData.FirstName +'&instruction='+ serverData.DateOfBirth +'&hint='+ serverData.Sex +'&tid='+ serverData.MaritalID +'&tid='+ serverData.AddressTypeID +'&tid='+ serverData.AddressLine1 +'&tid='+ serverData.AddressLine2 +'"><img src="images/editImage.jpg" width="15" height="15" alt="Update" /></a></td></tr>'; 						
				});
				$('#viewIndicators').html(htmldata);
					
		
			});
}); 
</script>
