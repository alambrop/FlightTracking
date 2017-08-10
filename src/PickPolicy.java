

import java.io.IOException;
import java.text.DecimalFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PickPolicy
 */
@WebServlet("/PickPolicy")
public class PickPolicy extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public PickPolicy() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}


	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		String ticketNumber = request.getParameter("ticketNumber");
		String price = request.getParameter("policyPrice");
		double total = Double.parseDouble(price) + 10;
		String total2 = new DecimalFormat("##.##").format(total);
		
		request.setAttribute("total", total2 );
		request.setAttribute("policyPrice", price);
		request.setAttribute("ticketNumber",ticketNumber);
		request.getRequestDispatcher("/Payment-Policy.jsp").include(request, response);
		
	}

}
