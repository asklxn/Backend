package controller;

import dao.QnaDAO;
import model.Question;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/qna")
public class QnaListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        QnaDAO dao = new QnaDAO();
        List<Question> list = dao.getAllQuestionsWithAnswers();

        request.setAttribute("questionList", list);
        request.getRequestDispatcher("/Frontend/qna.jsp").forward(request, response);
    }
}
