package dao;

import db.DBConnect;
import model.CartItem;
import model.Order;
import model.OrderItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    private Connection conn;

    // 기본 생성자 (직접 DB 연결)
    public OrderDAO() {
        try {
            this.conn = DBConnect.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 외부에서 Connection 주입
    public OrderDAO(Connection conn) {
        this.conn = conn;
    }

    // ✅ 장바구니 기반 주문 등록 (member_id 사용)
    public int insertOrder(int memberId) throws Exception {
        int orderId = 0;
        String sql = "INSERT INTO orders (member_id, total_price, status, order_time) VALUES (?, 0, '주문완료', NOW())";

        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, memberId);
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            }
        }

        return orderId;
    }

    // ✅ 주문 등록: Order + OrderItem 리스트 기반 (상세 구매용)
    public void insertOrder(Order order, List<OrderItem> items) throws Exception {
        String orderSql = "INSERT INTO orders (member_id, total_price, status, order_time) VALUES (?, ?, ?, NOW())";
        String itemSql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";

        try (
            PreparedStatement psOrder = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)
        ) {
            // 주문 등록
            psOrder.setInt(1, order.getMemberId());
            psOrder.setInt(2, order.getTotalPrice());
            psOrder.setString(3, order.getStatus());
            psOrder.executeUpdate();

            ResultSet rs = psOrder.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // 주문 상세 항목 등록
            try (PreparedStatement psItem = conn.prepareStatement(itemSql)) {
                for (OrderItem item : items) {
                    psItem.setInt(1, orderId);
                    psItem.setInt(2, item.getProductId());
                    psItem.setInt(3, item.getQuantity());
                    psItem.setInt(4, item.getPrice());
                    psItem.addBatch();
                }
                psItem.executeBatch();
            }
        }
    }

    // ✅ 주문 상세 항목 저장 (CartItem 기반)
    public void insertOrderItem(int orderId, CartItem item) throws Exception {
        String sql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, item.getProductId());
            ps.setInt(3, item.getCount());
            ps.setInt(4, item.getPrice());
            ps.executeUpdate();
        }
    }

    // ✅ 주문 목록 조회 (회원 ID 기준)
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

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
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

    // ✅ 주문 ID로 상세 항목 조회
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> list = new ArrayList<>();
        String sql = "SELECT * FROM order_items WHERE order_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setItemId(rs.getInt("order_item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getInt("price"));
                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
