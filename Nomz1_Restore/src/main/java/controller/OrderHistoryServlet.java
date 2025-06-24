package controller;

import dao.OrderDAO;
import model.Order;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/orderHistory")
public class OrderHistoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String loginId = (session != null) ? (String) session.getAttribute("loginId") : null;
        Integer memberId = (session != null) ? (Integer) session.getAttribute("memberId") : null;

        if (loginId == null || memberId == null) {
            response.sendRedirect("Frontend/login.jsp");
            return;
        }

        OrderDAO orderDAO = new OrderDAO();
        List<Order> orders = orderDAO.getOrdersByMemberId(memberId);

        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/Frontend/orderHistory.jsp").forward(request, response);
    }
}
