import java.util.*;
import java.io.IOException;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.qpxExpress.QPXExpressRequestInitializer;
import com.google.api.services.qpxExpress.QPXExpress;
import com.google.api.services.qpxExpress.model.FlightInfo;
import com.google.api.services.qpxExpress.model.LegInfo;
import com.google.api.services.qpxExpress.model.PassengerCounts;
import com.google.api.services.qpxExpress.model.PricingInfo;
import com.google.api.services.qpxExpress.model.SegmentInfo;
import com.google.api.services.qpxExpress.model.SliceInfo;
import com.google.api.services.qpxExpress.model.TripOption;
import com.google.api.services.qpxExpress.model.TripOptionsRequest;
import com.google.api.services.qpxExpress.model.TripsSearchRequest;
import com.google.api.services.qpxExpress.model.SliceInput;
import com.google.api.services.qpxExpress.model.TripsSearchResponse;

class ShowFlights {
	
	private  String flightID, flightNumber,  flightCarrier, arrivalTime, departureTime, destination, origin, price;
	private  int duration;
	
	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public ShowFlights(String flightID) {
		this.flightID = flightID;
	}
	
	public void setFlightID(String flightID) {
		this.flightID = flightID;
	}
	
	public void setFlightCarrier(String flightCarrier) {
		this.flightCarrier = flightCarrier;
	}
	
	public void setFlightNumber(String flightNumber) {
		this.flightNumber = flightNumber;
	}
	
	public void setDuration(int duration) {
		this.duration = duration;
	}
	
	public void setArrivalTime(String arrivalTime) {
		this.arrivalTime = arrivalTime;
	}
	
	public void setDepartureTime(String departureTime) {
		this.departureTime = departureTime;
	}
	
	public void setDestination(String destination) {
		this.destination = destination;
	}
	
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	
	public String getFlightID() {
		return flightID;
	}
	
	public int getDuration() {
		return duration;
	}
	
	public String getFlightNumber() {
		return flightNumber;
	}
	
	public String getFlightCarrier() {
		return flightCarrier;
	}
	
	public String getArrivalTime() {
		return arrivalTime;	
	}
	
	public String getDepartureTime() {
		return departureTime; 
	}
	
	public String getDestination() {
		return destination;
	}
	
	public String getOrigin() {
		return origin;
	}

}
public class Airline {
	private static final String APPLICATION_NAME = "FlightTesting";
	// Peyton's Key: AIzaSyC1pdidilmmS-Z8pkdekf7OwFONrP-LOpE
	// Andrew's Key: AIzaSyBHJCKp-UxaafkJEzrEOI0s2LJbdJZOxu4
    private static final String API_KEY = "AIzaSyBHJCKp-UxaafkJEzrEOI0s2LJbdJZOxu4"; 
    
    private ArrayList<ShowFlights> displayFlights = new ArrayList<ShowFlights>();
    private List<PricingInfo> priceInfo;
  
    /** Global instance of the HTTP transport. */
    private static HttpTransport httpTransport;

    /** Global instance of the JSON factory. */
    private static final JsonFactory JSON_FACTORY = JacksonFactory.getDefaultInstance();

    
    public ArrayList<ShowFlights> getResults() {
    	return displayFlights;
    }
    
    public void Begin(String numPass, String depAir, String arrAir, String date) {
    	ShowFlights bookedFlight;	
    	try {
    	   	httpTransport = GoogleNetHttpTransport.newTrustedTransport();
    	   	
    	   	PassengerCounts passengers= new PassengerCounts();
            passengers.setAdultCount(Integer.parseInt(numPass));

            List<SliceInput> slices = new ArrayList<SliceInput>();

            SliceInput slice = new SliceInput();
            slice.setOrigin(depAir); 
            slice.setDestination(arrAir); 
            slice.setDate(date);
            slice.setMaxStops(0);
            slices.add(slice);
           
            TripOptionsRequest request= new TripOptionsRequest();
            request.setSolutions(50
            		);
            request.setPassengers(passengers);
            request.setSlice(slices);

            TripsSearchRequest parameters = new TripsSearchRequest();
            parameters.setRequest(request);
            QPXExpress qpXExpress= new QPXExpress.Builder(httpTransport, JSON_FACTORY, null).setApplicationName(APPLICATION_NAME)
                    .setGoogleClientRequestInitializer(new QPXExpressRequestInitializer(API_KEY)).build();

            TripsSearchResponse list= qpXExpress.trips().search(parameters).execute();
            List<TripOption> tripResults=list.getTrips().getTripOption();
           // System.out.println("Trips: " + tripResults.size());
            String id;
            
            for(int i=0; i < tripResults.size(); i++) {
                id= tripResults.get(i).getId();
               
                bookedFlight = new ShowFlights(id);
                displayFlights.add(bookedFlight);
                //System.out.println("Flight ID: " + displayFlights.get(i).getFlightID());
                //Slice
                List<SliceInfo> sliceInfo= tripResults.get(i).getSlice();
                //System.out.println("Slice: " + sliceInfo.size());
                for(int j=0; j< sliceInfo.size() && displayFlights.size() > 0; j++) {
                	
                    int duration= sliceInfo.get(j).getDuration();
                    List<SegmentInfo> segInfo= sliceInfo.get(j).getSegment();
                    displayFlights.get(i).setDuration(duration);
               
                    for(int k=0; k<segInfo.size() && displayFlights.size() > 0; k++) {
                        FlightInfo flightInfo=segInfo.get(k).getFlight();
                        String flightNum= flightInfo.getNumber();
                        String flightCarrier= flightInfo.getCarrier();
                        List<LegInfo> leg=segInfo.get(k).getLeg();
                        
                        displayFlights.get(i).setFlightNumber(flightNum);
                        displayFlights.get(i).setFlightCarrier(flightCarrier);
                        
                        for(int l=0; l<leg.size() && displayFlights.size() > 0; l++) {
                        	
                            String arrivalTime= leg.get(l).getArrivalTime();
                            String departTime=leg.get(l).getDepartureTime();
                            String dest=leg.get(l).getDestination();
                            String origin=leg.get(l).getOrigin();
                            
                            displayFlights.get(i).setDepartureTime(departTime);
                            displayFlights.get(i).setArrivalTime(arrivalTime);
                            displayFlights.get(i).setDestination(dest);
                            displayFlights.get(i).setOrigin(origin);
                  
                        }
                    }
                }
            //Pricing *********************************************************************************************
            priceInfo = tripResults.get(i).getPricing();
            
            for(int p = 0; p < priceInfo.size(); p++) {
                String price = priceInfo.get(p).getSaleTotal();
                //System.out.println("Trip size: " + displayFlights.size() + "\t Price Size" + priceInfo.size());
                //System.out.println("Price " + price);
                displayFlights.get(i).setPrice(price);
            }
        }
        for (int a = 0; a < displayFlights.size(); a++) {
        	System.out.println("\n\n\n");
        	System.out.println("Flight ID: " + displayFlights.get(a).getFlightID());
        	System.out.println("Flight Number: " + displayFlights.get(a).getFlightNumber());
        	System.out.println("Flight Carrier: " + displayFlights.get(a).getFlightCarrier());
        	System.out.println("Duration: " + displayFlights.get(a).getDuration());
        	System.out.println("Departing: " + displayFlights.get(a).getOrigin());
        	System.out.println("Arriving: " + displayFlights.get(a).getDestination());
        	System.out.println("Departure Time: " + displayFlights.get(a).getDepartureTime());
        	System.out.println("Arriving Time: " + displayFlights.get(a).getArrivalTime());
        	System.out.println("Price: " + displayFlights.get(a).getPrice());
        }
    } catch (IOException e) {
      System.err.println(e.getMessage());
    } catch (Throwable t) {
      t.printStackTrace();
    }

  }
    
   

}
