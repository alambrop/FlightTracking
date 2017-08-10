

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


@WebServlet("/LookupPolicy")
public class LookupPolicy extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private static final String JDBC_Driver = "com.mysql.jdbc.Driver";
	private static final String DB_URL = "jdbc:mysql://localhost:3306/flight_db";
	private static final String USER = "root";
	private static final String PASSWORD = "password123";
	
	protected static final String ACCOUNT_SID = "AC50abab0d2168a2a87d80a7eb9bdf1592", AUTH_TOKEN = "e22618296a9bbbcddbf68907bfbcc84f"; // Twilio Info
	
    
    public LookupPolicy() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		String policyId = request.getParameter("policyNum");
		String phoneNumber = request.getParameter("phoneNum");
		
		String plan = null, firstName = null, lastName = null, phoneNum = null, email = null, bankAccountNumber = null;
		String flightNumber = null, scheduledDepartureDate = null, airline = null, origin = null, destination = null;
		String scheduledArrivalTime = null;
		String ticketPrice = null;
		double ticketPrice1 = 0;
		double cost = 0;
		
		
		System.out.println(policyId);
		System.out.println(phoneNumber);
		
		try {
			Connection conn = null;
			conn = getDBConnection();
			
			final String query = "SELECT customer.FirstName, customer.LastName, insuredflights.Plan, insuredflights.TicketPrice, "
					+ "flightstatus.FlightNumber, flightstatus.Airline, flightstatus.ScheduledDepartureTime, flightstatus.ScheduledArrivalTime "
					+ "FROM customer INNER JOIN insuredflights on customer.PolicyID = insuredflights.PolicyID "
					+ "INNER JOIN flightstatus on insuredFlights.FlightNumber = flightstatus.FlightNumber "
					+ "WHERE customer.PolicyId = ?"; 
			
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, policyId);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				firstName = rs.getString("FirstName");
				lastName = rs.getString("LastName");
				plan = rs.getString("Plan");
				flightNumber = rs.getString("FlightNumber");
				airline = rs.getString("Airline");
				scheduledDepartureDate = rs.getString("ScheduledDepartureTime");
				scheduledArrivalTime = rs.getString("ScheduledArrivalTime");
				ticketPrice = rs.getString("TicketPrice");
				
			}
			ticketPrice1 = Double.parseDouble(ticketPrice);
			
			
			switch(plan) {
			case "A":
				//cost = .10 * ticketPrice1;
				request.setAttribute("cost", "20");
				request.setAttribute("plan", "Silver");
				break;
			case "B":
				//cost = .20 * ticketPrice1;
				request.setAttribute("cost", "30");
				request.setAttribute("plan", "Gold");
				break;
			case "C":
				//cost = .30 * ticketPrice1;
				request.setAttribute("cost", "40");
				request.setAttribute("plan", "platinum");
				break;
			}
			
			request.setAttribute("policyId", policyId);
			request.setAttribute("firstName", firstName);
			request.setAttribute("lastName", lastName);
			request.setAttribute("ticketPrice", ticketPrice);
			//request.setAttribute("plan", plan);
			request.setAttribute("flightNumber", flightNumber);
			request.setAttribute("flightCarrier", airline);
			request.setAttribute("departureTime", scheduledDepartureDate);
			request.setAttribute("arrivalTime", scheduledArrivalTime);
			request.setAttribute("case", "2");
			request.getRequestDispatcher("/main.jsp").include(request, response);
			
			
//			System.out.println(firstName);
//			System.out.println(lastName);
//			System.out.println(plan);
//			System.out.println(flightNumber);
//			System.out.println(airline);
//			System.out.println(scheduledDepartureDate);
//			System.out.println(scheduledArrivalTime);
			
			
		}  catch(SQLException se) {
	        se.printStackTrace();
	    } catch(Exception e) {
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
