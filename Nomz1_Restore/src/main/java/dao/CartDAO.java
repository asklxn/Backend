package dao;

import db.DBConnect;
import model.CartItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {
    private Connection conn;

    // 기본 생성자
    public CartDAO() {
        try {
            conn = DBConnect.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ Connection을 인자로 받는 생성자 (CartServlet에서 사용)
    public CartDAO(Connection conn) {
        this.conn = conn;
    }

    public void insertCartItem(CartItem item) throws Exception {
        String sql = "INSERT INTO cart (member_id, product_id, name, image_url, price, count) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, item.getMemberId());
            ps.setInt(2, item.getProductId());
            ps.setString(3, item.getName());
            ps.setString(4, item.getImageUrl());
            ps.setInt(5, item.getPrice());
            ps.setInt(6, item.getCount());
            ps.executeUpdate();
        }
    }

    public List<CartItem> getCartItems(String username) throws Exception {
        List<CartItem> list = new ArrayList<>();
        String sql = "SELECT * FROM cart WHERE member_id = (SELECT member_id FROM members WHERE username = ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CartItem item = new CartItem();
                item.setCartItemId(rs.getInt("cart_item_id"));
                item.setMemberId(rs.getInt("member_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setName(rs.getString("name"));
                item.setImageUrl(rs.getString("image_url"));
                item.setPrice(rs.getInt("price"));
                item.setCount(rs.getInt("count"));
                list.add(item);
            }
        }

        return list;
    }

    public void clearCart(String username) throws Exception {
        String sql = "DELETE FROM cart WHERE member_id = (SELECT member_id FROM members WHERE username = ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.executeUpdate();
        }
    }
}
