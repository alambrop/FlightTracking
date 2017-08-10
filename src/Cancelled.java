

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Cancelled")
public class Cancelled extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public Cancelled() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Instance instance = new Instance();	
		// Get User information from the database
		String phoneNum = "7046611602";
		String userMessage = "Dear Andy Lambro, we apologize but your flight has been cancelled. According to your flight insurance policy, you are to be compensated $300.";
		instance.SendMessage(phoneNum, userMessage);
		request.getRequestDispatcher("/main.jsp").include(request, response);
	}

}
