package controller;

import dao.QnaDAO;
import model.Question;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/addQuestion")
public class AddQuestionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 세션에서 로그인된 사용자 ID 가져오기 (임시로 member_id = 1 설정)
        HttpSession session = request.getSession();
        Integer memberId = (Integer) session.getAttribute("memberId");
        if (memberId == null) memberId = 1;  // 테스트용 기본값

        String content = request.getParameter("content");

        if (content != null && !content.trim().isEmpty()) {
            Question q = new Question();
            q.setMemberId(memberId);
            q.setContent(content.trim());

            QnaDAO dao = new QnaDAO();
            dao.insertQuestion(q);
        }

        // ✅ 등록 후 정확한 경로로 리다이렉트
        response.sendRedirect(request.getContextPath() + "/qna");
    }
}

