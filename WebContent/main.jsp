<!--<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>-->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Flight Insurance Automation</title>
	</head>
	<link rel = "stylesheet" type = "text/css"
		href = "https://fonts.googleapis.com/css?family=Lato|Roboto|Raleway|Noto+Sans|Work+Sans|Gill+Sans|Open+Sans">
	<img id="Logo" src="Images/AIGVector.png" alt="Logo">
	<br>
  <script>
  var flag = <%=request.getAttribute("case")%>
  var policyId = <%=request.getAttribute("policyId")%>
	window.onload = function () {
		checkFlag();
		
    }
    function openTab(evt, tabID){
      var i, tabcontent, tablinks;

      tabcontent = document.getElementsByClassName("tabcontent");
      for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";

      }

      tablinks = document.getElementsByClassName("tablinks");
      for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
      }

      document.getElementById(tabID).style.display = "block";
      evt.currentTarget.className += " active";
    }
    function startTab() {
      document.getElementById("navAddPolicy").click();
      flag = "2";
    }
    function checkFlag() {
    	if (flag == "1") {
    		$('#addPolicyExst').fadeOut( function(){
			$('#policyMain').fadeIn();
			});
    		event.preventDefault();
    	}
    	else if (flag == "2") {
    		$('#lookupMain').fadeOut(function(){
			$('#policyInfo').fadeIn();
			});
    		event.preventDefault();
    	}
    	else if (flag == "3") {
    		$('#bookMain').fadeOut(function(){
			$('#bookP2').fadeIn();
			});
    	}
    	else if (flag == "4") {
    		$('#bookP2').fadeOut(function(){
			$('#bookP3').fadeIn();
			});
    	}
    	else if (flag == "5") {
    		$('#bookP3').fadeOut(function(){
			$('#payment').fadeIn();
			});
	
    	}
    	else {
    		startTab();
    	}
       	
    }
    /*function submitForm() {
    	if(plan == "S"){
    		document.getElementById("buyForm1").submit();
    	}
    	else if (plan == "G"){
    		document.getElementById("buyForm2").submit();
    	}
    	else if (plan == "P"){
    		document.getElementById("buyForm3").submit();
    	}
    	else 
    		document.getElementById("SubmitPayment").submit();
    		
    }*/
  </script>
  <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
  <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
  <script>
  
  </script>
	
	<div id="navBar" class="tab">
	  <button id="navAddPolicy" class="tablinks" onclick="openTab(event, 'addPolicyExst')">Add A Policy</button>
		<button id="navBook" class="tablinks" onclick="openTab(event, 'bookMain')">Book A Flight</button>
		<button id="navPerson" class="tablinks" onclick="openTab(event, 'lookupMain')">My Policy</button>
		<button id="navBusiness" class="tablinks" onclick="openTab(event, 'businessMain')">Business</button>
		<button id="navFeedback" class="tablinks" onclick="openTab(event, 'feedback')">Feedback</button>
	</div>
	<br>
	<body>
	<!-------------------------------------------ADD POLICY TO EXISTING FLIGHT --------------------------------- -->
	<div id="addPolicyExst" class="tabcontent">
		<h2>Add Insurance To An Existing Flight</h2>
		<div id="add">
			<br>
			<form id="what" action="findFlight" method="post">
				<br>
				<table id='exist' class="addPolicyTable">
						<tbody>
							<tr>
									<td>Confirmation Number:</td>
										<td><input type="text" name="ticketNum" id="ticketNum"></td>
							</tr>
							<tr>
										<td>Airline:</td>
										<td><select name="airline" id="airline">
												<option id="blank"></option>
												<option value="AA">American Airlines</option>
												<option value="DLT">Delta Airlines</option>
												<option value="UN">United Airlines</option>
											</select></td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
									<td><input type = "hidden" name = "type" value = "addPolicyExisting"></td>
							</tr>
						</tfoot>
				</table>
				<input id="addPolicy" type="button" class="button" value = "Add A Policy"/>
			</form>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
		</div>
			<div id="testButtons">
				<br>
			
			<form method="post" action="DelayedServlet" style="text-align: center; margin: 0, auto;" >

                      <input type="submit" value="Delay Flight" class="button special" />

                   </form>

                    <form method="post" action="Cancelled" style="text-align: center; margin: 0, auto;" >

                                 <input type="submit" value="Cancel Flight" class="button special" />

                    </form>

			<form method="post" action="Scheduled" style="text-align: center; margin: 0, auto;" >

                      <input type="submit" value="Set Scheduled" class="button special" />

               </form>

               <form method="post" action="Landed" style="text-align: center; margin: 0, auto;" >

                              <input type="submit" value="Land Flight" class="button special" />

                  </form>

			
			
			</div>
	</div>
	<script>

	$('#addPolicy').on('click', function(event){
		var ticketnum = $("#ticketNum").val();
		var airline = $("#airline").val();
		if(ticketnum == "") {
            alert('Please Enter Confirmation Number');
    	} else if ( $('#airline').val() == "") {
        	alert('Please Select An Airline');
    	} else {
			document.getElementById("what").submit();
			event.preventDefault();
    	}
    });
	
		
	</script>
	<!---------------------------------------------POLICY SECTION----------------------------------------------- -->
	<div id="policyMain" class="tabcontent">
            <br>
			<!-- Ticket Information Table -->
		<div id="policyTable">
			<br>
        <table class="TicketInfo" width="65%">
        	<thead>
           		 <tr>
     
					<th width="400"colspan="2"><font size="6" color="white" class="tableHead">Ticket Information</font></font></th>
            
            	</tr>
        </thead>
        <tbody>
           <tr>
               <td width="300">
            
             <font size="4">Ticket Number:</font>
                       <td><%=request.getAttribute("ticketNumber")%></td>
               </td>
           </tr>
            
           <tr>
           <td width="300">
           <font size="4">Customer Name:</font>
           <td><%=request.getAttribute("firstName")%> <%=request.getAttribute("lastName") %></td>
           </td>
           </tr>

           <tr>
           <td width="350">
           <font size="4">Flight Number:</font>
           <td><%=request.getAttribute("flightNumber")%></td>
           </td>
           </tr>             
           
           <tr>
           <td width="350">
           <font size="4">Flight Carrier:</font>
               <td> <%=request.getAttribute("flightCarrier")%></td>
           </td>
           </tr>
           
           <tr>
           <td width="350">
           <font size="4">Flight Departure Time/Location:</font>
               </td><td><%=request.getAttribute("departureTime")%> <%=request.getAttribute("origin")%></td>
           </tr>

           <tr>
           <td width="350">
           <font size="4">Flight Arrival Time/Location:</font>
               </td><td><%=request.getAttribute("arrivalTime")%> <%=request.getAttribute("destination")%></td>
           </tr>
                </tbody>
			</table>
			 <br>
			<br>
	<table class="GeneratedTable">
   <thead>
        <tr>
            <th> <font size="6" color="white" class="tableHead"> Policy Benefits </font></th>
                <th width="100">
            <br /><font color="silver" size="6" class="policyType">Silver</font> <br>  <br />
                  <form id= "buyForm1" action= "PickPolicy" method="post">
				   <font color="black" size="6">$20</font>  <br /> <br />
				   <input type="hidden" name="ticketNumber" value= <%=request.getAttribute("ticketNumber")%> > 
				   
				   <input id = "planA" type ="hidden" name="policyPrice" value="20">
				   <button type="submit" id="buyButton1" class="policyBuy">BUY</button>
                   </form>
            </th>

            <th width="100">
            <br /><font color="#a99d18" size="6" class="policyType">Gold</font> <br> <br/ >
                <form id="buyForm2" action= "PickPolicy" method="post">
				<font color="black" size="6">$30</font> <br /> <br /> 
				<input type="hidden" name="ticketNumber" value= <%=request.getAttribute("ticketNumber")%> >
				<input id="planB" type = "hidden" name="policyPrice" value="30">
				<button type="submit" id="buyButton2"  class="policyBuy">BUY</button>
                </form>
            </th>
            <th width="100">
            <br /> <font color="#ffffff" size="6" class="policyType">Platinum</font> <br> <br />
               <form id="buyForm3" action= "PickPolicy" method="post">
                    <font color="black" size="6">$40</font><br /><br />
                    <input type="hidden" name="ticketNumber" value= <%=request.getAttribute("ticketNumber")%> >
                    <input id="planC" type = "hidden" name="policyPrice" value="40">
                    <button type="submit" id="buyButton3" class="policyBuy">BUY</button>
                </form>
			</th>
			
       </tr>
       </thead>
       <tbody>
       <tr>
		<td class="moreInfo">Flight Cancellations  <span class="moreInfoText">100% of ticket cost will be refunded</span><img src="http://image.flaticon.com/icons/png/512/62/62903.png" width="12" height="11" alt="information" /></td>
				<td>&#x2713;</td>
                <td>&#x2713;</td>
                <td>&#x2713;</td>
            </tr>
            <tr>

                <td class="moreInfo">Flight Departure Delay <span class="moreInfoText">10% of ticket cost times minutes delayed will be refunded</span><img src="http://image.flaticon.com/icons/png/512/62/62903.png" width="12" height="11" alt="information" /></td>	
				<td></td>
                <td>&#x2713;</td>
                <td>&#x2713;</td>
            </tr>
            <tr>
                <td class="moreInfo">Flight Arrival Delay <span class="moreInfoText">15% of ticket cost times minutes delayed will be refunded</span><img src="http://image.flaticon.com/icons/png/512/62/62903.png" width="12" height="11" alt="information" /></td>
				<td></td>
                <td>&#x2713;</td>
                <td>&#x2713;</td>
            </tr>
            <tr>
                <td class="moreInfo">Accidental Death and/or Dismemberment <span class="moreInfoText">150% of ticket cost will be refunded</span><img src="http://image.flaticon.com/icons/png/512/62/62903.png" width="12" height="11" alt="information" /></td>
				<td></td>
                <td></td>
                <td>&#x2713;</td>
            </tr>
        </tbody>
	</table>
	<br>
	</div>
		<br>
		<input type='submit' id='backPolicyMain' class='button' value='Back'>	
	</div>
	<script>
	
	/*	$('#buyButton1').on('click', function(event){
			plan = "S";
			$('#policyCost').html("$20")
			
		});
		
		$('#buyButton2').on('click', function(event){
			plan = "G";
			$('#policyCost').html("$30")
		});
		
		$('#buyButton3').on('click', function(event){
			plan = "P";
			$('#policyCost').html("$40")
		});

		$('.policyBuy').on('click', function(event){
			$('#policyMain').fadeOut( function(){
				$('#payment').fadeIn();
			});
			event.preventDefault();
		});*/

		$('#backPolicyMain').on('click', function(event){
			$('#policyMain').fadeOut(function(){
				$('#addPolicyExst').fadeIn();
			});
			event.preventDefault();
		});

	</script>

	<!--------------------------------------------BOOKING SECTION----------------------------------------------- -->
	<div id="bookMain" class="tabcontent">
		 <h2>Start Your Trip</h2>
		<div id="book">
			<br>
	     <form id="BookFlight" action = "BookFlight" method="post">
		   <table class= "bookTable">
			   <tbody> 
    		     <tr>
      		        <td>Departure Airport:<span class="required" style="color: rgba(196, 18, 48, 0.8)">*</span></td>
      			    <td><input type="text" name="depAir"/></td>
    		     </tr>
    		     <tr>
    			    <td>Arrival Airport:<span class="required" style="color: rgba(196, 18, 48, 0.8)">*</span></td>
      			    <td><input type="text" name="arrAir"/></td>
   	 		     </tr>
   	 		     <tr>
    			    <td>Departure Date:<span class="required" style="color: rgba(196, 18, 48, 0.8)">*</span></td>
      			    <td><input type="text" id="dateBox" name="dateBox" placeholder="MM/DD/YYYY"></td>
   	 		     </tr>
   	 		     <tr>
    			    <td>Number of Passengers:<span class="required" style="color: rgba(196, 18, 48, 0.8)">*</span></td>
      			    <td><input type="text" name="numPassengers"/></td>
					 </tr>
				</tbody>
				<tfoot>
					<tr>
				      <td><input type = "hidden" name = "type" value = "bookFlight"></td>
					</tr>
				</tfoot>
  		    </table>

		   <h4>*Required</h4>

		    <input id="findFlight" type="submit" class="button" value = "Find A Flight"/>
		</form>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
		</div>
	</div>
	<script>
		
		
		$('#navBook').on('click', function(){
			$('#bookMain').show('medium');
		});


		$('#findFlight').on('click', function(event){
			document.getElementById("BookFlight").submit();
			/*$('#bookMain').fadeOut(function(){
				$('#bookP2').fadeIn();
			});*/
			event.preventDefault();
		});

		
	</script>
	<!-- ------------------------------------------BOOKING P2 SECTION----------------------------------------------- -->
	<!-- Flight Booking Script -->
	<script>
	$(document).ready(function(){
		$('#nextButton').prop('disabled', true);
		$('input:checkbox').prop("checked", false);
		$(".planeBox").on('click', function() {
		var $box = $(this);
		if ($box.is(":checked")) {
			var flightBoxes = "input.planeBox:checkbox[name='" + $box.attr("name") + "']";
			$('#hiddenChecks').val($(this).val());
			$(flightBoxes).prop("checked", false);
			$box.prop("checked", true);
			$('#policyT').slideUp('medium');
			$('#policyT').slideDown('medium');
			$('#nextButton').prop('disabled', false);
		} else {
			$box.prop("checked", false);
			$('#policyT').slideUp('medium');
			$('#nextButton').prop('disabled', true);
		} 	
		});
		$("#silver").on('click', function() {
		var $box = $(this);
		if ($box.is(":checked")) {
			var policyChecked = "silver";
			$("#policyCheckbox").val(policyChecked);
			//$('.hiddenChecks').val() = $(this).val();
			var policyBoxes = "input.radio:checkbox[name='" + $box.attr("name") + "']";
			$(policyBoxes).prop("checked", false);
			$box.prop("checked", true);
		} else {
			$box.prop("checked", false);
		}
		});
		$("#gold").on('click', function() {
			var $box = $(this);
			if ($box.is(":checked")) {
				var policyChecked = "gold";
				$("#policyCheckbox").val(policyChecked);
				//$('.hiddenChecks').val() = $(this).val();
				var policyBoxes = "input.radio:checkbox[name='" + $box.attr("name") + "']";
				$(policyBoxes).prop("checked", false);
				$box.prop("checked", true);
			} else {
				$box.prop("checked", false);
			}
			});
		$("#platinum").on('click', function() {
			var $box = $(this);
			if ($box.is(":checked")) {
				var policyChecked = "platinum";
				$("#policyCheckbox").val(policyChecked);
				//$('.hiddenChecks').val() = $(this).val();
				var policyBoxes = "input.radio:checkbox[name='" + $box.attr("name") + "']";
				$(policyBoxes).prop("checked", false);
				$box.prop("checked", true);
			} else {
				$box.prop("checked", false);
			}
			});
		$('#nextButton').on('click', function() {
			if($('.radio').is(":checked") || $('#noInsurance').prop("checked") == true) {
				document.getElementById("AddFlight").submit();
				/*$('#bookP2').fadeOut(function(){
					$('#bookP3').fadeIn();
				});*/
				event.preventDefault();
			} else if ($('#noInsurance').prop("checked") == false) {
			alert('Please select no insurance if you do not want insurance.');
			}
		});
	});
	
	
	</script> 
	<div id="bookP2" class="tabcontent">
		
		<br>
		<div id="bookP2body">
		<form id= "AddFlight" action="AddFlight" method = "post">
			<br> 
			<input type= "hidden" id="policyCheckbox" name="whichPolicy" value= "">
			<input type = "hidden" id='hiddenChecks' name="whichFlight" value="" >
			<%String listTest = (String) request.getAttribute("listTest");%>

                                        <%=listTest%>

			
		</form>
		<br>
		<div id='policyT'>
		<table class="GeneratedTable">
    	<thead>
			<tr>
				<th> <font size="6" color="white" class="tableHead">Policy Benefits</font></th>
					<th width="100">
				<br /><font color="silver" size="6" class="policyType">Silver</font> <br>  <br />
				
					<font color="black" size="6">$20</font>  <br /> <br />    
					<label class="label">Select:</label><input id='silver' type = 'checkbox' class="radio" value='1' name="box[1][]">
				
				</th>

				<th width="100">
				<br /><font color="#a99d18" size="6" class="policyType">Gold</font> <br> <br/ >
				
					<font color="black" size="6">$30</font> <br /> <br /> 
					<label class="label">Select:</label><input id='gold' type = 'checkbox' class="radio" value='1' name="box[1][]">
			
				</th>
				<th width="100">
				<br /> <font color="#ffffff" size="6" class="policyType">Platinum</font> <br> <br />
					
					<font color="black" size="6">$40</font><br /><br />
					<label class="label">Select:</label><input id= 'platinum' type = 'checkbox' class="radio" value ='1'name="box[1][]">
				
				</th>
				
			</tr>
       </thead>
       <tbody>
       <tr>
		<td class="moreInfo">Flight Cancellations  <span class="moreInfoText">100% of ticket cost will be refunded</span><img src="http://image.flaticon.com/icons/png/512/62/62903.png" width="12" height="11" alt="information" /></td>
                <td>&#x2713;</td>
                <td>&#x2713;</td>
                <td>&#x2713;</td>
            </tr>
            <tr>

                <td class="moreInfo">Flight Departure Delay <span class="moreInfoText">10% of ticket cost times minutes delayed will be refunded</span><img src="http://image.flaticon.com/icons/png/512/62/62903.png" width="12" height="11" alt="information"/></td>
                <td></td>
                <td>&#x2713;</td>
                <td>&#x2713;</td>
            </tr>
            <tr>

                <td class="moreInfo">Flight Arrival Delay <span class="moreInfoText">15% of ticket cost times minutes delayed will be refunded</span><img src="http://image.flaticon.com/icons/png/512/62/62903.png" width="12" height="11" alt="information" /></td>
                <td></td>
                <td>&#x2713;</td>
                <td>&#x2713;</td>
            </tr>
            <tr>
                <td class="moreInfo">Accidental Death and/or Dismemberment <span class="moreInfoText">150% of ticket cost will be refunded</span><img src="http://image.flaticon.com/icons/png/512/62/62903.png" width="12" height="11" alt="information" /></td>
                <td></td>
                <td></td>
                <td>&#x2713;</td>
            </tr>
        </tbody>
    </table>
		<form>
			<input type='checkbox' id='noInsurance'><label>I do not want insurance</label>
		</form>
		</div>
		
	</div>
	<br>
	<form>
	<input type='submit' id='backBookP2' class='button' value='Back'>
	<input type='button' id='nextButton' class="button" value='Continue'>
	</form>
  </div>
	<script>
		$('#backBookP2').on('click', function(event){
			$('#bookP2').fadeOut(function(){
				$('#bookMain').fadeIn();
			});
			event.preventDefault();
		});
		
		
		
	</script>
	
  <!-- ------------------------------------------BOOKING P3 SECTION----------------------------------------------- -->
	
  <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>

    <script>
        $(document).ready(function() {
            var max_fields      = 10; //maximum input boxes allowed
            var wrapper         = $(".input_fields_wrap"); //Fields wrapper
            var add_button      = $(".add_field_button"); //Add button ID
   
            var x = 1; //initlal text box count
            $(add_button).click(function(e){ //on add input button click
                e.preventDefault();
                if(x < max_fields){ //max input box allowed
                    x++; //text box increment
                    $(wrapper).append('<div><div class="personalInfoForm"><a href="#" class="remove_field"><img width="25" height="25" src="https://www.goodfreephotos.com/albums/vector-images/red-close-button-vector-clipart.png"/></a><table id="pass1"><thead><tr><td class="tableHead" colspan="2"><font color="white" size="6">Additional Passenger</td><tbody><tr><td>Name:<span class="required" style="color: rgba(196, 18, 48, 0.8)">*</span></td><td><input type="text" name="name"/></td></tr><tr><td>Age:<span class="required" style="color: rgba(196, 18, 48, 0.8)">*</span></td><td><select><option value="senior">Senior (65+)</option><option value="adult">Adult (18-64)</option><option value="youngAdult">Young Adult (13-17)</option><option value="child">Child (2-12)</option><option value="infant">Infant (Under 2)</option></select></td></tr><tr><td>Phone Number:<span class="required" style="color: rgba(196, 18, 48, 0.8)">*</span></td><td><input type="text" name="phoneNum"/></td></tr><tr><td>Email:<span class="required" style="color: rgba(196, 18, 48, 0.8)">*</span></td><td><input type="text" name="email"/></td></tr><tr><td>Number of Checked Bags:<span class="required" style="color: rgba(196, 18, 48, 0.8)">*</span></td><td><input type="text" name="checkedBags"/></td></tr></tbody></table><h4>*Required</h4><br><br><br></div></div>'); 
                }
                });
   
            $(wrapper).on("click",".remove_field", function(e){ //user click on remove text
                e.preventDefault(); $(this).parent('div').remove(); x--;
            })
        });
    </script>

    <link rel = "stylesheet" type = "text/css"
		href = "https://fonts.googleapis.com/css?family=Lato|Roboto|Raleway|Noto+Sans|Work+Sans|Gill+Sans|Open+Sans">
    <div id="bookP3" class="tabcontent">
		<form id = "addPassenger" action = "AddPassenger" method="post">
		<input id="policyId" type = "hidden" name="policyId" value= <%=request.getAttribute("policyId")%> >
		<div id="bookP3body">
        <div class="input_fields_wrap">
            <div class="personalInfoForm">
                
                <table id="pass1">
					<br>
					<thead>
						<tr>
							<td class="tableHead" colspan="2"><font color="white" size="6">Passenger One</td>
						</tr>
					</thead>
                    <tbody>
                        <tr>
                            <td>Name:<span class="required" style="color: rgba(196, 18, 48, 0.8)">*</span></td>
                            <td><input type="text" name="name"/></td>
                        </tr>
                        <tr>
                            <td>Age:<span class="required" style="color: rgba(196, 18, 48, 0.8)">*</span></td>
                            <td>
                                <select>
                                    <option value="senior">Senior (65+)</option>
                                    <option value="adult">Adult (18-64)</option>
                                    <option value="youngAdult">Young Adult (13-17)</option>
                                    <option value="child">Child (2-12)</option>
                                    <option value="infant">Infant (Under 2)</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Phone Number:<span class="required" style="color: rgba(196, 18, 48, 0.8)">*</span></td>
                            <td><input type="text" name="phoneNum"/></td>                                        
                        </tr>
                        <tr>
                            <td>Email:<span class="required" style="color: rgba(196, 18, 48, 0.8)">*</span></td>
                            <td><input type="text" name="email"/></td>
                        </tr>
                        <tr>
                            <td>Number of Checked Bags:<span class="required" style="color: rgba(196, 18, 48, 0.8)">*</span></td>
                            <td><input type="text" name="checkedBags"/></td>
                        </tr>
                    </tbody>
                </table>
                <h4>*Required</h4>
                <br>
            </div>
		</div>
		<button class="add_field_button">Add Another Passenger</button>
		<br>
		<br>
		</div>
		<br>
		<input type='submit' id='backBookP3' class='button' value='Back'>
		<input id="submitInfo" type="submit" class="button" value = "Submit"/>
		</form>
	</div>
	<script>

		$('#submitInfo').on('click', function(event){
			document.getElementById("AddPassenger").submit();
			/*$('#bookP3').fadeOut(function(){
				$('#payment').fadeIn();
			});
			event.preventDefault();*/
		});

			$('#backBookP3').on('click', function(event){
				$('#bookP3').fadeOut(function(){
					$('#bookP2').fadeIn();
				});
				event.preventDefault();
			});
		
	</script>
	<!-------------------------------------------PAYMENT SECTION----------------------------------------------- -->
	<script>
      $(document).ready(function() {
        $('#creditcard').click(function() {
            $('#bankform').slideUp("slow", function() {
              $('#cardform').slideToggle();
            });

        });
        $('#bankaccount').click(function() {
            $('#cardform').slideUp("slow", function() {
              $('#bankform').slideToggle();
            });

        });
	});
	</script> 
	<div id="payment" class="tabcontent">
		<form id = "SubmitPayment" action = "SubmitPayment" method="post">
				<input type = "hidden" name = "test" value = "test1">
				<input type = "hidden" name = "firstName" value = <%=request.getAttribute("firstName")%>>
				<input type = "hidden" name = "lastName" value = <%=request.getAttribute("lastName") %>>
		</form>
			<h2>Payment Amount</h2>
			<br> 
			<br>

			<h3 id= "policyCost" ><%=request.getAttribute("ticketPrice")%></h3>
			<br>
			<br>

			<p>Select A Payment Method:</p>
 
			<br>
			<ul>
			<button class="button buttons" id="creditcard">Credit Card </button>
			<button class="button buttons" id="bankaccount">Bank Account</button>
			<a href="https://www.paypal.com/cgi-bin/webscr" target="_blank"><img src= "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/PayPal.svg/2000px-PayPal.svg.png" 
				alt= "PayPal" class="button buttons paypal" /></a>
				
			</ul>

			<form id="cardform" >
			<input type="text" name="Name" size="20" placeholder="Name on Card"><br>
			<input type="text" name="CCN" size="20" maxlength="16" placeholder="Credit Card Number"><br>
			<input type="text" name="expDate" size="7" maxlength="4" placeholder="MMYY">
			<input type="text" name="cvv" size="7" maxlength="3" placeholder="cvv"><br>
			<input type="text" name="Address1" size="20" placeholder="Address 1"><br>
			<input type="text" name="Address2" size="20" placeholder="Address 2"><br>
			<input type="text" name="city" size="20" placeholder="city"><br>
			<input type="text" name="state" size="20" maxlength="2" placeholder="state"><br>
			<input type="text" name="zip" size="20" maxlength="5" placeholder="zip code"><br>
			</form>
 
			<form id="bankform" >
			<input type="text" name="nickname" size="25" maxlength="25" placeholder="Account Nickname"><br>
			<input type="text" onkeypress="return isNumberKey(event)" name="routing" size="25" maxlength="9" placeholder="Routing Number"><br>
			<input type="text" onkeypress="return isNumberKey(event)" name="routing" size="25" maxlength="9" placeholder="Verify Routing Number"><br>
			<input type="text" onkeypress="return isNumberKey(event)" name="accnt" size="25" maxlength="12" placeholder="Bank Account Number"><br>
			<input type="text" onkeypress="return isNumberKey(event)" name="accnt" size="25" maxlength="12" placeholder="Verify Bank Account Number"><br><br>
			
			</form>
			<br>
			<input type="button" class="button buttons" onclick="submitForm()" value="Submit">
		
	</div>
	<!--------------------------------------------USER LOOKUP SECTION----------------------------------------------- -->
	<div id="lookupMain" class="tabcontent">
		<h2>Lookup Your Policy</h2>
		<div id="search">
			<br>
			<form id="lookup" action="LookupPolicy" method="post">
				<table class="lookupTable">
					<tbody>
							<tr>
									<td>Policy Number:<span class="required" style="color: rgba(196, 18, 48, 0.8)">*</span></td>
									<td><input type="text" id="policyNum" name="policyNum"/></td>
								</tr>
												 
								<tr>
								<td>Phone Number:<span class="required" style="color: rgba(196, 18, 48, 0.8)">*</span></td>
									<td><input type="text" id="phoneNum" name="phoneNum"/></td>
								</tr>
											 
								<tr>
								<td>Confirmation Number:</td>
									<td><input type="text" id="bookRLN" name="bookRLN"/></td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
								<td><input type = "hidden" name = "type" value = "lookup"></td>
						</tr>
					</tfoot>
				</table>
				<h4>*Required</h4>
				<input id="policySearch" type="button`" class ="button" value = "Search"/>
			</form>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			
		</div>
	</div>
	<script>

		$('#policySearch').on('click', function(event){
				var policyNum = $("#policyNum").val();
				var phoneNum = $("#phoneNum").val();
				if(policyNum == "") {
		            alert('Please Enter Policy Number');
		    	} else if (phoneNum == "") {
		        	alert('Please Enter Phone Number');
		    	} else {
		    		document.getElementById("lookup").submit();
					event.preventDefault();
		    	}
			
		});
		
	</script>
<!-------------------------------------------POLICY INFORMATION SECTION----------------------------------------------- -->
	<div id="policyInfo" class="tabcontent">
		<div id="policyBack">
		<br>
        <table class="policyInfo" width="60%">
        	<thead>
           		 <tr>
     
    		        <td width="400" colspan="2"><font size="6"><font color="white" class="tableHead">Policy Information</font></font></td>
            
            	</tr>
        	</thead>
			<tbody>
				<tr>
						<td>Customer Name:</td>
						<td><%=request.getAttribute("firstName")%> <%=request.getAttribute("lastName")%></td>
				</tr>
				<tr>
					<td>Policy Number:</td>
					<td><%=request.getAttribute("policyId")%></td>
				</tr>
				<tr>
					<td>Policy Type:</td>            
						<td><%=request.getAttribute("plan")%></td>
				</tr>
				
				<tr>
					<td>Policy Price:</td>            
						<td><%=request.getAttribute("cost")%></td>
				</tr>
				<tr>
					<td>Refund:</td>            
						<td>$0.00</td>
				</tr>
			</tbody>
		</table>
		<br>
		<br>
		<table class="flightInfo" width="60%">
			<thead>
           		 <tr>
     
    		        <td width="400" colspan="2"><font size="6"><font color="white" class="tableHead">Flight Information</font></font></td>
            
            	</tr>
        	</thead>
			<tbody>
				<tr>
						<td>Flight Number:</td>
						<td><%=request.getAttribute("flightNumber")%></td>
				</tr>             
			
				<tr>
						<td>Flight Carrier:</td>
						<td><%=request.getAttribute("flightCarrier")%></td>
				</tr>
				
				<tr>
						<td>Flight Departure Time/Location:</td>
						<td><%=request.getAttribute("departureTime")%></td>
				</tr>

				<tr>
						<td>Flight Arrival Time/Location:</td>
						<td><%=request.getAttribute("arrivalTime")%></td>
				</tr>
				<tr>
						<td>Ticket Number:</td>
						<td>7897346</td>
				</tr>  
				<tr>
						<td>Ticket Price:</td>
						<td><%=request.getAttribute("ticketPrice")%></td>
				</tr>  
			</tbody>
		</table>
		<br>
		<br>
		
	</div>
	<br>
	<form>
	<input type='submit' id='backSearch' class='button' value='Back'>
	</form>
	</div> 
	<script>
		$('#backSearch').on('click', function(event){
				$('#policyInfo').fadeOut(function(){
					$('#lookupMain').fadeIn();
				});
				event.preventDefault();
			});
	</script>
	<!-------------------------------------------BUSINESS SECTION----------------------------------------------- -->
	<div id="businessMain" class="tabcontent">
		<h2>Business Trends and Statistics</h2>
	
		 <div id="businessDisplay" >

           <!-- 1st Page in Business Trends, data Analytics here -->

            <br> 

             <h3>Data Analysis for Internal Purposes only!</h3>

                                        <iframe width="800" height="600" src="https://app.powerbi.com/view?r=eyJrIjoiMTJlYzIxNDctZTVjNi00YjQwLWE0NmQtODYyZDc4MWM1YTIzIiwidCI6IjliODkzYjY3LTY0NDMtNGQ2Ni04OWRiLTA3MTI5OWU3YTA0ZCIsImMiOjN9"></iframe>

		 </div>

		
	</div>

	<!-------------------------------------------FEEDBACK SECTION----------------------------------------------- -->
	<div id="feedback" class="tabcontent">
            <!-- 1st Page in Feedback, Allow user to take Survey -->
            <br> <br>
            <h1>Please take this survey to help us improve your experience.</h1>
            <br>
            <div id="survey">
                <script>
                (function(e,t,n,o){
                    var s,c,i;e.SMCX=e.SMCX||[],t.getElementById(o)||(s=t.getElementsByTagName(n),c=s[s.length-1],i=t.createElement(n),i.type="text/javascript",i.async=!0,i.id=o,i.src=["https:"===location.protocol?"https://":"http://","widget.surveymonkey.com/collect/website/js/bm_2FJvJ5VTIjon1eVW_2BfQrivEBkCTQWQ9PLAAz_2FG_2Bl0kvuyTO_2BmmyGies_2FTTNEbnY.js"].join(""),c.parentNode.insertBefore(i,c))})
                        (window,document,"script","smcx-sdk");</script>
            </div>
    </div>

</html>

<style>
body {
	text-align: center;
	overflow-y: scroll;
	overflow-x: none;
}

#Logo {
	display: block;
	margin: 0 auto;
	width: 25%;
}

#navBar {
	margin: 0 -1.1%;
}


/* Flight Tracking Application */
h1 {
	font-family: 'Roboto';
	color: #54566b;
}

/* Section Headers*/
h2 {
	font-family: 'Roboto';
	font-size: 30px;
	color: #54566b;
	text-align: center;
	margin: auto;
	margin-bottom: 10px;

}

/*Section Subheaders*/
h3 {
	font-family: 'Roboto';
	color: #54566b;
	margin: 0 auto;
}

/* Required */
h4 {
	font-family: 'Roboto';
	color: rgba(196, 18, 48, 1);
	font-size: 13px;
	text-shadow: 
	-1px -1px 0 white, 
	1px -1px 0 white,
	-1px 1px 0 white,
	1px 1px 0 white;
}


div.tab {
    overflow: hidden;
    border: 1px solid #ccc;
    background-color: #f1f1f1;
}

div.tab button {
	background-color: inherit;
	font-family: 'Lato';
	font-size: 20px;
    border: none;
    outline: none;
    cursor: pointer;
    padding: 14px 16px;
	transition: 0.3s;
}

div.tab button:hover {
	background-color: #ddd;
}

div.tab button.active {
    background-color: #ccc;
}

.tabcontent {
    display: none;
    padding: 6px 12px;
    border: 1px solid #ccc;
	border-top: none;
	-webkit-animation: fadeEffect 1s;
	animation: fadeEffect 1s;
}

@-webkit-keyframes fadeEffect {
    from {opacity: 0;}
    to {opacity: 1;}
}

@keyframes fadeEffect {
    from {opacity: 0;}
    to {opacity: 1;}
}


#book, #bookP2body, #bookP3body {
	background: url("Images/passengers.jpg") no-repeat right center;
	background-size: cover;

}

#add, #policyTable {
	background: url("https://static.pexels.com/photos/8394/flight-sky-clouds-fly.jpg") no-repeat center top;
	background-size: cover;

}
#search, #policyBack {
	background: url("Images/plane.jpg") no-repeat center center;
	background-size: cover;
}

#payment {
	background: url("https://upload.wikimedia.org/wikipedia/commons/8/8d/Kolkata_Airport_New_Terminal_gate_waiting_area.jpeg") no-repeat center center;
	background-size: cover;
}


table {
    font-size: 16px;
	font-family: 'Lato';
	margin: auto;
}

table input {
	text-align: center;
}

td {
    padding: 12px 15px;
}

.bookTable tbody, .lookupTable tbody, .addPolicyTable tbody, 
.TicketInfo tbody, .GeneratedTable tbody, .flightAvail tbody, .flightAvail thead, .policy tbody, 
.flightInfo tbody, .policyInfo tbody {
	background-color: rgba(209, 208, 206, 0.4);
}

.GeneratedTable tbody td {
	font-size: .8em;
}


.flightInfo thead, .policyInfo thead, .TicketInfo thead, #pass1 thead {
	background-color: rgba(209, 208, 206, 0.6);
}

/* Back-End*/

#hidden {
	display: none;
}

/*Policy Tables*/

table.GeneratedTable {
	width: 65%;
	background-color: rgba(252, 246, 246, 0.04);
	border-collapse: collapse;
	color: #000000;
	border-top: 1px solid black;
	border-bottom:  1px solid black;
}

tr {
	font-family: 'Roboto';
	font-size: 20px;
}

table.GeneratedTable th, table.GeneratedTable td {
		border-right: 1px solid black;
		border-left: 1px solid black;
		width: 25%;
		padding-bottom: 4px;
}

.moreInfo {
    position: relative;
}

.moreInfo .moreInfoText {
	visibility: hidden;
	color: white;
	position: absolute;
    z-index: 1;
    bottom: 100%;
    left: 50%;
    margin-left: -60px;
	background-color: rgb(84, 86, 91);
	border-radius: 6px;
    padding: 5px 0;
	display: inline-block;
}

.moreInfo:hover .moreInfoText {
	visibility: visible;

}

.policyType, .tableHead {
	text-shadow: 
	-1px -1px 0 #000000, 
	1px -1px 0 #000000,
	-1px 1px 0 #000000,
	1px 1px 0 #000000;
}

table.GeneratedTable thead  {
		background-color: rgba(250, 247, 247, 0.28);
}


.policyBuy {
		color: white;
		background-color: #31a3ca;
		border-radius: 5px;
		font-size: 20px;
		font-family: 'Roboto';
}


/*Booking Pg 2*/

#bookP2 {
	display: none;
}

#flightAvail {
	font-size: 16px;
	font-family: 'Roboto';
	border: 1px solid black;
	border-collapse: collapse;
	width: 65%;
}
#policyT{
	display: none;
}
.policy {
	font-size: 16px;
	font-family: 'Roboto';
	display: inline-block;
}
.policyRow {
	width: 300px;
	height: 75px;
	border-collapse: collapse;
	text-align: center;
}
.policyData {
	width: 150px;
	border: 1px solid;
}
.policyHead {
	width: 150px;
	vertical-align: bottom;
}

label {
	font-family: 'Roboto';
	color:white;
	text-shadow: 
	-1px -1px 0 #000000, 
	1px -1px 0 #000000,
	-1px 1px 0 #000000,
	1px 1px 0 #000000;

}

/*Booking P3*/

#bookP3 h2 {
	color: black;

}
 #pass1 table {
	margin: auto;
	font-family: 'Lato';

}

#pass1 tbody {
	background-color: rgba(209, 208, 206, 0.6);
}

#pass1 td {
	width: 200px;
	height: 50px;
}


.add_field_button {
	margin: auto;
	display: inline-block;
	font-family: 'Roboto';
}

.remove_field {
    color: red;
    position: relative;
    float: right;
    top: 5px;
    right: 65px;
    width: 15px;
    border-radius: 2px;

}

.personalInfoForm {
	margin: 20px auto;
	width: 550px;
	border-radius: 4px;
}

/*Payment Pg*/

/* Payment Amount */

#payment h2 {
    color: rgb(84, 86, 91);
    margin-bottom: 5px;
    font-size: 30px;
    line-height: 25px;
}

/* Bill Amount */
#payment h3 {
    color: rgb(0,164,228);
    font-family: 'Roboto';
    font-size: 85px;
    line-height: 25px;
}


#payment h2, #payment p, #payment .button {
    font-family: 'Roboto';
}

#payment li {
    display: inline-block;
}
#payment ul {
  position: relative;
  right: 15px;

}


.button, .buttons, .add_field_button {
    border: 2px solid rgb(168, 168, 170);
	border-radius: 4px;
    color: rgb(168, 168, 170);
    background-color: white;
	transition-duration: 0.3s;
	display: inline-block;
	font-size: 20px;
	width: 150px;
	height: 50px;
}

#creditcard, #bankaccount {
    height: 65px;
}

.button:hover, .buttons:hover, .add_field_button:hover {
    background-color: rgb(168, 168, 170); 
    color: white; 
}


.paypal {
    position: relative;
    top: 31px;
} 

#bankform, #cardform {
    display: none;
}

#bankform input, #cardform input {
    text-align: left;
    margin: 5px 0px;
}

#bankform input:focus, #cardform input:focus, #dtpcker input:focus, textarea:focus {
    box-shadow: 0 0 5px rgba(81, 203, 238, 1);
    border: 2px solid rgba(81, 203, 238, 1);
}

#bankform input[placeholder], #cardform input[placeholder] {
    text-align: center;
}

div {
	border: none !important;
}


.label {
	font-size: .7em;
}

#scheduledDelay, #en-routeDelay {
    width: 175px;
}

#survey {
    margin-left: 23%;
}




</style>