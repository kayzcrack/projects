 <script type="text/javascript" src="jquery.js"></script>      
 <script type="text/javascript">
 // $('#submit').click(function() {
	//var human = "human";
	//});
 $(document).ready(function() {

 //if(human === compare){
$.post('http://localhost/m+eWebService/getRespondentInfo', {respondenttype:'nil'}, function(data){
			var pushedData = jQuery.parseJSON(data);
			//document.write(data);
			var htmldata = "";
			htmldata = htmldata + '<tr><th>Respondent Id</th><th>Human Id</th><th>Facility Id</th><th>Surname</th><th>MiddleName</th><th>FirstName</th><th>Gender</th><th>Marital Id</th><th>facility Type Id</th><th>Contact Id</th><th>Address Line 1</th><th>Address Line 2</th><th>Action</th></tr>';
			$.each(pushedData.response, function(i, serverData){
			htmldata = htmldata  + '<tr><td>' + serverData.RespondentID + '</td><td> ' + serverData.HumanID +'</td><td>' + serverData.FacilityID + '</td><td>' + serverData.Surname + '</td><td>' + serverData.MiddleName + '</td><td>' + serverData.FirstName + '</td><td>' + serverData.Sex + '</td><td>' + serverData.MaritalID + '</td><td>' + serverData.facilityTypeID + '</td><td>' + serverData.ContactID + '</td><td>' + serverData.AddressLine1 + '</td><td>' + serverData.AddressLine2 + '</td><td><a href="logic/updateQuestions.php?iid='+ serverData.RespondentID +'&qid='+ serverData.HumanID +'&qsid='+ serverData.FacilityID +'&desc='+ serverData.Surname +'&instruction='+ serverData.MiddleName +'&hint='+ serverData.FirstName +'&tid='+ serverData.Sex +'&hint='+ serverData.MaritalID +'&hint='+ serverData.facilityTypeID +'&hint='+ serverData.ContactID +'&hint='+ serverData.AddressLine1 +'&hint='+ serverData.AddressLine2 +'"><img src="images/editImage.jpg" width="15" height="15" alt="Update" /></a></td></tr>'; 						
				});
				$('#viewIndicators').html(htmldata);
					
		
			});
		
}); 
</script>
