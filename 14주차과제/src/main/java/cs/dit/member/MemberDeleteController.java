// cs.dit.member.MemberDeleteController.java
package cs.dit.member;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class MemberDeleteController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");

        MemberDAO dao = new MemberDAO();
        dao.delete(id);

        response.sendRedirect(request.getContextPath() + "/member/list");
    }
}
