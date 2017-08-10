

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;


@WebServlet("/SubmitPayment")
public class SubmitPayment extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final String JDBC_Driver = "com.mysql.jdbc.Driver";
	private static final String DB_URL = "jdbc:mysql://localhost:3306/flight_db";
	private static final String USER = "root";
	private static final String PASSWORD = "password123";
	
	protected static final String ACCOUNT_SID = "AC50abab0d2168a2a87d80a7eb9bdf1592", AUTH_TOKEN = "e22618296a9bbbcddbf68907bfbcc84f"; // Twilio Info
	
    
    public SubmitPayment() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
	public void sendMessage(String phoneNum, String userMessage) {
	    Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
	    Message message = Message.creator(new PhoneNumber(phoneNum),  // to
	    		new PhoneNumber("+17049315488 "),  // from
	    		userMessage) // Message or you can use a hashmap
	    		.create();
	    message.getStatus();
	}
	

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		String firstName = null, lastName = null, flightNumber = null, policyId = null, plan = null;
		String phoneNumber = null, airline = null, origin = null, destination = null, ticketPrice = null, message = null;
		double ticketPrice1 = 0;
		double planPrice = 0;
		double totalPrice = 0;
		
		policyId = request.getParameter("policyId");	
		System.out.println(policyId);
		
		final String getTotalPrice = "SELECT customer.FirstName, customer.LastName, customer.PhoneNumber, insuredflights.FlightNumber, "
				+ "insuredFlights.Airline, insuredFlights.Origin, insuredFlights.Destination, insuredflights.Plan, insuredflights.TicketPrice "
				+ "FROM customer INNER JOIN insuredflights ON customer.PolicyID = insuredflights.PolicyID";
		Connection conn = null;
		conn = getDBConnection();
		try {
			PreparedStatement ps = conn.prepareStatement(getTotalPrice);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				firstName = rs.getString("FirstName");
				lastName = rs.getString("LastName");
				phoneNumber = rs.getString("PhoneNumber");
				airline = rs.getString("Airline");
				flightNumber = rs.getString("FlightNumber");
				origin = rs.getString("Origin");
				destination = rs.getString("Destination");
				plan = rs.getString("Plan");
				ticketPrice = rs.getString("TicketPrice");
				
			}
			
			ticketPrice1 = Double.parseDouble(ticketPrice);
			switch(plan) {
			
			case "A": 
				planPrice = 250;
				break;
			
			case "B":
				planPrice = 300;
				break;
				
			case "C":
				planPrice = 350;
				break;
			
			default: 
				break;
			}
			totalPrice = planPrice + ticketPrice1;
			message = "Thank you " + firstName + " " + lastName + " for your purchase from AIG travel insurance. Your policy id is: " 
					+ policyId + ". We will continue to moniter your flight " + airline + " " + flightNumber + "departing from "
					+ origin + " to " + destination + ". Your total price is: " + totalPrice;
			
			sendMessage(phoneNumber, message);
			
			request.setAttribute("firstName", firstName);
			request.setAttribute("lastName", lastName);
			request.getRequestDispatcher("/confirmationPage.jsp").include(request, response);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	
	private static Connection getDBConnection() {
		Connection dbConnection = null;
		
		try {
			Class.forName(JDBC_Driver);		
		} catch (ClassNotFoundException e) {
			System.out.println(e.getMessage());
		}

		try {
			dbConnection = DriverManager.getConnection(DB_URL, USER, PASSWORD);
			return dbConnection;
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return dbConnection;
	}

}
