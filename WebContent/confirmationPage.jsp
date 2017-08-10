<!DOCTYPE html >
<html>
    <head>
        <title>Purchase Confirmation</title>
    </head>
    <link rel = "stylesheet" type = "text/css"
		href = "https://fonts.googleapis.com/css?family=Lato|Roboto|Raleway|Noto+Sans|Work+Sans|Gill+Sans|Open+Sans">
    <body>
            <img id="Logo" src="Images/AIGVector.png" alt="Logo">
            <br>
            <h1>Thank you <%=request.getAttribute("firstName") %> <%=request.getAttribute("lastName") %> for your purchase!</h1>
            <br>
            <br>
            <form id="Return" action="Return" method="post">
                <input id="Return" type="submit" class="button buttons" value = "Return to Main"/>
            </form>

    </body>
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

h1 {
    font-family: 'Roboto';
    color: #54566b;
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
  
  .buttons:hover {
      background-color:rgb(118, 119, 123); 
      color: white; 
  }

#returnMain {
    margin: auto;
	display: inline-block;
	font-family: 'Roboto';
	border: 2px solid rgb(168, 168, 170);
	border-radius: 4px;
    color: rgb(168, 168, 170);
    background-color: white;
	transition-duration: 0.3s;
	display: inline-block;
	font-size: 20px;
	width: 150px;
	height: 60px;
}

#returnMain:hover {
    background-color: rgb(168, 168, 170); 
    color: white; 
}
</style>