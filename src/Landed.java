import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Landed")
public class Landed extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Landed() {
        super();
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Instance instance = new Instance();	
		// Get User information from the database
		String phoneNum = "7046611602";
		String userMessage = "Dear Andy Lambro, your flight UA 3655 has landed. We thank you for flying safe with AIG silver Travel Guard Insurance.";
		instance.SendMessage(phoneNum, userMessage);
		instance.SendMessage(phoneNum, userMessage);
		request.getRequestDispatcher("/main.jsp").include(request, response);
	}

}
