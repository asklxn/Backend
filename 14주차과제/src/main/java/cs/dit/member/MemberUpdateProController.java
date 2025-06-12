package cs.dit.member;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class MemberUpdateProController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String pwd = request.getParameter("pwd");
        String photo = request.getParameter("photo");

        MemberDTO dto = new MemberDTO(id, name, pwd, photo);
        MemberDAO dao = new MemberDAO();
        dao.update(dto);

        response.sendRedirect("list");
    }
}
