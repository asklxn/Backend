package controller;

import dao.CartDAO;
import model.CartItem;
import db.DBConnect;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);

        // 세션 확인 및 로그인 여부 체크
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect("Frontend/login.jsp");
            return;
        }

        String username = (String) session.getAttribute("id");

        try (Connection conn = DBConnect.getConnection()) {
            CartDAO cartDAO = new CartDAO(conn);
            List<CartItem> cartItems = cartDAO.getCartItems(username);

            request.setAttribute("cartItems", cartItems);
            RequestDispatcher rd = request.getRequestDispatcher("Frontend/cart.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "장바구니 조회 중 오류 발생");
        }
    }
}
