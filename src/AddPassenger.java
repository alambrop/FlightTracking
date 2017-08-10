

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


@WebServlet("/AddPassenger")
public class AddPassenger extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final String JDBC_Driver = "com.mysql.jdbc.Driver";
	private static final String DB_URL = "jdbc:mysql://localhost:3306/flight_db";
	private static final String USER = "root";
	private static final String PASSWORD = "password123";
	
	protected static final String ACCOUNT_SID = "AC50abab0d2168a2a87d80a7eb9bdf1592", AUTH_TOKEN = "e22618296a9bbbcddbf68907bfbcc84f"; // Twilio Info
	
  
    public AddPassenger() {
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
		
		String firstName = null, lastName = null, phoneNum = null, email = null, bankAccountNumber = null;
		System.out.println("in add passenger");
		
		String plan = null;
		String priceString = null;
		double planPrice = 0;
		double ticketPrice = 0;
		double totalPrice = 0;
		
		String name = request.getParameter("name");
		String[] names = name.split(" ");
		if (names.length > 1) {
			firstName = names[0];
			lastName = names[1];
		}
		else
			firstName = names[0];
		
		email = request.getParameter("email");
		phoneNum = request.getParameter("phoneNum");
	
	
		String policyId = request.getParameter("policyId");
		System.out.println("policyId" + policyId);
		
		final String addCustomer = "INSERT INTO customer (PolicyID, FirstName, LastName, Email, PhoneNumber, BankAccountNumber)"
				+ "VALUES (?, ?, ?, ?, ?, ?)";
		
		final String getTotalPrice = "SELECT insuredflights.Plan, insuredflights.TicketPrice FROM insuredflights WHERE PolicyID = ?";
		
		Connection conn = null;
		conn = getDBConnection();
		
		PreparedStatement ps;
		try {
			ps = conn.prepareStatement(addCustomer);
			ps.setString(1, policyId);
			ps.setString(2, firstName);
			ps.setString(3, lastName);
			ps.setString(4, email);
			ps.setString(5, phoneNum);
			ps.setString(6, bankAccountNumber);
			ps.executeUpdate();
			
			ps = conn.prepareStatement(getTotalPrice);
			ps.setString(1, policyId);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				plan = rs.getString("Plan");
				priceString = rs.getString("TicketPrice");
				
			}
			System.out.println(plan);
			System.out.println(priceString);
			ticketPrice = Double.parseDouble(priceString);
			switch(plan) {
			
			case "A": 
				planPrice = 20;
				break;
			
			case "B":
				planPrice = 30;
				break;
				
			case "C":
				planPrice = 40;
				break;
			
			default: 
				break;
			}
			System.out.println("planPrice" + planPrice);
			System.out.println("ticketPrice" + ticketPrice);
			totalPrice = ticketPrice + planPrice;
			System.out.println("totalPrice " + totalPrice);
	
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		request.setAttribute("policyId", policyId);
		request.setAttribute("ticketPrice", ticketPrice);
		request.setAttribute("policyPrice", planPrice);
		request.setAttribute("totalPrice", totalPrice);
		request.setAttribute("case", "5");
		request.getRequestDispatcher("/Payment.jsp").include(request, response);
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
