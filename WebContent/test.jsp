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
	  <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
  <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
  <script>
  //changes
  var flag = <%=request.getAttribute("case")%>
  var plan = null;
	window.onload = function () {
		checkFlag();
		//alert("hello");
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
    	else {
    		startTab();
    	}
       	
    }
    function submitForm() {
    	if(plan == "S"){
    		document.getElementById("buyForm1").submit();
    	}
    	else if (plan == "G"){
    		document.getElementById("buyForm2").submit();
    	}
    	else {
    		document.getElementById("buyForm3").submit();
    	}
    		
    }

  </script>
  
  
	<div id="home">
		<h1>Flight Tracking Application</h1>
	</div>
	<div id="navBar" class="tab">
	  <button id="navAddPolicy" class="tablinks" onclick="openTab(event, 'addPolicyExst')">Add A Policy</button>
		<button id="navBook" class="tablinks" onclick="openTab(event, 'bookMain')">Book A Flight</button>
		<button id="navPerson" class="tablinks" onclick="openTab(event, 'lookupMain')">My Policy</button>
		<button id="navBusiness" class="tablinks" onclick="openTab(event, 'businessMain')">Business</button>
		<button id="navFeedback" class="tablinks" onclick="openTab(event, 'feedback')">Feedback</button>
	</div>
	<br>
	<!--  <body onLoad="scrollTo">-->
	<script type = "text/javascript">

	</script>
	
	
	<!-------------------------------------------ADD POLICY TO EXISTING FLIGHT --------------------------------- -->
	<div id="addPolicyExst" class="tabcontent">
		<h2 id= "1"> Add Insurance To An Existing Flight</h2>
		<div id="add">
			<form id="what" action="findFlight" method="post">
				<br>
				<table id='exist' class="addPolicyTable">
						<tbody>
									<tr>
									<td>Ticket Number:</td>
										<td><input type="text" name="ticketNum"></td>
							</tr>
							<tr>
								<td colspan="2">OR</td>
							</tr>
							<tr>
										<td>Phone Number:</td>
										<td><input type="text" name="phoneNum"></td>
									</tr>
						</tbody>
						<tfoot>
							<tr>
									<td><input type = "hidden" name = "type" value = "addPolicyExisting"></td>
							</tr>
						</tfoot>
				</table>
				<input id="addPolicy" type="submit" class="button" value = "Add A Policy"/>
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
	</div>
	<script>

		$('#addPolicy').on('click', function(event){
			document.getElementById("what").submit();
			/*$('#addPolicyExst').fadeOut( function(){
				$('#policyMain').fadeIn();
			});*/
			event.preventDefault();
		});
		
	</script>
	<!---------------------------------------------POLICY SECTION----------------------------------------------- -->
	<div id="policyMain" class="tabcontent">
            <br>
			<!-- Ticket Information Table -->
		<div id="policyTable">
			<br>
        <table class="TicketInfo" width="60%">
        	<thead>
           		 <tr>
     
					<th width="400"colspan="2"><font size="6"><font color="#2dc8fa">Ticket Information</font></font></th>
            
            	</tr>
        </thead>
        <tbody>
           <tr>
               <td width="300">
            
             <font size="4">Ticket Number</font>
                       <td><%=request.getAttribute("ticketNumber")%></td>
               </td>
           </tr>
           
           <tr>
           <td width="300">
           <font size="4">Customer Name</font>
           <td><%=request.getAttribute("firstName")%> <%=request.getAttribute("lastName") %></td>
           </td>
           </tr>

           <tr>
           <td width="350">
           <font size="4">Flight Number</font>
           <td><%=request.getAttribute("flightNumber")%></td>
           </td>
           </tr>             
           
           <tr>
           <td width="350">
           <font size="4">Flight Carrier</font>
               <td> <%=request.getAttribute("flightCarrier")%></td>
           </td>
           </tr>
           
           <tr>
           <td width="350">
           <font size="4">Flight Departure Time/Location</font>
               </td><td><%=request.getAttribute("departureTime")%> <%=request.getAttribute("origin")%></td>
           </tr>

           <tr>
           <td width="350">
           <font size="4">Flight Arrival Time/Location</font>
               </td><td><%=request.getAttribute("arrivalTime")%> <%=request.getAttribute("destination")%></td>
           </tr>
                </tbody>
			</table>
			 <caption><font A size="6" > <font color="#000000">Policies</font></font></caption>
	<table class="GeneratedTable">
    <thead>
        <tr>
            <th> <font size="6"> Benefits </font></th>
                <th width="100"><br /><font color="#808080" size="6" class="policyType">Silver</font> <br>  <br />
                   <form id= "buyForm1" action= "AddPolicy" method="post">
				   <font color="#2dc8fa" size="4">$250</font>  <br /> <br />
				   <input type="hidden" name="ticketNumber" value= <%=request.getAttribute("ticketNumber")%> >    
				   <input id = "planA" type ="hidden" name="policyPrice" value="250">
				   <button id="buyButton1" class="policyBuy">BUY</button>
                   </form>
            </th>

            <th width="100">
            <br /><font color="#ae9e3b" size="6" class="policyType">Gold</font> <br> <br/ >
                <form id="buyForm2" action= "AddPolicy" method="post">
				<font color="#2dc8fa" size="4">$300</font> <br /> <br /> 
				<input type="hidden" name="ticketNumber" value= <%=request.getAttribute("ticketNumber")%> >
				<input id="planB" type = "hidden" name="policyPrice" value="300">
				<button id="buyButton2"  class="policyBuy">BUY</button>
                </form>
            </th>
            <th width="100">
            <br /> <font color="#bdc8c7" size="6" class="policyType">Platinum</font> <br> <br />
                <form id="buyForm3" action= "AddPolicy" method="post">
                    <font color="#2dc8fa" size="4">$350</font><br /><br />
                    <input type="hidden" name="ticketNumber" value= <%=request.getAttribute("ticketNumber")%> >
                    <input id="planC" type = "hidden" name="policyPrice" value="350">
                    <button id="buyButton3" class="policyBuy">BUY</button>
                </form>
			</th>
			
       </tr>
       </thead>
       <tbody>
       <tr>
		<td width="80">Flight Cancellations  <img src="https://sp.yimg.com/ib/th?id=OIP.zFmzdOGlL99M49wGhyUd0gEQD0&pid=15.1&rs=1&c=1&qlt=95&w=126&h=113" width="15" height="13" alt="information" title="Flight cancellation due to weather/mechanical related issues will reimburse the customer 100$ of ticket costs" />
		</td>
		</td>
                <td>&#x2713;</td>
                <td>&#x2713;</td>
                <td>&#x2713;</td>
            </tr>
            <tr>

                <td>Flight Departure Delay <img src="https://sp.yimg.com/ib/th?id=OIP.zFmzdOGlL99M49wGhyUd0gEQD0&pid=15.1&rs=1&c=1&qlt=95&w=126&h=113" width="15" height="13" alt="information" title=" This policy will ensure that in the case of a flight departure delay for more than 4 hours but no less than 2 hours, the customer will be paid out $150" /></td>
                <td></td>
                <td>&#x2713;</td>
                <td>&#x2713;</td>
            </tr>
            <tr>

                <td>Flight Arrival Delay <img src="https://sp.yimg.com/ib/th?id=OIP.zFmzdOGlL99M49wGhyUd0gEQD0&pid=15.1&rs=1&c=1&qlt=95&w=126&h=113" width="15" height="13" alt="information" title=" This policy will ensure that in the case of a flight arrival delay for more than 4 hours but no less than 2 hours, the customer will be paid out $150" /></td>
                <td></td>
                <td>&#x2713;</td>
                <td>&#x2713;</td>
            </tr>
            <tr>
                <td>Accidental Death and/or Dismemberment <img src="https://sp.yimg.com/ib/th?id=OIP.zFmzdOGlL99M49wGhyUd0gEQD0&pid=15.1&rs=1&c=1&qlt=95&w=126&h=113" width="15" height="13" alt="information" title="This policy will ensure up to $3,000 paid out due to unforseen accidental death or injury"/></td>
                <td></td>
                <td></td>
                <td>&#x2713;</td>
            </tr>
        </tbody>
	</table>
	</div>
		<input type='submit' id='backPolicyMain' class='button' value='Back'>	
	</div>
	<script>
	
		$('#buyButton1').on('click', function(event){
			plan = "S";
			$('#policyCost').html("$250")
			
		});
		
		$('#buyButton2').on('click', function(event){
			plan = "G";
			$('#policyCost').html("$300")
		});
		
		$('#buyButton3').on('click', function(event){
			plan = "P";
			$('#policyCost').html("$350")
		});
	
		$('.policyBuy').on('click', function(event){
			$('#policyMain').fadeOut( function(){
				$('#payment').fadeIn();
			});
			event.preventDefault();
		});

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
	     <form>
		   <table class= "bookTable">
			   <tbody>
    		     <tr>
      		        <td>Departure Airport<span style="color: rgba(196, 18, 48, 0.8)">*</span></td>
      			    <td><input type="text" name="depAir"/></td>
    		     </tr>
    		     <tr>
    			    <td>Arrival Airport<span style="color: rgba(196, 18, 48, 0.8)">*</span></td>
      			    <td><input type="text" name="arrAir"/></td>
   	 		     </tr>
   	 		     <tr>
    			    <td>Date<span style="color: rgba(196, 18, 48, 0.8)">*</span></td>
      			    <td><input type="text" id="dateBox" placeholder="MM/DD/YYYY"></td>
   	 		     </tr>
   	 		     <tr>
    			    <td>Number of Passengers<span style="color: rgba(196, 18, 48, 0.8)">*</span></td>
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
			$('#bookMain').fadeOut(function(){
				$('#bookP2').fadeIn();
			});
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
		$(".radio").on('click', function() {
		var $box = $(this);
		if ($box.is(":checked")) {
			var policyBoxes = "input.radio:checkbox[name='" + $box.attr("name") + "']";
			$(policyBoxes).prop("checked", false);
			$box.prop("checked", true);
		} else {
			$box.prop("checked", false);
		}
		});
		$('#nextButton').on('click', function() {
		if($('.radio').is(":checked") || $('#noInsurance').prop("checked") == true) {
			$('#nextButton').on('click', function(event){
				$('#bookP2').fadeOut(function(){
					$('#bookP3').fadeIn();
				});
				event.preventDefault();
			});
		} else if ($('#noInsurance').prop("checked") == false) {
			alert('Please select no insurance if you do not want insurance.');
		}
		});
	});
	</script> 
	<div id="bookP2" class="tabcontent">
		<h3>Available Flights</h3>
		<br>
		<div id="bookP2body">
		<table id="flightAvail" class="flightAvail">
			<tr>
			<th>Airline</th>
			<th>Flight Number</th>
			<th>Departure Time</th>
			<th>Arrival Time</th>
			<th>Cost</th>
			<th>Select</th>
			</tr>
			<tr class='flightSelect'>
			<td>Delta</td>
			<td>DL1234</td>
			<td>0600</td>
			<td>0900</td>
			<td>$500</td>
			<th><input type = 'checkbox' class="planeBox" value="1" name="box[1][]"></th>
			</tr>
			<tr class='flightSelect'>
			<td>Delta</td>
			<td>DL5678</td>
			<td>1200</td>
			<td>1430</td>
			<td>$693</td>
			<th><input type = 'checkbox' class="planeBox" value="1" name="box[1][]"></th>
			</tr>
			<tr class='flightSelect'>
			<td>Delta</td>
			<td>DL9876</td>
			<td>1822</td>
			<td>2138</td>
			<td>$1400</td>
			<th><input type = 'checkbox' class="planeBox" value="1" name="box[1][]"></th>
			</tr>
		</table>
		<br>
		<div id='policyT'>
		<table class="GeneratedTable">
    	<thead>
			<tr>
				<th> <font size="6"> Benefits </font></th>
					<th width="100">
				<br /><font color="#808080" size="6" class="policyType">Silver</font> <br>  <br />
					<form >
					<font color="#2dc8fa" size="4">$250</font>  <br /> <br />    
					<input type = 'checkbox' class="radio" value="1" name="box[1][]">
					</form>
				</th>

				<th width="100">
				<br /><font color="#ae9e3b" size="6" class="policyType">Gold</font> <br> <br/ >
					<form >
					<font color="#2dc8fa" size="4">$300</font> <br /> <br /> 
					<input type = 'checkbox' class="radio" value="1" name="box[1][]">
					</form>
				</th>
				<th width="100">
				<br /> <font color="#bdc8c7" size="6" class="policyType">Platinum</font> <br> <br />
					<form >
						<font color="#2dc8fa" size="4">$350</font><br /><br />
						<input type = 'checkbox' class="radio" value="1" name="box[1][]">
					</form>
				</th>
				
			</tr>
       </thead>
       <tbody>
       <tr>
		<td width="80">Flight Cancellations  <img src="https://sp.yimg.com/ib/th?id=OIP.zFmzdOGlL99M49wGhyUd0gEQD0&pid=15.1&rs=1&c=1&qlt=95&w=126&h=113" width="15" height="13" alt="information" title="Flight cancellation due to weather/mechanical related issues will reimburse the customer 100$ of ticket costs" />
		</td>
		</td>
                <td>&#x2713;</td>
                <td>&#x2713;</td>
                <td>&#x2713;</td>
            </tr>
            <tr>

                <td>Flight Departure Delay <img src="https://sp.yimg.com/ib/th?id=OIP.zFmzdOGlL99M49wGhyUd0gEQD0&pid=15.1&rs=1&c=1&qlt=95&w=126&h=113" width="15" height="13" alt="information" title=" This policy will ensure that in the case of a flight departure delay for more than 4 hours but no less than 2 hours, the customer will be paid out $150" /></td>
                <td></td>
                <td>&#x2713;</td>
                <td>&#x2713;</td>
            </tr>
            <tr>

                <td>Flight Arrival Delay <img src="https://sp.yimg.com/ib/th?id=OIP.zFmzdOGlL99M49wGhyUd0gEQD0&pid=15.1&rs=1&c=1&qlt=95&w=126&h=113" width="15" height="13" alt="information" title=" This policy will ensure that in the case of a flight arrival delay for more than 4 hours but no less than 2 hours, the customer will be paid out $150" /></td>
                <td></td>
                <td>&#x2713;</td>
                <td>&#x2713;</td>
            </tr>
            <tr>
                <td>Accidental Death and/or Dismemberment <img src="https://sp.yimg.com/ib/th?id=OIP.zFmzdOGlL99M49wGhyUd0gEQD0&pid=15.1&rs=1&c=1&qlt=95&w=126&h=113" width="15" height="13" alt="information" title="This policy will ensure up to $3,000 paid out due to unforseen accidental death or injury"/></td>
                <td></td>
                <td></td>
                <td>&#x2713;</td>
            </tr>
        </tbody>
    </table>
	
			<input type='checkbox' id='noInsurance'><label>       I do not want insurance</label>
		</div>
		<input type='submit' id='backBookP2' class='button' value='Back'>
		<input type='button' id='nextButton' class="button" value='Continue'>
	</div>
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
                    $(wrapper).append('<div><div class="personalInfoForm"><a href="#" class="remove_field">X</a><h2>Passenger One</h2><table id="pass1"><tbody><tr><td>Name<span style="color: rgba(196, 18, 48, 0.8)">*</span></td><td><input type="text" name="name"/></td></tr><tr><td>Age<span style="color: rgba(196, 18, 48, 0.8)">*</span></td><td><select><option value="senior">Senior (65+)</option><option value="adult">Adult (18-64)</option><option value="youngAdult">Young Adult (13-17)</option><option value="child">Child (2-12)</option><option value="infant">Infant (Under 2)</option></select></td></tr><tr><td>Phone Number<span style="color: rgba(196, 18, 48, 0.8)">*</span></td><td><input type="text" name="phoneNum"/></td></tr><tr><td>Email<span style="color: rgba(196, 18, 48, 0.8)">*</span></td><td><input type="text" name="email"/></td></tr><tr><td>Number of Checked Bags<span style="color: rgba(196, 18, 48, 0.8)">*</span></td><td><input type="text" name="checkedBags"/></td></tr></tbody></table><h4>*Required</h4><br><br><br></div></div>'); 
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
		<h1>Enter Personal Information:</h1>
		<div id="bookP3body">
        <div class="input_fields_wrap">
            <div class="personalInfoForm">
                <h2>Passenger One</h2>
                <table id="pass1">
                    <tbody>
                        <tr>
                            <td>Name<span style="color: rgba(196, 18, 48, 0.8)">*</span></td>
                            <td><input type="text" name="name"/></td>
                        </tr>
                        <tr>
                            <td>Age<span style="color: rgba(196, 18, 48, 0.8)">*</span></td>
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
                            <td>Phone Number<span style="color: rgba(196, 18, 48, 0.8)">*</span></td>
                            <td><input type="text" name="phoneNum"/></td>                                        
                        </tr>
                        <tr>
                            <td>Email<span style="color: rgba(196, 18, 48, 0.8)">*</span></td>
                            <td><input type="text" name="email"/></td>
                        </tr>
                        <tr>
                            <td>Number of Checked Bags<span style="color: rgba(196, 18, 48, 0.8)">*</span></td>
                            <td><input type="text" name="checkedBags"/></td>
                        </tr>
                    </tbody>
                </table>
                <h4>*Required</h4>
                <br>

            </div>
            <br>
            <button class="add_field_button">Add Another Passenger</button>
            <br>
			<br>
		</div>
		<input type='submit' id='backBookP3' class='button' value='Back'>
		<input id="submitInfo" type="submit" class="button" value = "Submit"/>
		</div>
	</div>
	<script>

		$('#submitInfo').on('click', function(event){
			$('#bookP3').fadeOut(function(){
				$('#payment').fadeIn();
			});
			event.preventDefault();
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
				
			<h2>Payment Amount</h2>
			<br>
			<br>

			<h3 id= "policyCost" >$450</h3>
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
			<form>
				<table class="lookupTable">
					<tbody>
							<tr>
									<td>Policy Number<span style="color: rgba(196, 18, 48, 0.8)">*</span></td>
									<td><input type="text" name="policyNum"/></td>
								</tr>
												 
								<tr>
								<td>Phone Number<span style="color: rgba(196, 18, 48, 0.8)">*</span></td>
									<td><input type="text" name="phoneNum"/></td>
								</tr>
											 
								<tr>
								<td>Ticket Number</td>
									<td><input type="text" name="bookRLN"/></td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
								<td><input type = "hidden" name = "type" value = "lookup"></td>
						</tr>
					</tfoot>
				</table>
				<h4>*Required</h4>
				<input id="policySearch" type="submit" class ="button" value = "Search"/>
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
			$('#lookupMain').fadeOut(function(){
				$('#policyInfo').fadeIn();
			});
			event.preventDefault();
		});
		
	</script>
<!-------------------------------------------POLICY INFORMATION SECTION----------------------------------------------- -->
	<div id="policyInfo" class="tabcontent">
		<br>
        <table class="policyInfo" width="60%">
        	<thead>
           		 <tr>
     
    		        <td width="400" colspan="2"><font size="6"><font color="#2dc8fa">Policy Information</font></font></td>
            
            	</tr>
        	</thead>
			<tbody>
				<tr>
						<td>Customer Name</td>
						<td>Sarah Tuthill</td>
				</tr>
				<tr>
					<td>Policy Number</td>
					<td>12345678</td>
				</tr>
				<tr>
					<td>Policy Type</td>            
						<td>Gold</td>
				</tr>
				
				<tr>
					<td>Policy Price</td>            
						<td>$150</td>
				</tr>
				<tr>
					<td>Refund</td>            
						<td>$70</td>
				</tr>
			</tbody>
		</table>
		<br>
		<br>
		<table class="flightInfo" width="60%">
			<thead>
           		 <tr>
     
    		        <td width="400" colspan="2"><font size="6"><font color="#2dc8fa">Ticket Information</font></font></td>
            
            	</tr>
        	</thead>
			<tbody>
				<tr>
						<td>Flight Number</td>
						<td>1134</td>
				</tr>             
			
				<tr>
						<td>Flight Carrier</td>
						<td>American Airlines</td>
				</tr>
				
				<tr>
						<td>Flight Departure Time/Location</td>
						<td>6:00 PM LAX</td>
				</tr>

				<tr>
						<td>Flight Arrival Time/Location</td>
						<td>7:00 AM RDU</td>
				</tr>
				<tr>
						<td>Ticket Number</td>
						<td>7897346</td>
				</tr>  
				<tr>
						<td>Ticket Price</td>
						<td>$5000</td>
				</tr>  
			</tbody>
		</table>
		<input type='submit' id='backSearch' class='button' value='Back'>
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
		<h3>Data Analytics will be added using PowerBI</h3>
		<form>
		   <table>
			   <tr><td><input type = "hidden" name = "type" value = "business"></td></tr>
  		   </table>
			<br>
		  <input type="submit" class="button" value = "Get Results"/>
  		</form>
	</div>

	<!-------------------------------------------FEEDBACK SECTION----------------------------------------------- -->
	<div id="feedback" class="tabcontent">
		<h2>Give Feedback</h2>
			<form>
				<table>
					<tr><td><input type = "hidden" name = "type" value = "survey"></td></tr>
				</table>
  				<input type="submit" class="button" value = "Take Survey"/>
  			</form>
	</div>
</html>

<style>
	body {
	text-align: center;
	overflow-y: scroll;
}

#Logo {
	display: block;
	margin: 0 auto;
	width: 25%;
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
	color: rgba(196, 18, 48, 0.8);
	font-size: 13px;
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
	background: url("https://cdn.pixabay.com/photo/2014/11/06/10/54/passengers-519008_960_720.jpg") no-repeat right center;
	background-size: cover;

}

#add, #policyTable {
	background: url("https://static.pexels.com/photos/8394/flight-sky-clouds-fly.jpg") no-repeat center top;
	background-size: cover;

}
#search, #policyInfo {
	background: url("https://cdn.pixabay.com/photo/2014/10/22/12/44/the-plane-497934_960_720.jpg") no-repeat center center;
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
.TicketInfo tbody, .GeneratedTable tbody, .flightAvail tbody, .policy tbody, 
.flightInfo tbody, .policyInfo tbody {
	background-color: rgba(209, 208, 206, 0.4);
}

.flightInfo thead, .policyInfo thead, .TicketInfo thead {
	background-color: rgba(209, 208, 206, 0.6);
}

/* Back-End*/

#hidden {
	display: none;
}

/*Policy Tables*/

table.GeneratedTable {
	width: 70%;
	background-color: #ffffff;
	border-collapse: collapse;
	border-width: 10px;
	border-color: #2dc8fa;
	border-style: double;
	color: #000000;
}
tr {
	font-family: 'Trebuchet MS', Arial, sans-serif, 20px;
}
table.GeneratedTable td, table.GeneratedTable th  {
		border-color: #000000;
		border-style: dashed;
		border-width: 1px;
	}
	.policyType {
		text-shadow: 
		-1px -1px 0 #000000, 
		1px -1px 0 #000000,
		-1px 1px 0 #000000,
		1px 1px 0 #000000;
	}
table.GeneratedTable thead  {
		background-color: #ffffff;
	}

.policyBuy {
		color: white;
		background-color: #21a000;
		border-bottom-right-radius: 20px;
		border-top-left-radius: 20px;
		border-top-right-radius: 20px;
		border-bottom-left-radius: 20px;
		font-size: 20px;
		font-family: 'Trebuchet MS', 'Arial','Impact', "Haettenschweiler", 'Arial Narrow Bold', 'sans-serif';
	}

#policyList th, #policyList td {
        padding: 15px;
        text-align: center;
        margin: auto;
    }

/*Booking Pg 2*/

#bookP2 {
	display: none;
}

#flightAvail {
	font-size: 16px;
	font-family: 'Arial';
	width: 100%;
	border: 1px solid black;
	border-collapse: collapse;
}
#policyT{
	display: none;
}
.policy {
	font-size: 16px;
	font-family: 'Arial';
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
	right: 5px;

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
    font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
    font-size: 85px;
    line-height: 25px;
}


#payment h2, #payment p, #payment .button {
    font-family: "Raleway";
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


</style>