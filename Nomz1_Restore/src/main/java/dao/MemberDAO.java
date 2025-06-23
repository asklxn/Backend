package dao;

import java.sql.*;
import model.Member;

public class MemberDAO {

    private static final String URL = "jdbc:mariadb://localhost:3307/kimdb";
    private static final String USER = "kim";
    private static final String PWD = "1111";

    // 로그인 확인
    public Member login(String id, String pwd) {
        Member member = null;

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USER, PWD);

            String sql = "SELECT * FROM members WHERE username = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ps.setString(2, pwd);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                member = new Member();
                member.setUsername(id);
                member.setPassword(pwd);
                member.setName(rs.getString("name"));
                member.setPhone(rs.getString("phone"));
                member.setBirth(rs.getDate("birth"));
                member.setAddress(rs.getString("address"));
                member.setDetailAddress(rs.getString("detail_address"));
                member.setMemberId(rs.getInt("member_id"));
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return member;
    }

    // 회원 가입
    public boolean insertMember(Member m) {
        String sql = "INSERT INTO members (name, username, password, phone, birth, address, detail_address) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USER, PWD);
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, m.getName());
            ps.setString(2, m.getUsername());
            ps.setString(3, m.getPassword());
            ps.setString(4, m.getPhone());
            ps.setDate(5, m.getBirth());
            ps.setString(6, m.getAddress());
            ps.setString(7, m.getDetailAddress());

            int rows = ps.executeUpdate();

            ps.close();
            conn.close();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ 마이페이지용 회원 정보 조회
    public Member getMemberById(String id) {
        Member member = null;

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USER, PWD);

            String sql = "SELECT * FROM members WHERE username = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                member = new Member();
                member.setUsername(rs.getString("username"));
                member.setPassword(rs.getString("password")); // 생략해도 됨
                member.setName(rs.getString("name"));
                member.setPhone(rs.getString("phone"));
                member.setBirth(rs.getDate("birth"));
                member.setAddress(rs.getString("address"));
                member.setDetailAddress(rs.getString("detail_address"));
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return member;
    }
}
