package controller;

import dao.OrderDAO;
import model.Order;
import model.OrderItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
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
        String priceStr = request.getParameter("price"); // 제품 단가 전달받는다고 가정

        try {
            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);
            int price = Integer.parseInt(priceStr); // 단가
            int totalPrice = price * quantity;

            // Order 객체 생성
            Order order = new Order();
            order.setMemberId(memberId);
            order.setTotalPrice(totalPrice);
            order.setStatus("주문완료");

            // OrderItem 리스트 생성
            OrderItem item = new OrderItem();
            item.setProductId(productId);
            item.setQuantity(quantity);
            List<OrderItem> items = new ArrayList<>();
            items.add(item);

            // 주문 등록
            OrderDAO dao = new OrderDAO();
            dao.insertOrder(order, items);

            response.sendRedirect("orderHistory");

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('에러가 발생했습니다. 메인 화면으로 이동합니다.'); location.href='productList';</script>");
        }
    }
}
