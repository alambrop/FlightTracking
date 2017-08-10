import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

public class UpdateTracking {
	
	//variables for connecting to DB
	private static final String JDBC_Driver = "com.mysql.jdbc.Driver";
	private static final String DB_URL = "jdbc:mysql://localhost:3306/flight_db";
	private static final String USER = "root";
	private static final String PASSWORD = "password123";
	
	protected static final String ACCOUNT_SID = "AC50abab0d2168a2a87d80a7eb9bdf1592", AUTH_TOKEN = "e22618296a9bbbcddbf68907bfbcc84f"; // Twilio Info
	
	//Temporary Variables describe information of a flight in the list. 
	private String tempFlightNumber, tempScheduledDepartureDate, tempScheduledDepartureTime, tempScheduledArrivalTime, 
			tempEstimatedDepartureTime, tempEstimatedArrivalTime, tempActualDepartureTime,
			tempActualArrivalTime, tempAirline, tempStatus, tempXML;

	int tempArrDelayMin, tempDepDelayMin, flag;

	public UpdateTracking() throws MalformedURLException {
		System.out.println("hello");
		final ScheduledExecutorService ses = Executors.newSingleThreadScheduledExecutor();
		ses.scheduleWithFixedDelay(new Runnable() {
			public void run() {
				try {
					System.out.println("in update tracking");
					 
					Connection conn = null;
					conn = getDBConnection();
					
					final String getFlightStatus = "SELECT * from flightStatus";
					
					final String updateFlightStatus = "UPDATE flightstatus SET Status = ? WHERE FlightNumber = ? "
							+ "AND ScheduledDepartureDate = ?";
					final String updateEstDep = "UPDATE flightstatus SET EstimatedDepartureTime = ? WHERE FlightNumber = ? "
							+ "AND ScheduledDepartureDate = ?";
					final String updateEstArr = "UPDATE flightstatus SET EstimatedArrivalTime = ? WHERE FlightNumber = ? "
							+ "AND ScheduledDepartureDate = ?";
					final String updateActualDep = "UPDATE flightstatus SET ActualDepartureTime = ? WHERE FlightNumber = ? "
							+ "AND ScheduledDepartureDate = ?";
					
					final PreparedStatement ps = conn.prepareStatement(getFlightStatus);
					
					ResultSet rs = ps.executeQuery();
					while (rs.next()) {
						Instance inst = new Instance();
						Statement stmt = null;
						
						tempFlightNumber = rs.getString("FlightNumber");
						
						tempScheduledDepartureDate = rs.getString("ScheduledDepartureDate");
						tempScheduledDepartureTime = rs.getString("ScheduledDepartureTime");
						tempScheduledDepartureTime = tempScheduledDepartureTime.substring(0, tempScheduledDepartureTime.length() - 2);
						
						//tempScheduledArrivalDate = rs.getString("ScheduledArrivalDate");
						tempScheduledArrivalTime = rs.getString("ScheduledArrivalTime");
						tempScheduledArrivalTime = tempScheduledArrivalTime.substring(0, tempScheduledArrivalTime.length() - 2);
						
						tempEstimatedDepartureTime = rs.getString("EstimatedDepartureTime");
						tempEstimatedDepartureTime = tempEstimatedDepartureTime.substring(0, tempEstimatedDepartureTime.length() - 2);
						
						tempEstimatedArrivalTime = rs.getString("EstimatedArrivalTime");
						tempEstimatedArrivalTime = tempEstimatedArrivalTime.substring(0, tempEstimatedArrivalTime.length() - 2);
						
						tempActualArrivalTime = rs.getString("ActualArrivalTime");
						if (tempActualArrivalTime != null)
							tempActualArrivalTime = tempActualArrivalTime.substring(0, tempActualArrivalTime.length() - 2);
						
						tempActualDepartureTime = rs.getString("ActualDepartureTime");
						if (tempActualDepartureTime != null)
							tempActualDepartureTime = tempActualDepartureTime.substring(0, tempActualDepartureTime.length() - 2);
						
						tempAirline = rs.getString("Airline");
						//tempOrigin = rs.getString("Origin");
						//tempDestination = rs.getString("Destination");
						tempStatus = rs.getString("Status");
						tempXML = rs.getString("XML");
						tempDepDelayMin = rs.getInt("DepDelayMin");
						tempArrDelayMin = rs.getInt("ArrDelayMin");
						
						System.out.println("Flight Number: " + tempFlightNumber);
						System.out.println("old flight status " + tempStatus);
						
						inst.populateFlightObjs(inst.getFlightStringTracking(tempXML));
						inst.flightNum = tempFlightNumber;
						inst.airline = tempAirline;
						 
						System.out.println("new flight number " + inst.flightNum);
						System.out.println("new flight status" + inst.flightStatus);
					
						//statusUpdate(inst.flightStatus, inst.flightNum);
						
						//FLight status change
						if (!inst.flightStatus.equals(tempStatus)) {
							
							final PreparedStatement update = conn.prepareStatement(updateFlightStatus);
							update.setString(1, inst.flightStatus);
							update.setString(2, tempFlightNumber);
							update.setString(3, tempScheduledDepartureDate);
							
							update.executeUpdate();
							
							statusUpdate(inst.flightStatus, inst.flightNum);
						}
						
						
						//Departure Delay
						if (!inst.getLocalDateTime(inst.estGateDep).equals(tempScheduledDepartureTime) && tempActualDepartureTime == null ) {
						
							if (tempDepDelayMin != 0) {
								if(!inst.getLocalDateTime(inst.estGateDep).equals(tempEstimatedDepartureTime)) {
									final PreparedStatement update = conn.prepareStatement(updateEstDep);
									update.setString(1, inst.getLocalDateTime(inst.estGateDep));
									update.setString(2, tempFlightNumber);
									update.setString(3, tempScheduledDepartureDate);
									update.executeUpdate();
									
									depDelay(inst.getLocalDateTime(inst.estGateDep), tempScheduledDepartureTime, inst.flightNum, flag);
								}
								else 
									System.out.println("You have already been notified and your delay has not changed.");
								
							}
							else {
								final PreparedStatement update = conn.prepareStatement(updateEstDep);
								update.setString(1, inst.getLocalDateTime(inst.estGateDep));
								update.setString(2, tempFlightNumber);
								update.setString(3, tempScheduledDepartureDate);
								update.executeUpdate();
								
								depDelay(inst.getLocalDateTime(inst.estGateDep), tempScheduledDepartureTime, inst.flightNum, flag);
							}
						}
						else {
							if (tempActualDepartureTime != null && flag == 0) {
								final PreparedStatement update = conn.prepareStatement(updateActualDep);
								update.setString(1, tempActualDepartureTime);
								update.setString(2, tempFlightNumber);
								update.setString(3, tempScheduledDepartureDate);
								update.executeUpdate();
								
								System.out.println("Your flight has actually departed");
								flag = 1;
								depDelay(tempActualDepartureTime, tempScheduledDepartureTime, inst.flightNum, flag);
							}
						}
						
						
						//Arrival Delay  
						if (!inst.getLocalDateTime(inst.estGateArr).equals(tempScheduledArrivalTime) && tempActualArrivalTime == null) {
						
							if (tempArrDelayMin != 0) {
								if (!inst.getLocalDateTime(inst.estGateArr).equals(tempEstimatedArrivalTime)) {
									final PreparedStatement update = conn.prepareStatement(updateEstArr);
									update.setString(1, inst.getLocalDateTime(inst.estGateArr));
									update.setString(2, tempFlightNumber);
									update.setString(3, tempScheduledDepartureDate);	
									update.executeUpdate();
									
									arrDelay(inst.getLocalDateTime(inst.estGateArr), tempScheduledArrivalTime, inst.flightNum, flag);
								}
								else
									System.out.println("You have already been notified and your delay has not changed.");
							}
							else {
								final PreparedStatement update = conn.prepareStatement(updateEstArr);
								update.setString(1, inst.getLocalDateTime(inst.estGateArr));
								update.setString(2, tempFlightNumber);
								update.setString(3, tempScheduledDepartureDate);	
								update.executeUpdate();
							
								arrDelay(inst.getLocalDateTime(inst.estGateArr), tempScheduledArrivalTime, inst.flightNum, flag);
							}
						}
						
						else {
							if (tempActualArrivalTime != null && flag != 2) {
								final PreparedStatement update = conn.prepareStatement(updateActualDep);
								update.setString(1, tempActualArrivalTime);
								update.setString(2, tempFlightNumber);
								update.setString(3, tempScheduledDepartureDate);
								update.executeUpdate();
								
								System.out.println("Your flight has actually arrived");
								flag = 2;
								arrDelay(tempActualArrivalTime, tempScheduledArrivalTime, inst.flightNum, flag);
							}
						}
						
					}//End while loop
					
				}  catch(SQLException se) {
			        se.printStackTrace();
			    } catch(Exception e) {
			        e.printStackTrace();
			    } 
		
			
			
			}//End Run 
		}, 0, 10, TimeUnit.SECONDS);//The time between updates. End Runnable
	}//End update Tracking method
	
	
	public void statusUpdate(String newStatus, String flightNumber) throws SQLException {
		Connection conn = null;
		conn = getDBConnection();
		
		final String getPolicyID = "SELECT * from insuredflights WHERE FlightNumber = ? ";
		
		final PreparedStatement ps = conn.prepareStatement(getPolicyID);
		ps.setString(1, flightNumber);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			Instance inst = new Instance();
			
			String policyID = rs.getString("PolicyID");
			
			final String getCustomerPhone = "SELECT FirstName, LastName, PhoneNumber from customer WHERE PolicyID = ? ";
			final PreparedStatement ps1 = conn.prepareStatement(getCustomerPhone);
			
			ps1.setString(1, policyID);
			ResultSet rs1 = ps1.executeQuery();
			
			while (rs1.next()) {
				String firstName = rs1.getString("FirstName");
				String lastName = rs1.getString("LastName");
				String phoneNum = rs1.getString("PhoneNumber");
			
				switch (newStatus) {
				
				case "SCHEDULED":
					//Send message to the customer of flight 
					System.out.println("Your flight is now SCHEDULED");
					inst.message = "Your flight is now SCHEDULED";
					sendMessage(phoneNum, inst.message);
					break;
					 		
				case "CANCELED": 
					//Calculate Pay
					System.out.println("Your flight is now CANCELED");
					inst.message = "Your flight is now CANCELED";
					sendMessage(phoneNum, inst.message);
					break;
					 
				case "EN-ROUTE":
					//Get Actual departure Gate minutes. 
					System.out.println("Your flight is now EN-ROUTE");
					inst.message = "Your flight is now EN-ROUTE";
					sendMessage(phoneNum, inst.message);
					break;
					
				case "LANDED": //Landed calculate payment 
					//Get actual landing minutes
					System.out.println("Your flight is now LANDED");
					inst.message = "Your flight is now LANDED";
					sendMessage(phoneNum, inst.message);
					break;
					 	
				default:	
					break;
			
				}//End Switch case
			}//End get phone numbers loop
		}//End Get policys of delayed flight loop
	}//End status update method
	
	public void depDelay(String estDepTime, String schDep, String flightNumber, int flag) throws ParseException, SQLException {
		//Get departure delay
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		LocalDateTime dateTime1= LocalDateTime.parse(schDep, formatter);
		System.out.println(dateTime1);
		LocalDateTime dateTime2= LocalDateTime.parse(estDepTime, formatter);
		System.out.println(dateTime2);
		
		int depDelay = (int) java.time.Duration.between(dateTime1, dateTime2).toMinutes();
		
		final String insertDepartureDelay = "UPDATE flightstatus SET DepDelayMin = ? WHERE FlightNumber = ? "
				+ "AND ScheduledDepartureDate = ?";

		final String query = "SELECT insuredflights.PolicyID, insuredflights.Plan, customer.FirstName, customer.PhoneNumber, customer.LastName "
				+ "FROM insuredflights INNER JOIN customer on insuredflights.PolicyID = customer.PolicyID "
				+ "WHERE insuredflights.FlightNumber = ?"; 
		
		String plan = null, firstName = null, lastName = null, phoneNum = null, policyID = null;
		
		Connection conn = null;
		conn = getDBConnection();
		
		final PreparedStatement check = conn.prepareStatement(query);
		check.setString(1, flightNumber);
		ResultSet rss = check.executeQuery();
		while (rss.next()) {
			policyID = rss.getString("PolicyID");
			plan = rss.getString("Plan");
			firstName = rss.getString("FirstName");
			lastName = rss.getString("LastName");
			phoneNum = rss.getString("PhoneNumber");
		
		}
		//Updates the DB
		final PreparedStatement updateDepDelay = conn.prepareStatement(insertDepartureDelay);
		updateDepDelay.setInt(1, depDelay);
		updateDepDelay.setString(2, tempFlightNumber);
		updateDepDelay.setString(3, tempScheduledDepartureDate);
		updateDepDelay.executeUpdate();
		
		//Checking
		System.out.println("Departure Delay Minutes: " + depDelay);
		
		if (!plan.equals("B") && depDelay >= 15) {
			makeMessage(depDelay, plan, phoneNum, firstName, lastName, flag);
		}
	}//End dep delay method
	
	public void arrDelay(String estArrDelay, String schArr,  String flightNumber, int flag) throws ParseException, SQLException {
		//Gets the arrival Delay Minutes
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		LocalDateTime dateTime1= LocalDateTime.parse(schArr, formatter);
		LocalDateTime dateTime2= LocalDateTime.parse(estArrDelay, formatter);
		
		int diffInMinutes = (int) java.time.Duration.between(dateTime1, dateTime2).toMinutes();
		
		final String insertArrivalDelay = "UPDATE flightstatus SET ArrDelayMin = ? WHERE FlightNumber = ? "
				+ "AND ScheduledDepartureDate = ?";
		final String query = "SELECT insuredflights.PolicyID, insuredflights.Plan, customer.FirstName, customer.PhoneNumber, customer.LastName "
				+ "FROM insuredflights INNER JOIN customer on insuredflights.PolicyID = customer.PolicyID "
				+ "WHERE insuredflights.FlightNumber = ?"; 
		
		String plan = null, firstName = null, lastName = null, phoneNum = null, policyID = null;
		
		Connection conn = null;
		conn = getDBConnection();
		
		final PreparedStatement check = conn.prepareStatement(query);
		check.setString(1, flightNumber);
		ResultSet rss = check.executeQuery();
		
		while (rss.next()) {
			policyID = rss.getString("PolicyID");
			plan = rss.getString("Plan");
			firstName = rss.getString("FirstName");
			lastName = rss.getString("LastName");
			phoneNum = rss.getString("PhoneNumber");
			
		}
		
		//updates the DB
		final PreparedStatement updateArrDelay = conn.prepareStatement(insertArrivalDelay);
		updateArrDelay.setInt(1, diffInMinutes);
		updateArrDelay.setString(2, tempFlightNumber);
		updateArrDelay.setString(3, tempScheduledDepartureDate);	
		updateArrDelay.executeUpdate();
			
		if (!plan.equals("A") && diffInMinutes >= 15) {
			makeMessage(diffInMinutes, plan, phoneNum, firstName, lastName, flag);
		}
	}//End arrival delay method
	
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
	
	
	public void sendMessage(String phoneNum, String userMessage) {
	    Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
	    Message message = Message.creator(new PhoneNumber(phoneNum),  // to
	    		new PhoneNumber("+17049315488 "),  // from
	    		userMessage) // Message or you can use a hashmap
	    		.create();
	    message.getStatus();
	}
	
	public void makeMessage(int diffInMinutes, String plan, String phoneNum, String firstName, String lastName, int flag ) {
		Instance inst = new Instance();
		switch (plan) {
		
		case "A":
			//Send message to the customer of flight 
			if (flag == 1) {
				System.out.println("You have dep Delay Actual");
				inst.message = "Your flight has departed and has been delayed by a total of" + diffInMinutes 
						+ "We will send you a total payment of " + getEstimatedPayment(diffInMinutes, plan) + "to cover your flight";
				sendMessage(phoneNum, inst.message);
			}
			else {
				System.out.println("You have dep Delay Estimate");
				inst.message = "Your flight has been delayed by " + diffInMinutes 
						+ "and is expected to depart soon. You are expected to recieve " + getEstimatedPayment(diffInMinutes, plan);
				sendMessage(phoneNum, inst.message);
				
			}
			
			break;
					 		
		case "B": 
			// Cancelled: determinePaymentNeeded, calculateAmount, sendNotification ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			if (flag == 2) {
				System.out.println("You have arrival delay Actual");
				System.out.println("woaaaaaaaaa is updating");
			inst.message = "your flight has landed and has had a total delay of " + diffInMinutes
						+ "We will send you a total of  " + getEstimatedPayment(diffInMinutes, plan);
				sendMessage(phoneNum, inst.message);
			}
			else {
				System.out.println("You have arrival delay Estimate");
				inst.message = "your flight has been delayed by " + diffInMinutes
						+ "And is expected to land soon SYou are expected to recieve " + getEstimatedPayment(diffInMinutes, plan);
				sendMessage(phoneNum, inst.message);
			}	
			break;
					 
		case "C": // En-route: wait until flight is landed to determinePaymentNeeded
			//Get Actual departure Gate minutes. 
			System.out.println("You have both");
			
			break;
					 	
		default:	
			break;
		}// End Switch Case
	}
	
	public double getEstimatedPayment(int diffInMinutes, String plan) {
		double estimatedPayout = 0;
		switch (plan) {
		
		case "A":
			estimatedPayout = diffInMinutes * 2;
			return estimatedPayout;
				 		
		case "B": 
			estimatedPayout = diffInMinutes * 3;
			return estimatedPayout;
					 
		case "C": 
			estimatedPayout = diffInMinutes * 4;
			return estimatedPayout;	 	
		default:	
			return estimatedPayout;
		}// End Switch Case
	}
}//End class
