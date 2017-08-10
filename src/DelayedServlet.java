import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DelayedServlet
 */
@WebServlet("/DelayedServlet")
public class DelayedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DelayedServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Instance instance = new Instance();	
		// Get User information from the database
		String phoneNum = "7046611602";
		String userMessage = "Dear Andy Lambro, your flight UA 3655 has been delayed by 30 minutes. Your AIG Silver Travel Guard Insurance Policy entitles you to receive $300";
		instance.SendMessage(phoneNum, userMessage);
		request.getRequestDispatcher("/main.jsp").include(request, response);
	}

}
