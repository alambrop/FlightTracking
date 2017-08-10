import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Scheduled")
public class Scheduled extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public Scheduled() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Instance instance = new Instance();	
		// Get User information from the database
		String phoneNum = "7046611602";
		String userMessage = "Dear Andy Lambro, your flight UA 3655 is currently scheduled. We will send updates as needed. Thank you for insuring your flight with AIG Travel Guard.";
		instance.SendMessage(phoneNum, userMessage);
		request.getRequestDispatcher("/main.jsp").include(request, response);
	}

}
