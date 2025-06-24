package controller;

import dao.MemberDAO;
import model.Member;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("username");
        String pwd = request.getParameter("password");

        MemberDAO dao = new MemberDAO();
        Member member = dao.login(id, pwd);

        if (member != null) {
            HttpSession session = request.getSession();
            session.setAttribute("member", member);
            session.setAttribute("id", id); // ✅ 이 코드가 있어야 profile에서 id를 쓸 수 있음
            session.setAttribute("loginId", id);
            session.setAttribute("memberId", member.getMemberId()); // ✅ 이 줄을 추가하세요
            response.sendRedirect("profile");
        } else {
            response.sendRedirect("Frontend/login.jsp?error=1"); // 실패 시
        }
    }
}
