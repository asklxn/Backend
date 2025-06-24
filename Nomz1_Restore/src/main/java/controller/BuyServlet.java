package controller;

import dao.OrderDAO;
import db.DBConnect;
import model.Order;
import model.OrderItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/buy")
public class BuyServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        Integer memberId = (session != null) ? (Integer) session.getAttribute("memberId") : null;

        if (memberId == null) {
            response.sendRedirect("Frontend/login.jsp");
            return;
        }

        String productIdStr = request.getParameter("productId");
        String quantityStr = request.getParameter("count");
        String priceStr = request.getParameter("price");

        if (productIdStr == null || quantityStr == null || priceStr == null) {
            response.sendRedirect("productList");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);
            int price = Integer.parseInt(priceStr);
            int totalPrice = price * quantity;

            // 주문 객체 준비
            Order order = new Order();
            order.setMemberId(memberId);
            order.setTotalPrice(totalPrice);
            order.setStatus("주문완료");

            // 주문 상세 항목
            OrderItem item = new OrderItem();
            item.setProductId(productId);
            item.setQuantity(quantity);
            item.setPrice(price);

            List<OrderItem> items = new ArrayList<>();
            items.add(item);

            // DB 연결 및 주문 등록
            try (Connection conn = DBConnect.getConnection()) {
                OrderDAO dao = new OrderDAO(conn);
                dao.insertOrder(order, items);
            }

            // 주문 내역으로 이동
            response.sendRedirect("orderHistory");

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('에러가 발생했습니다. 메인 화면으로 이동합니다.'); location.href='productList';</script>");
        }
    }
}
