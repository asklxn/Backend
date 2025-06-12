package cs.dit.member;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;

public class MemberListController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MemberDAO dao = new MemberDAO();
        List<MemberDTO> memberList = dao.list();

        request.setAttribute("dtos", memberList); // ✅ JSP와 이름 일치
        RequestDispatcher dispatcher = request.getRequestDispatcher("/list.jsp");
        dispatcher.forward(request, response);
    }
}
