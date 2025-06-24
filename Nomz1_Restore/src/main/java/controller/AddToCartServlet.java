package controller;

import dao.CartDAO;
import model.CartItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/addToCart")
public class AddToCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("id") : null;
        Integer memberId = (session != null) ? (Integer) session.getAttribute("memberId") : null;

        if (username == null || memberId == null) {
            response.sendRedirect("Frontend/login.jsp");
            return;
        }

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            String name = request.getParameter("name");
            int count = Integer.parseInt(request.getParameter("count"));
            int price = Integer.parseInt(request.getParameter("price"));
            String imageUrl = request.getParameter("imageUrl");

            CartItem item = new CartItem();
            item.setMemberId(memberId);
            item.setProductId(productId);
            item.setName(name);
            item.setImageUrl(imageUrl);
            item.setCount(count);
            item.setPrice(price);

            CartDAO dao = new CartDAO();
            dao.insertCartItem(item);

            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('장바구니에 추가되었습니다.'); history.back();</script>");
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('장바구니 추가 실패'); history.back();</script>");
        }
    }
}
