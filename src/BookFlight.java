

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/BookFlight")
public class BookFlight extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ArrayList<ShowFlights> availableFlights = new ArrayList<ShowFlights>();

    public BookFlight() {
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
		String depAirport = request.getParameter("depAir");
		String arrAirport = request.getParameter("arrAir");
		String date = request.getParameter("dateBox");
		String passengers = request.getParameter("numPassengers");
		
//		System.out.println(depAirport);
//		System.out.println(arrAirport);
//		System.out.println(date);
//		System.out.println(passengers);
		
		Airline air = new Airline();
		air.Begin(passengers, depAirport, arrAirport, date);
		availableFlights = air.getResults();
		
		int time1 = 0;
		int time2 = 0;
		int time3 = 0;
		int time4 = 0;
		
		String str = "<table id='flightAvail' class='flightAvail'><thead><tr><th colspan='6' class='tableHead'><font size='6' color='white'>Available Flights</th>"
				+ "</tr><tr><th>Airline</th><th>Flight Number</th><th>Departure Time</th><th>Arrival Time</th><th>Cost</th><th>Select</th</tr></thead>";

        for (int i = 0; i < availableFlights.size(); i++){

                str +=  "<tr><td>" + availableFlights.get(i).getFlightCarrier() + "</td><td>" + availableFlights.get(i).getFlightNumber() + "</td><td>"
                        + availableFlights.get(i).getOrigin() +" "+ availableFlights.get(i).getDepartureTime().substring(11,21) + "</td><td>" + availableFlights.get(i).getDestination() + " " +
                        availableFlights.get(i).getArrivalTime().substring(11,21) + "</td><td>$" + availableFlights.get(i).getPrice().substring(3,availableFlights.get(i).getPrice().length()) + "</td>" + "<td> <form id='flightCheck" + i + "'><input class='hiddenChecks' type='hidden' name='hiddenCheck' value=''><input type='checkbox' class='planeBox' value=" +
                        availableFlights.get(i).getFlightCarrier() + "," + availableFlights.get(i).getFlightNumber() + "," + availableFlights.get(i).getDepartureTime() 
                        + "," + availableFlights.get(i).getArrivalTime() + "," + availableFlights.get(i).getOrigin() + "," + availableFlights.get(i).getDestination() + "," + availableFlights.get(i).getPrice() + " name='box[1][]'></form></td></tr>";

        }
        str += "</table>";
        request.setAttribute("listTest", str); 

		//System.out.println("in book flight");
		request.setAttribute("case", "3");
		request.getRequestDispatcher("/main.jsp").include(request, response);
	
	}
}
