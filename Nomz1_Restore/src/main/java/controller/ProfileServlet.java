package controller;

import dao.MemberDAO;
import model.Member;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String id = (String) session.getAttribute("id");

        System.out.println("[ProfileServlet] session id = " + session.getId());
        System.out.println("[ProfileServlet] session.getAttribute(\"id\") = " + id);

        if (id != null) {
            MemberDAO dao = new MemberDAO();
            Member member = dao.getMemberById(id);
            request.setAttribute("member", member);
        }

        request.getRequestDispatcher("/Frontend/profile.jsp").forward(request, response);
    }
}


