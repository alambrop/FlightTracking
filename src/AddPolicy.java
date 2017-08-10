


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

@WebServlet("/AddPolicy")
public class AddPolicy extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final String JDBC_Driver = "com.mysql.jdbc.Driver";
	private static final String DB_URL = "jdbc:mysql://localhost:3306/flight_db";
	private static final String USER = "root";
	private static final String PASSWORD = "password123";
	
	protected static final String ACCOUNT_SID = "AC50abab0d2168a2a87d80a7eb9bdf1592", AUTH_TOKEN = "e22618296a9bbbcddbf68907bfbcc84f"; // Twilio Info
	
   
    public AddPolicy() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
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
		//doGet(request, response);
		
		System.out.println("can reach this?");
		//System.out.println("I'm in the doPost methhhod!");
		String ticketNumber = request.getParameter("ticketNumber");
		System.out.println("ticketNumber: " + ticketNumber);
		String policyPrice = request.getParameter("policyPrice");
		System.out.println( "policyPrice" + policyPrice);
		
		System.out.println("can reach this?");
		
		//String phoneNumber = request.getParameter("phoneNum");
		
		
		String policyId = null, plan = null, firstName = null, lastName = null, phoneNum = null, email = null, bankAccountNumber = null;
		String flightNumber = null, scheduledDepartureDate = null, airline = null, origin = null, destination = null, message = null, planType = null;
		String status = null;
		switch(policyPrice) {
			
			case "250": 
				plan = "A";
				planType = "Silver";
				break;
			
			case "300":
				plan = "B";
				planType = "Gold";
				break;
				
			case "350":
				plan = "C";
				planType = "Platinum";
				break;
			
			default: 
				break;
		}
		
		try {
			Connection conn = null;
			conn = getDBConnection();
		
			final String findTicket = "SELECT * FROM dummytable where TicketNumber = ? ";
			final String addCustomer = "INSERT INTO customer (PolicyID, FirstName, LastName, Email, PhoneNumber, BankAccountNumber)"
										+ "VALUES (?, ?, ?, ?, ?, ?)";
			final String addInsuredFlight = "INSERT INTO insuredflights (PolicyID, FlightNumber, ScheduledDepartureDate, Airline, Origin, "
					+ "Destination, Plan )"
					+ "VALUES (?, ?, ?, ?, ?, ?, ?)";
			
			final String getInitialMessage = "SELECT * FROM flightstatus where flightNumber = ? ";
		
			PreparedStatement ps = conn.prepareStatement(findTicket);
			ps.setString(1,  ticketNumber);
			ResultSet rs = ps.executeQuery();
			System.out.println("can reach this?");
			while(rs.next()) {
				policyId = makePolicyNum();
				System.out.println(policyId);
				firstName = rs.getString("FirstName");
				lastName = rs.getString("LastName");
				email = rs.getString("Email");
				phoneNum = rs.getString("PhoneNumber");
				bankAccountNumber = rs.getString("BankAccountNumber");
				
				flightNumber = rs.getString("FlightNumber");
				scheduledDepartureDate = rs.getString("ScheduledDepartureDate");
				airline = rs.getString("Airline");
				origin = rs.getString("Origin");
				destination = rs.getString("Destination");
				
			}
			System.out.println("can reach this?");
			ps = conn.prepareStatement(addCustomer);
			ps.setString(1, policyId);
			ps.setString(2, firstName);
			ps.setString(3, lastName);
			ps.setString(4, email);
			ps.setString(5, phoneNum);
			ps.setString(6, bankAccountNumber);
			ps.executeUpdate();
			System.out.println("can reach this?");
			ps = conn.prepareStatement(addInsuredFlight);
			ps.setString(1, policyId);
			ps.setString(2, flightNumber);
			ps.setString(3, scheduledDepartureDate);
			ps.setString(4, airline);
			ps.setString(5, origin);
			ps.setString(6, destination);
			ps.setString(7, plan);
			ps.executeUpdate();
			System.out.println("can reach this?");
			UpdateTracking update; 
			
			ps = conn.prepareStatement(getInitialMessage);
			ps.setString(1,  flightNumber);
			rs = ps.executeQuery();
			while (rs.next()) {
				status = rs.getString("Status");
				System.out.println(status);
			}
			
			switch (status) {
			case "SCHEDULED":
				message = "Thank you " + firstName + " " + lastName + " for purchasing " + planType + " AIG travel Inusrance."
						+ " As of this point in time your flight is " + status  
						+ " we will monitor your flight and provide you with regular updates.";
				break;
				
			
			case "EN-ROUTE":
				message = "Thank you " + firstName + " " + lastName + " for purchasing " + planType + " AIG travel Inusrance."
						+ " As of this point in time your flight is " + status  
						+ " we will monitor your flight and provide you with regular updates.";
				break;
				
			case "CANCELLED":
				message = "Thank you " + firstName + " " + lastName + " for purchasing " + planType + " AIG travel Inusrance."
						+ " As of this point in time your flight is " + status  
						+ " we are sorry for the inconvenience and will send you a payment of $300";
				break;
			
			case "LANDED":
				message = "Thank you " + firstName + " " + lastName + " for purchasing " + planType + " AIG travel Inusrance."
						+ " As of this point in time your flight has " + status;
				break;
				
			default: 
				break;
			}
			
		
			
			sendMessage(phoneNum, message);
			update = new UpdateTracking();
			System.out.println(firstName);
			System.out.println(lastName);
			request.setAttribute("firstName", firstName);
			request.setAttribute("lastName", lastName);
			request.getRequestDispatcher("/confirmationPage.jsp").include(request, response);
		
			System.out.println("can reach this?");
		
		}  catch(SQLException se) {
	        se.printStackTrace();
	    } catch(Exception e) {
	        e.printStackTrace();
	    } 
		
			
	}
	
	
	
	 public String makePolicyNum() {
         Random rand = new Random();
         int randInt = (rand.nextInt(2500) + 1);
         return Integer.toString(randInt);
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
