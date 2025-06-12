package cs.dit.member;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class MemberUpdateFormController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        MemberDAO dao = new MemberDAO();
        MemberDTO dto = dao.get(id);  // 기존 정보 불러오기

        request.setAttribute("dto", dto);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/updateForm.jsp");
        dispatcher.forward(request, response);
    }
}
