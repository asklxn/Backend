package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false); // 세션이 있으면 가져오고
        if (session != null) {
            session.invalidate(); // ✅ 세션 완전 삭제
        }

        // 쿠키도 제거하고 싶으면 여기에 추가
        // 예: loginId 자동 로그인 쿠키 제거

        response.sendRedirect("productList"); // 로그아웃 후 이동할 페이지
    }
}
