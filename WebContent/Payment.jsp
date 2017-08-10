<!DOCTYPE html>
<html>
  <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
  <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
 <script>
$(document).ready(function() {
      $('#creditcard').click(function() {
          $('#checkForm').slideUp("slow", function() {
            $('#saveForm').slideUp("slow", function() {
              $('#cardform').slideToggle();
          });
        });
      });
      $('#checkAccount').click(function() {
          $('#cardform').slideUp("slow", function() {
            $('#saveForm').slideUp("slow", function() {
              $('#checkForm').slideToggle();
          });
        });
      });
      $('#saveAccount').click(function() {
          $('#checkForm').slideUp("slow", function() {
            $('#cardform').slideUp("slow", function() {
              $('#saveForm').slideToggle();
          });
        });
      });
    });
 </script>

 <script type="text/javascript">

          function isNumberKey(evt)
          {
             var charCode = (evt.which) ? evt.which : event.keyCode
             if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

             return true;
          }

 </script>

 <head>
   <title>Make A Payment </title>
  <link rel = "stylesheet" type = "text/css"
		href = "https://fonts.googleapis.com/css?family=Lato|Roboto|Raleway|Noto+Sans|Work+Sans|Gill+Sans|Open+Sans">
 </head>

 <body>
   <br>
   <div id="background">
     <br>
      <table id="purchaseReview">
     <thead>
       <th colspan="3">Review your purchase:</th>
    </thead>
      <tbody>
        <tr>
          <td>Flight Amount</td>
          <td class="price"><%=request.getAttribute("ticketPrice") %></td>
        </tr>
         <tr>
          <td>Policy Amount</td>
          <td class="price"><%=request.getAttribute("policyPrice") %></td>
        </tr>
        <tr></tr>
        <tr id="break"><td height="30"> </td></tr>
         <tr id="total">
          <td>Total</td>
          <td class="price"><%=request.getAttribute("totalPrice") %></td>
        </tr>
      </tbody>
   </table>
    <br>
      <h2>Select A Payment Method:</h2>

      <ul>
        <button class="button buttons" id="creditcard">Credit Card </button>
        <button class="button buttons" id="checkAccount">Checking</button>
        <button class="button buttons" id="saveAccount">Savings</button>
      
      </ul>
      <br>
      <form id="cardform" >
        <hr>
        <p class="formTitle"> Card Information </p>
        <label class="floatLabel creditCard">Credit Card Number</label>
        <input type="text" class="creditForm" name="CCN" maxlength="16">
        <br>
        <label class="floatLabel expDate">Expiration Date (MMYY)</label>
        <input type="text" class="creditForm" name="CCN" maxlength="4">
        <br>
        <label class="floatLabel securityCode">Security Code</label>
        <input type="text" class="creditForm" name="cvv"  maxlength="3">
        <br>
        <br>
        <hr>
        <p class="formTitle"> Card Holder Information </p>
        <br>
        <label class="floatLabel firstName">First Name</label>
        <input type="text" class="creditForm" name="fName">
        <br>
        <label class="floatLabel lastName">Last Name</label>
        <input type="text" class="creditForm" name="lName">
        <br>
        <label class="floatLabel streetAddress">Street Address</label>
        <input type="text" class="creditForm" name="Address1">
        <br>
        <label class="floatLabel aptSuite">Apt/Suite (optional)</label>
        <input type="text" class="creditForm" name="Address2">
        <br>
        <label class="floatLabel cityName">City Name</label>
        <input type="text" class="creditForm" name="city">
        <br>
        <label class="floatLabel selectState">Select State</label>
        <select type="text" class="creditForm" name="state">
            <option></option>
            <option value="AL">Alabama</option>
            <option value="AK">Alaska</option>
            <option value="AZ">Arizona</option>
            <option value="AR">Arkansas</option>
            <option value="CA">California</option>
            <option value="CO">Colorado</option>
            <option value="CT">Connecticut</option>
            <option value="DE">Delaware</option>
            <option value="DC">District Of Columbia</option>
            <option value="FL">Florida</option>
            <option value="GA">Georgia</option>
            <option value="HI">Hawaii</option>
            <option value="ID">Idaho</option>
            <option value="IL">Illinois</option>
            <option value="IN">Indiana</option>
            <option value="IA">Iowa</option>
            <option value="KS">Kansas</option>
            <option value="KY">Kentucky</option>
            <option value="LA">Louisiana</option>
            <option value="ME">Maine</option>
            <option value="MD">Maryland</option>
            <option value="MA">Massachusetts</option>
            <option value="MI">Michigan</option>
            <option value="MN">Minnesota</option>
            <option value="MS">Mississippi</option>
            <option value="MO">Missouri</option>
            <option value="MT">Montana</option>
            <option value="NE">Nebraska</option>
            <option value="NV">Nevada</option>
            <option value="NH">New Hampshire</option>
            <option value="NJ">New Jersey</option>
            <option value="NM">New Mexico</option>
            <option value="NY">New York</option>
            <option value="NC">North Carolina</option>
            <option value="ND">North Dakota</option>
            <option value="OH">Ohio</option>
            <option value="OK">Oklahoma</option>
            <option value="OR">Oregon</option>
            <option value="PA">Pennsylvania</option>
            <option value="RI">Rhode Island</option>
            <option value="SC">South Carolina</option>
            <option value="SD">South Dakota</option>
            <option value="TN">Tennessee</option>
            <option value="TX">Texas</option>
            <option value="UT">Utah</option>
            <option value="VT">Vermont</option>
            <option value="VA">Virginia</option>
            <option value="WA">Washington</option>
            <option value="WV">West Virginia</option>
            <option value="WI">Wisconsin</option>
            <option value="WY">Wyoming</option>
        </select>
        <br>
        <label class="floatLabel zipCode">Zip Code</label>
        <input type="text" class="creditForm" name="zip" maxlength="5">
        <br>
      </form>

      <form id="checkForm">
        <hr>
        <p class="formTitle"> Checking Account Information </p>
        <label class="floatLabel nickname">Account Nickname</label>
        <input type="text" class="checkInput" name="nickname" maxlength="25">
        <br>
        <label class="floatLabel routing">Routing Number</label>
        <input type="text" class="checkInput" onkeypress="return isNumberKey(event)" name="routing" maxlength="9">
        <br>
        <label class="floatLabel account">Bank Account Number</label>
        <input type="text" class="checkInput" onkeypress="return isNumberKey(event)" name="accnt" maxlength="12">
        <br>
        <label class="floatLabel bankName">Financial Institution Name</label>
        <input type="text" class="checkInput" name="checkName" maxlength="25">
        <br>
      </form>
      <form id="saveForm" >
        <hr>
        <p class="formTitle"> Savings Account Information </p>
        <label class="floatLabel nickname">Account Nickname</label>
        <input type="text" class="saveInput" name="nickname">
        <br>
        <label class="floatLabel routing">Routing Number</label>
        <input type="text" class="saveInput" onkeypress="return isNumberKey(event)" name="routing" maxlength="9">
        <br>
        <label class="floatLabel account">Bank Account Number</label>
        <input type="text" class="saveInput" onkeypress="return isNumberKey(event)" name="accnt" maxlength="12">
        <br>
        <label class="floatLabel bankName">Financial Institution Name</label>
        <input type="text" class="saveInput" name="saveName"><br>
      </form>
      <br>
      <form name="SubmitPayment" action="SubmitPayment" method="post">
		<input type = "hidden" name = "policyId" value =<%=request.getAttribute("policyId") %>>
      <input type="submit" class="button buttons" name="SubmitPayment" value="Submit">
      </form>
      <br>
      <br>
      </div>
 </body>
</html>

<style>
  body {
    padding: 5px;
    margin: auto;
    width: 65%;
    text-align: center;
    overflow-y: scroll;
    background: url("https://upload.wikimedia.org/wikipedia/commons/8/8d/Kolkata_Airport_New_Terminal_gate_waiting_area.jpeg") no-repeat center center;
    background-size: cover;
  }
  
  h2 {
    color: rgb(168, 168, 170); 
     text-shadow: 
    -1px -1px 0 #000000, 
    1px -1px 0 #000000,
    -1px 1px 0 #000000,
    1px 1px 0 #000000;
  }

  #background {
    background-color: rgba(209, 208, 206, 0.6);
    border-radius: 4px;
  }

  /*Purchase Review Table*/
  #purchaseReview {
    text-align: left;
    font-size: 25px;
    font-family: 'Roboto';
    border: 1px solid black;
    border-collapse: collapse;
    width: 90%;
    margin: auto;
  }

  #purchaseReview thead {
    text-align: center;
    font-size: 30px;
    color: rgb(168, 168, 170);
     text-shadow: 
    -1px -1px 0 #000000, 
    1px -1px 0 #000000,
    -1px 1px 0 #000000,
    1px 1px 0 #000000;
  }

  #break {
    border-bottom: 1px solid black;
  }

  .price {
    text-align: right;
  }

  #total {
    font-size: 27px;
    font-weight: bold;
    color: rgb(168, 168, 170);
     text-shadow: 
    -1px -1px 0 #000000, 
    1px -1px 0 #000000,
    -1px 1px 0 #000000,
    1px 1px 0 #000000;
  }

  #total .price {
    font-size: 27px;
    font-weight: bold;
    color: rgb(0, 164, 228);
    text-shadow: 
    -1px -1px 0 #000000, 
    1px -1px 0 #000000,
    -1px 1px 0 #000000,
    1px 1px 0 #000000;
  }

  #purchaseReview td {
    padding: 0px 5px;
  }

  p, h2, .button, .checkbox {
      font-family: "Roboto";
  }

  .checkbox {
    height: 50px;
    width: 50px;
  }

  li {
      display: inline-block;
  }
  ul {
    position: relative;
    right: 15px;

  }

  .button {
      border: none;
      border-radius: 4px;
      color: white;
      padding: 10px 10px;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 16px;
      font-weight: bold;
      margin: 4px 25px;
      cursor: pointer;
      transition-duration: 0.4s;
  }

  .buttons {
      border: 2px solid rgb(118, 119, 123);
      color: rgb(84, 86, 91);
      background-color: white;
      width: 155px;
  }

  #creditcard, #checkAccount, #saveAccount {
      height: 80px;
      width: 185px;
      font-size: 22px;
  }

  .buttons:hover {
      background-color:rgb(118, 119, 123); 
      color: white; 
  }

  #checkForm, #cardform, #saveForm {
      display: none;
  }

  .formTitle {
    text-align: left;
    margin-left: 5%;
  }

  hr {
    width: 90%;
    color: black;
  }

  .creditForm, .checkInput, .saveInput{
    height: 40px;
    width: 90%;
    margin: 10px;
  }

  .floatLabel {
    display: inline-block;
    position: relative;
    color: black;
    font-size: 75%;
    top: 15px; 
    padding: 5px;
    font-family: 'Roboto';
  }

  /*Label Alignment*/
  .nickname {
    margin-right: 637px;
  }

  .routing {  
    margin-right: 651px;
  }

  .account {
    margin-right: 616px;

  }

  .bankName {
    margin-right: 600px;

  }

  .creditCard {
    margin-right: 630px;
  }

  .expDate {
    margin-right: 612px;
  }

  .securityCode {
    margin-right: 668px;
  }

  .firstName {
    margin-right: 682px;
  }

  .lastName {
    margin-right: 682px;
  }

  .streetAddress {
    margin-right: 662px;
  }

  .aptSuite {
    margin-right: 635px;
  }

  .cityName {
    margin-right: 683px;
  }

  .selectState {
    margin-right: 671px;
  }

  .zipCode {
    margin-right: 692px;
  }


  #checkForm input, #cardform input, #saveForm input {
      text-align: left;
      background-color: rgba(250, 250, 250, 0.9);
    /* margin: 4px 0px;*/
  }
  select {
    background-color: rgba(250, 250, 250, 0.9);
  }

  #checkForm input:focus, #cardform input:focus, #dtpcker input:focus, textarea:focus, #saveForm input:focus {
      box-shadow: 0 0 5px rgba(81, 203, 238, 1);
      border: 2px solid rgba(81, 203, 238, 1);
  }

  #dtpcker input {
      text-align: center;
  }
  #dateBox {
      position: relative;
      bottom: 13px;
      right: 4px;
  }

</style>