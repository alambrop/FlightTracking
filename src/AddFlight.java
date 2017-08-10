

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/AddFlight")
public class AddFlight extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private static final String JDBC_Driver = "com.mysql.jdbc.Driver";
	private static final String DB_URL = "jdbc:mysql://localhost:3306/flight_db";
	private static final String USER = "root";
	private static final String PASSWORD = "password123";
	
	protected static final String ACCOUNT_SID = "AC50abab0d2168a2a87d80a7eb9bdf1592", AUTH_TOKEN = "e22618296a9bbbcddbf68907bfbcc84f"; // Twilio Info
	
   
    public AddFlight() {
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
		System.out.println("in add flight");
		boolean active;
		
		String plan = null;
		
		String param = request.getParameter("whichPolicy");
		//System.out.println(param);
		
		String param1 = request.getParameter("whichFlight");
		//System.out.println(param1);
		
		 String[] flightItems = param1.split(",");
	     
		 String flightCarrier = flightItems[0];
		 String flightNumber = flightItems[1];
		 
		 String depDate = flightItems[2].substring(0, 10);
		// System.out.println(depDate);
		 
		 String year = depDate.substring(0,4);
		// System.out.println(year);
		 
		 String month = depDate.substring(5,7);
		// System.out.println(month);
		 
		 String day = depDate.substring(8,10);
		 //System.out.println(day);
		 
		 String arrDate = flightItems[3].substring(0,10);
		// System.out.println(arrDate);
		 
		 String depTime = depDate + " " + flightItems[2].substring(17,22) + ":00";
		// System.out.println(depTime);
		 
		 String arrTime = arrDate + " " + flightItems[3].substring(17,22) + ":00";
		// System.out.println(arrTime);
		 
		 String origin = flightItems[4];
		 String destination = flightItems[5];
		 
		 String price = flightItems[6].substring(3, flightItems[6].length());
		 System.out.println(price);
		 
		 String policyId = makePolicyNum();
		 
		 switch(param) {
			
			case "silver": 
				plan = "A";
				break;
			
			case "gold":
				plan = "B";
				break;
				
			case "platinum":
				plan = "C";

				break;
			
			default: 
				break;
		}
		 
		 String xml = "https://api.flightstats.com/flex/flightstatus/rest/v2/xml/flight/status/"+flightCarrier+"/" +flightNumber+"/dep/"+year+"/"+month+"/"+day+"?appId=8e5d80c8&appKey=fe2a921c98cedab96aafcbbc1e80efe2&utc=false&airport="+origin;
	     try {
				Connection conn = null;
				conn = getDBConnection();
				
				final String addFlight = "INSERT INTO flightstatus (FlightNumber, ScheduledDepartureDate, "
						+ "ScheduledDepartureTime, ScheduledArrivalDate, ScheduledArrivalTime, Airline, Origin, Destination, XML)"
						+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
				
				final String addInsuredFlight= "INSERT INTO insuredflights (PolicyID, flightNumber, "
						+ "ScheduledDepartureDate, Airline, Origin, Destination, Plan, TicketPrice)"
						+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
				
			
				PreparedStatement ps = conn.prepareStatement(addFlight);
				ps.setString(1, flightNumber);
				ps.setString(2, depDate);
				ps.setString(3, depTime);
				ps.setString(4, arrDate);
				ps.setString(5, arrTime);
				ps.setString(6, flightCarrier);
				ps.setString(7, origin);
				ps.setString(8, destination);
				ps.setString(9, xml);
				ps.executeUpdate();
				
				ps = conn.prepareStatement(addInsuredFlight);
				ps.setString(1, policyId);
				System.out.println(policyId);
				ps.setString(2, flightNumber);
				ps.setString(3, depDate);
				ps.setString(4, flightCarrier);
				ps.setString(5, origin);
				ps.setString(6, destination);
				ps.setString(7, plan);
				ps.setString(8,  price);
				ps.executeUpdate();

				
	     }  catch(SQLException se) {
		        se.printStackTrace();
		 } catch(Exception e) {
		        e.printStackTrace();
		 } 
			
		
	    request.setAttribute("policyId", policyId);
		request.setAttribute("case", "4");
		request.getRequestDispatcher("/main.jsp").include(request, response);
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
