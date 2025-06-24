package controller;

import dao.QnaDAO;
import model.Answer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/addAnswer")
public class AddAnswerServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 세션에서 관리자 여부 확인 (현재는 임시로 무조건 허용)
        String content = request.getParameter("content");
        String qid = request.getParameter("questionId");

        if (content != null && qid != null) {
            try {
                int questionId = Integer.parseInt(qid);

                Answer answer = new Answer();
                answer.setQuestionId(questionId);
                answer.setContent(content.trim());

                QnaDAO dao = new QnaDAO();
                dao.insertAnswer(answer);
            } catch (NumberFormatException e) {
                e.printStackTrace(); // 잘못된 questionId 처리
            }
        }

        response.sendRedirect("qna");
    }
}
