

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


@WebServlet("/findFlight")
public class findFlight extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String JDBC_Driver = "com.mysql.jdbc.Driver";
	private static final String DB_URL = "jdbc:mysql://localhost:3306/flight_db";
	private static final String USER = "root";
	private static final String PASSWORD = "password123";
	
	protected static final String ACCOUNT_SID = "AC50abab0d2168a2a87d80a7eb9bdf1592", AUTH_TOKEN = "e22618296a9bbbcddbf68907bfbcc84f"; // Twilio Info
	
       
  
    public findFlight() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("I'm in find flight!");
		String ticketNumber = request.getParameter("ticketNum");
		System.out.println(ticketNumber);
		String phoneNumber = request.getParameter("phoneNum");
		String casee = "1";
		String policyID = null, plan = null, firstName = null, lastName = null, phoneNum = null, email = null, bankAccountNumber = null,
			   flightNumber = null, flightCarrier = null, origin = null, destination = null, departureTime = null, arrivalTime = null;
		
		try {
			Connection conn = null;
			conn = getDBConnection();
		
			final String findTicket = "SELECT * FROM dummytable where TicketNumber = ? ";
			/*final String addCustomer = "INSERT INTO customer (PolicyID, FirstName, LastName, Email, PhoneNumber, BankAccountNumber)"
										+ "VALUES (?, ?, ?, ?, ?, ?)";
		*/
			PreparedStatement ps = conn.prepareStatement(findTicket);
			ps.setString(1,  ticketNumber);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				firstName = rs.getString("FirstName");
				System.out.println(firstName);
				lastName = rs.getString("LastName");
				System.out.println(lastName);
				flightNumber = rs.getString("FlightNumber");
				flightCarrier = rs.getString("Airline");
				origin = rs.getString("origin");
				destination = rs.getString("destination");
				departureTime = rs.getString("DepartureTime");
				arrivalTime = rs.getString("ArrivalTime");
			}
			
			request.setAttribute("ticketNumber", ticketNumber);
			request.setAttribute("firstName", firstName);
			request.setAttribute("lastName", lastName);
			request.setAttribute("flightNumber", flightNumber);
			request.setAttribute("flightCarrier", flightCarrier);
			request.setAttribute("origin", origin);
			request.setAttribute("destination", destination);
			request.setAttribute("departureTime", departureTime);
			request.setAttribute("arrivalTime", arrivalTime);
			
			request.setAttribute("case", "1");
			request.setAttribute("firsName", firstName);
			request.setAttribute("lastName", lastName);
			request.getRequestDispatcher("/main.jsp").include(request, response);
			
		/*	ps = conn.prepareStatement(addCustomer);
			ps.setString(1, makePolicyNum());
			ps.setString(2, firstName);
			ps.setString(3, lastName);
			ps.setString(4, email);
			ps.setString(5, phoneNum);
			ps.setString(6, bankAccountNumber);
			ps.executeUpdate();*/
		
		
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
