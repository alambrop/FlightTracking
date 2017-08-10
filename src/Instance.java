import java.io.*;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.xml.transform.TransformerException;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;

import com.google.api.services.qpxExpress.model.PricingInfo;
import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

public class Instance {
	// *****************************************************INSTANCE VARIABLES****************************************************************************
	// Fields that are needed when processing info for a CustomerFlightProduct ***************************************************************************
	// ***************************************************************************************************************************************************
	protected static final String APPLICATION_NAME = "FlightTesting";
	// Peyton's Key: AIzaSyC1pdidilmmS-Z8pkdekf7OwFONrP-LOpE
	// Andrew's Key: AIzaSyBHJCKp-UxaafkJEzrEOI0s2LJbdJZOxu4
    protected static final String API_KEY = "AIzaSyBHJCKp-UxaafkJEzrEOI0s2LJbdJZOxu4";
	protected static final String ACCOUNT_SID = "AC50abab0d2168a2a87d80a7eb9bdf1592", AUTH_TOKEN = "e22618296a9bbbcddbf68907bfbcc84f"; // Twilio Info
	protected String airline, flightNum, depAir, arrAir, date, day, month, year, 			// General flight info
	schGateDep, estGateDep, schGateArr, estGateArr, estRunwayDep, estRunwayArr, 			// Flight timing info
	depDate, arrDate, schTakeOff, actTakeOff, schArr, actArr, 								// More flight timing info
	depGateDelayMin, arrGateDelayMin, voucher, 														// Flight delay info
	fName, lName, policyNum, phoneNum, email, address, message, bankActNum, bookRLN, 		// Customer info
	flightStatus, flightUrl, weatherUrl, flightXMLString, weatherXMLString,					// Status and link to sites
	flightID, flightNumber,  flightCarrier, arrivalTime, departureTime, destination, origin, price, policyType;
	protected char cancelled, delayed, accident; 
	protected int ratePerDuration, maxMin, maxRate, cancelRate, bagRate, accidentRate, duration, id =  1, numBags;
	protected double premium, paymentOwed, totalDelayMin;
	protected ArrayList<String> flightKeyWords = new ArrayList<String>(), weatherKeyWords = new ArrayList<String>(),  
			flightInfo = new ArrayList<String>(),  weatherInfo = new ArrayList<String>(), 
			flightXMLTags = new ArrayList<String>(), weatherDays = new ArrayList<String>(),
			weatherForecast = new ArrayList<String>(), policyList = new ArrayList<String>();
	//protected ArrayList<ShowFlights> displayFlights = new ArrayList<ShowFlights>();
	protected List<PricingInfo> priceInfo;
	public int notified = 0;
	// ***************************************************************************************************************************************************
	// *****************************************************FUNCTIONS START HERE**************************************************************************
	// ***************************************************************************************************************************************************
	public void makeID(){
		Random rand = new Random();
        int randInt = (rand.nextInt(3750) + 1);
        id = randInt;
	}
	 public void makePolicyNum() {
         Random rand = new Random();
         int randInt = (rand.nextInt(2500) + 1);
         policyNum = Integer.toString(randInt);
	 }
	 public void makeBookingRLN() {
         Random rand = new Random();
         int randInt = (rand.nextInt(2500) + 1);
         bookRLN = Integer.toString(randInt);
	 }
	public void printFields() {
		System.out.println(airline + flightNum + depAir + arrAir);
		System.out.println(day + month + year);		System.out.println(fName + lName + phoneNum);
		System.out.println("Flight Url " + flightUrl);
		for(int i = 0; i < flightInfo.size(); i++) {
			System.out.println("Flight: " + flightInfo.get(i));
		}
		for(int j = 0; j < weatherInfo.size(); j++){
			System.out.println("Weather: " + weatherInfo.get(j));
		}
		System.out.println("Info "+  weatherInfo.size());
		System.out.println("days "+ weatherDays.size());
		System.out.println("forecast "+ weatherForecast.size());
		System.out.println("Status: " + flightStatus);
	}
	// Parses date strings and returns an arrayList containging the information *****************************************************************
	// Date is returned in this format, "HH:mm:ss MM/dd/yyyy" for the local time only
	public String getLocalDateTime(String date) throws ParseException {
		String localFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS", formattedLocal = "",
				dateTime = StringUtils.substringBetween(date, "<dateLocal>", "</dateLocal>");
		SimpleDateFormat sdfLocal = new SimpleDateFormat(localFormat);
		SimpleDateFormat output = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date d = sdfLocal.parse(dateTime);
		formattedLocal = output.format(d);
		//System.out.println("Formatted Local Time: " + formattedLocal);
		return formattedLocal;
	}
	public String getLocalTime(String date1) throws ParseException {
		String localFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS", timeFormattedLocal = "",
				dateTime = StringUtils.substringBetween(date1, "<dateLocal>", "</dateLocal>");
		SimpleDateFormat sdfLocal = new SimpleDateFormat(localFormat);
		SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
		Date d = sdfLocal.parse(dateTime);
		timeFormattedLocal = timeFormat.format(d);
		//System.out.println("Formatted Local Time: " + formattedLocal);
		return timeFormattedLocal;
	}
	public String getLocalDate(String date1) throws ParseException {
		String localFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS", dateFormattedLocal = "", 
				dateTime = StringUtils.substringBetween(date1, "<dateLocal>", "</dateLocal>");
		SimpleDateFormat sdfLocal = new SimpleDateFormat(localFormat);
		SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
		Date d = sdfLocal.parse(dateTime);
		
		dateFormattedLocal = dateFormat.format(d);
		//System.out.println("Formatted Local Time: " + formattedLocal);
		return dateFormattedLocal;
	}
	
	// Adds information about rates based on policy type given ****************************************************************************************
	public void addPolicyConditions(String type){
		switch(type) {
		case "A" :
			duration = 10;
			ratePerDuration = 15; // In minutes and dollars
			maxMin = 30;
			maxRate = 45;
			cancelRate = 45;
			bagRate = 15;
			accidentRate = 45;
			premium = 45;
			break;
		case "B" :
			duration = 20;
			maxMin = 40;
			ratePerDuration = 25;
			maxRate = 50;
			cancelRate = 50;
			bagRate = 25;
			accidentRate = 50;
			premium = 50;
			break;
		case "C" :
			duration = 30;
			maxMin = 50;
			ratePerDuration = 50;
			maxRate = 100;
			cancelRate = 100;
			bagRate = 50;
			accidentRate = 100;
			premium = 100;
			break;
		case "D" :
			duration = 40;
			maxMin = 60;
			ratePerDuration = 100;
			maxRate = 200;
			cancelRate = 200;
			bagRate = 100;
			accidentRate = 200;
			premium = 200;
			break;
		case "E" :
			duration = 60;
			maxMin = 120;
			ratePerDuration = 150;
			maxRate = 300;
			cancelRate = 300;
			bagRate = 150;
			accidentRate = 300;
			premium = 300;
			break;
		default:
			break;
		}
	}
	
	
	// Populates flight objects **************************************************************************************************************************
	public void populateFlightObjs(String liveFlight) {
		// Begin parsing string
        flightKeyWords.add("weatherUrl");					flightKeyWords.add("scheduledGateDeparture"); 		flightKeyWords.add("estimatedGateDeparture");
		flightKeyWords.add("scheduledGateArrival"); 		flightKeyWords.add("estimatedGateArrival");			flightKeyWords.add("estimatedRunwayDeparture");	
		flightKeyWords.add("estimatedRunwayArrival");		flightKeyWords.add("departureGateDelayMinutes");	flightKeyWords.add("arrivalGateDelayMinutes");
		flightKeyWords.add("status"); 						flightKeyWords.add("departureAirportFsCode"); 		flightKeyWords.add("arrivalAirportFsCode");
		flightKeyWords.add("actualGateArrival");			flightKeyWords.add("actualGateDeparture");
		flightInfo.add(StringUtils.substringBetween(liveFlight, "<weatherUrl>", "</weatherUrl>"));
		flightInfo.add(StringUtils.substringBetween(liveFlight, "<scheduledGateDeparture>", "</scheduledGateDeparture>"));
		flightInfo.add(StringUtils.substringBetween(liveFlight, "<estimatedGateDeparture>", "</estimatedGateDeparture>"));
		flightInfo.add(StringUtils.substringBetween(liveFlight, "<scheduledGateArrival>", "</scheduledGateArrival>"));
		flightInfo.add(StringUtils.substringBetween(liveFlight, "<estimatedGateArrival>", "</estimatedGateArrival>"));
		flightInfo.add(StringUtils.substringBetween(liveFlight, "<estimatedRunwayDeparture>", "</estimatedRunwayDeparture>"));
		flightInfo.add(StringUtils.substringBetween(liveFlight, "<estimatedRunwayArrival>", "</estimatedRunwayArrival>"));
		flightInfo.add(StringUtils.substringBetween(liveFlight, "<departureGateDelayMinutes>", "</departureGateDelayMinutes>"));
		flightInfo.add(StringUtils.substringBetween(liveFlight, "<arrivalGateDelayMinutes>", "</arrivalGateDelayMinutes>"));
		flightInfo.add(StringUtils.substringBetween(liveFlight, "<status>", "</status>"));
		flightInfo.add(StringUtils.substringBetween(liveFlight, "<departureAirportFsCode>", "</departureAirportFsCode>"));
		flightInfo.add(StringUtils.substringBetween(liveFlight, "<arrivalAirportFsCode>", "</arrivalAirportFsCode>"));
		flightInfo.add(StringUtils.substringBetween(liveFlight, "<actualGateDeparture>", "</actualGateDeparture"));
		flightInfo.add(StringUtils.substringBetween(liveFlight, "<actualGateArrival>", "</actualGateArrival"));
		for(int i = 0; i < flightInfo.size(); i++) {
			flightXMLTags.add(flightKeyWords.get(i) + ": " + flightInfo.get(i));
			switch(i) {
				case 0: weatherUrl = flightInfo.get(i); break;
				case 1: schGateDep = flightInfo.get(i); break;
				case 2: estGateDep = flightInfo.get(i); break;
				case 3: schGateArr = flightInfo.get(i); break;
				case 4: estGateArr = flightInfo.get(i); break;
				case 5: estRunwayDep = flightInfo.get(i); break;
				case 6: estRunwayArr = flightInfo.get(i); break;
				case 7: depGateDelayMin = flightInfo.get(i); break;
				case 8: arrGateDelayMin = flightInfo.get(i); break;
				case 9: flightStatus = GetStrStatus(flightInfo.get(i)); break;
				case 10: depAir = flightInfo.get(i); break;
				case 11: arrAir = flightInfo.get(i); break;
				case 12: actTakeOff = flightInfo.get(i); break;
				case 13: actArr = flightInfo.get(i); break;
				default: break;
			}
		}
	}
	
	@SuppressWarnings("deprecation")
	public String getFlightStringTracking(String stringUrl) 
			throws IOException {
		String liveFlight = "";
		String flightUrl1 = stringUrl;

		if(flightUrl1.contains("null")) {
			flightUrl1 = flightUrl1.replaceAll("null", "");
		}
		URL url = new URL(flightUrl1);
		InputStream inStream = null;
		DataInputStream diStream = null;
        try {
        	inStream = url.openStream();
        	diStream = new DataInputStream(new BufferedInputStream(inStream));
        	while((liveFlight = diStream.readLine())!= null) {
        		flightXMLString = liveFlight;
        		populateFlightObjs(liveFlight);
        		return liveFlight;
        	}
        }
        catch(IOException e){
        	 e.printStackTrace();
        } finally {
        	if(inStream != null)
        		inStream.close();
        	if(diStream != null)
        		diStream.close();
        }
		return liveFlight;	
	}
	
	// Transfers url to xml to string and calls populate flight object ******************************************************************************
	@SuppressWarnings("deprecation")
	public String getFlightString(String airline, String flightNum, String year, String month, String day, String depAir, String arrAir) 
			throws IOException {
		String liveFlight = "";
		flightUrl = "https://api.flightstats.com/flex/flightstatus/" + "rest/v2/xml/flight/status/"+ airline + "/" 
			+ flightNum + "/" + "dep/" + year + "/" + month + "/" + day + "?appId=f2813919&appKey=9856af84a9dc76680adb93a6d94e85bc&utc=false"
			+ "&airport=" + depAir;
		if(flightUrl.contains("null")) {
			flightUrl = flightUrl.replaceAll("null", "");
		}
		URL url = new URL(flightUrl);
		InputStream inStream = null;
		DataInputStream diStream = null;
        try {
        	inStream = url.openStream();
        	diStream = new DataInputStream(new BufferedInputStream(inStream));
        	while((liveFlight = diStream.readLine())!= null) {
        		flightXMLString = liveFlight;
        		populateFlightObjs(liveFlight);
        		return liveFlight;
        	}
        }
        catch(IOException e){
        	 e.printStackTrace();
        } finally {
        	if(inStream != null)
        		inStream.close();
        	if(diStream != null)
        		diStream.close();
        }
		return liveFlight;	
	}
	// Reads xml that contains all the information ahout weather and adds it to arraylist **********************************************************
	// Populates weatherInfo, weatherDays, and weatherForecast
	public void populateWeatherInfo(String url) throws IOException, TransformerException, Exception {
		url = url.replaceAll("codeType=fs", "");
		url = url.replaceAll("json", "xml");
		URL weather = new URL(url + "appId=f2813919&appKey=9856af84a9dc76680adb93a6d94e85bc&utc=false");
		String str  = "", dayStr = "", forecastStr = "", temp = "";
		InputStream in = weather.openStream();
		 try {
			 str = IOUtils.toString(in); // String created from url
		 } finally {
		   IOUtils.closeQuietly(in);
		 }
		 //System.out.println("String: " + str);
		 dayStr = str; forecastStr = str;
		 temp = str.substring((str.indexOf("<temperatureCelsius>") + 20), str.indexOf("</temperatureCelsius>"));
			weatherInfo.add(temp);
			while(dayStr.contains("<day>")) {
				temp = dayStr.substring((dayStr.indexOf("<day>") + 5), dayStr.indexOf("</day>"));
				weatherInfo.add(temp);
				weatherDays.add(temp);
				dayStr = dayStr.substring(dayStr.indexOf("</day>") + 6);
			}
			while(forecastStr.contains("<forecast>")) {
				temp = forecastStr.substring((forecastStr.indexOf("<forecast>") + 10), forecastStr.indexOf("</forecast>"));
				weatherInfo.add(temp);
				weatherForecast.add(temp);
				forecastStr = forecastStr.substring(forecastStr.indexOf("</forecast>") + 10);
			}
	}
	// Calculates the total delay min regarless of when  the delay occurred *******************************************************************************
	public void calcTotalDelayMin(){
		totalDelayMin = Double.parseDouble(arrGateDelayMin) + Double.parseDouble(depGateDelayMin);
	}
	// Returns the status for the given attribute (keyword) ***********************************************************************************************
	public String getAttribute(String keyword) { 
		String ret = "";
		for(int i = 0; i < flightXMLTags.size(); i++) {
			if (flightXMLTags.get(i).contains(keyword)) {
				ret = flightInfo.get(i);
			}
		}
		return ret;
	}
	// Converts a float of temperature celsius to a string in degrees *************************************************************************************
	public String toFahrenheit(float celsius) {
        float fahrenheit = 9 * (celsius / 5) + 32;
        String f = Float.toString(fahrenheit);
        return f;
    }
	// Gets status of flight and returns the entire word that correlates to the letter ********************************************************************
	public String GetStrStatus(String status) {
    	String str = "";
    	switch(status) {
    		case "s": case "S":
    			str = "SCHEDULED";
    			break;
    		case "c": case "C":
    			str = "CANCELLED";
    			break;
    		case "a": case "A":
    			str = "EN-ROUTE";
    			break;
    		case "l": case "L":
    			str = "LANDED";
    			break;
    		default:
    			break;
    	}
    	return str;
    }
	// Gets status of flight and updates user message based on the current flight status *****************************************************************
	// Needs to update message & call send message based on the current status of the flight
	public void UpdateUser() {
	    	switch (flightStatus) {
			case "s": case "S": case "SCHEDULED": // Scheduled: wait until flight is either cancelled or landed to determinePaymentNeeded
				message = "NEW UPDATE: Your flight, " + airline + flightNum + " is currently scheduled. Check back for updates.";
				SendMessage(phoneNum, message);
				break;
			case "c": case "C": case "CANCELLED": // Cancelled: determinePaymentNeeded, calculateAmount, sendNotification ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				cancelled = 't';
				message = "NEW UPDATE: We apologize, but your flight, " + airline + flightNum + 
				"has been cancelled. Your total claim amount is " + paymentOwed + " to this account: " + bankActNum + ". Your payment has been sent.";
				SendMessage(phoneNum, message);
				break;
			case "a": case "A": case "EN-ROUTE":  // En-route: wait until flight is landed to determinePaymentNeeded
				message = "NEW UPDATE: Your flight, " + airline + flightNum +", from " + depAir + " to " + arrAir +
					" is currently en-route. Check back for updates.";
				SendMessage(phoneNum, message);
				break;
			case "l": case "L": case "LANDED":// Landed: determinePaymentNeeded, calculateAmount, sendNotification ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				message = "NEW UPDATE: Your flight, " + airline + flightNum + " has landed. Thank you for doing business with us." + 
						" If your flight encountered a delay and your policy covers delay, you will receive more information regarding payment soon";
				SendMessage(phoneNum, message);
				break;
			default:
				break;
			}
	    	if(totalDelayMin != 0 && (flightStatus.equals("l") || flightStatus.equals("L") || flightStatus.equals("LANDED"))) { // Check if there is a delay after flight has landed
	    		delayed = 't';
	    			message = "INSURANCE UPDATE: Your flight, " + airline + flightNum + "has landed. Our records show that your flight was " + 
	    						totalDelayMin + " minutes delayed. Your total claim amount is " + paymentOwed + " to this account: " + bankActNum +
	    						". Your payment has been sent.";
	    		SendMessage(phoneNum, message);
	    	}
	    }
	// Calculates payment owed to customer based on the policy and their premium ********************************************************************
	 public double calculatePayment(String type) {
			int delayTime = 0;
			switch(type) {
			case "A" :
				
				if (Integer.parseInt(depGateDelayMin) <10 || Integer.parseInt(depGateDelayMin) > 30) {
					paymentOwed = 0;		
				}
				else {
					delayTime = (int) (Integer.parseInt(depGateDelayMin) / 10);
					paymentOwed = (delayTime * 15);
				}
				
				break;
			case "B" :
				if (Integer.parseInt(arrGateDelayMin) < 20 || Integer.parseInt(arrGateDelayMin) > 40) {
					paymentOwed = 0;		
				}
				else {
					delayTime = (int) (Integer.parseInt(arrGateDelayMin) / 10);
					paymentOwed = (delayTime * 25);
				}
				
				break;
			case "C" :
				if (Integer.parseInt(depGateDelayMin) < 30 || Integer.parseInt(depGateDelayMin) > 50) {
					paymentOwed = 0;		
				}
				else {
					delayTime = (int) (Integer.parseInt(depGateDelayMin) / 10);
					paymentOwed = (delayTime * 50);
				}
				
				break;
			case "D" :
				if (Integer.parseInt(arrGateDelayMin) < 40 || Integer.parseInt(arrGateDelayMin)> 60) {
					paymentOwed = 0;		
				}
				else {
					delayTime = (int) (Integer.parseInt(arrGateDelayMin) / 10);
					paymentOwed = (delayTime * 100);
				}
				break;
			case "E" :
				int totalDelayMin = Integer.parseInt(depGateDelayMin) + Integer.parseInt(arrGateDelayMin);
				if (totalDelayMin  < 60 ) {
					paymentOwed = 0;		
				}
				else {
					delayTime = (int) (totalDelayMin - 60) / 30;
					paymentOwed =((delayTime * 150) + 150);
				}
				break;
			default:
				paymentOwed = 0;
				break;
			}
			return paymentOwed;
		}
	// Sends Message to user ************************************************************************************************************************
	 public void SendMessage(String phoneNum, String userMessage) {
		    Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
		    Message message = Message.creator(new PhoneNumber(phoneNum),  // to
		    		new PhoneNumber("+17049315488 "),  // from
		    		userMessage) // Message or you can use a hashmap
		    		.create();
		    message.getStatus();
	 }
}
