 <script type="text/javascript" src="jquery.js"></script>      
 <script type="text/javascript">
 // $('#submit').click(function() {
	//var human = "human";
	//});
 $(document).ready(function() {

 //if(human === compare){
$.post('http://localhost/m+eWebService/getRespondentInfo',{respondenttype:'facility'}, function(data){
			var pushedData = jQuery.parseJSON(data);
			//document.write(data);
			var htmldata = "";
			htmldata = htmldata + '<tr><th>Facility Id</th><th>Contact Id</th><th>Facility Status Id</th><th>Service Type Id</th><th>Address Type Id</th><th>Address Line 1</th><th>Address Line 2</th><th>Action</th></tr>';
			$.each(pushedData.response, function(i, serverData){
			htmldata = htmldata  + '<tr><td>' + serverData.FacilityID + '</td><td> ' + serverData.ContactID +'</td><td>' + serverData.FacilityStatusID + '</td><td>' + serverData.ServiceTypeID + '</td><td>' + serverData.AddressTypeID + '</td><td>' + serverData.AddressLine1 + '</td><td>' + serverData.AddressLine2 + '</td><td><a href="logic/updateQuestions.php?iid='+ serverData.FacilityID +'&qid='+ serverData.ContactID +'&qsid='+ serverData.FacilityStatusID +'&desc='+ serverData.ServiceTypeID +'&instruction='+ serverData.AddressTypeID +'&hint='+ serverData.AddressLine1 +'&tid='+ serverData.AddressLine2 +'"><img src="images/editImage.jpg" width="15" height="15" alt="Update" /></a></td></tr>'; 						
				});
				$('#viewIndicators').html(htmldata);
					
		
			});
		
}); 
</script>
