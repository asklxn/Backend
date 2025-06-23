package dao;

import model.Order;
import model.OrderItem;
import java.sql.*;
import java.util.*;

public class OrderDAO {

    private static final String URL = "jdbc:mariadb://localhost:3307/kimdb";
    private static final String USER = "kim";
    private static final String PWD = "1111";

    private Connection getConnection() throws Exception {
        Class.forName("org.mariadb.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PWD);
    }

    // 주문 등록 (Order + OrderItem)
    public void insertOrder(Order order, List<OrderItem> items) {
        Connection conn = null;
        PreparedStatement psOrder = null;
        PreparedStatement psItem = null;

        try {
            conn = getConnection();
            conn.setAutoCommit(false); // 트랜잭션 시작

            // 1. orders 테이블에 삽입
            String orderSql = "INSERT INTO orders (member_id, total_price, status, order_time) VALUES (?, ?, ?, NOW())";
            psOrder = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, order.getMemberId());
            psOrder.setInt(2, order.getTotalPrice());
            psOrder.setString(3, "주문완료");
            psOrder.executeUpdate();

            ResultSet rs = psOrder.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // 2. order_items 테이블에 삽입
            String itemSql = "INSERT INTO order_items (order_id, product_id, quantity) VALUES (?, ?, ?)";
            psItem = conn.prepareStatement(itemSql);

            for (OrderItem item : items) {
                psItem.setInt(1, orderId);
                psItem.setInt(2, item.getProductId());
                psItem.setInt(3, item.getQuantity());
                psItem.addBatch();
            }

            psItem.executeBatch();
            conn.commit();

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        } finally {
            try {
                if (psOrder != null) psOrder.close();
                if (psItem != null) psItem.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // ✅ 회원 ID로 주문 목록 조회 (상품명, 수량, 가격, 썸네일 포함)
    public List<Order> getOrdersByMemberId(int memberId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.order_time, o.total_price, " +
                     "       p.name AS product_name, oi.quantity, p.price, " +
                     "       pi.image_url AS thumbnail " +
                     "FROM orders o " +
                     "JOIN order_items oi ON o.order_id = oi.order_id " +
                     "JOIN products p ON oi.product_id = p.product_id " +
                     "LEFT JOIN product_images pi ON p.product_id = pi.product_id " +
                     "WHERE o.member_id = ? " +
                     "ORDER BY o.order_time DESC";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, memberId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderTime(rs.getTimestamp("order_time"));
                order.setTotalPrice(rs.getInt("total_price"));
                order.setProductName(rs.getString("product_name"));
                order.setQuantity(rs.getInt("quantity"));
                order.setPrice(rs.getInt("price"));
                order.setThumbnail(rs.getString("thumbnail"));
                list.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 주문 ID로 주문 상세 항목 조회
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> list = new ArrayList<>();
        String sql = "SELECT * FROM order_items WHERE order_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setItemId(rs.getInt("item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                list.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
