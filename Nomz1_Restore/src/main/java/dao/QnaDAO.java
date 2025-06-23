package dao;

import model.Question;
import model.Answer;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QnaDAO {
    private static final String URL = "jdbc:mariadb://localhost:3307/kimdb";
    private static final String USER = "kim";
    private static final String PWD = "1111";

    private Connection getConnection() throws Exception {
        Class.forName("org.mariadb.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PWD);
    }

    // ✅ 질문 전체 조회 (답변 포함)
    public List<Question> getAllQuestionsWithAnswers() {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT * FROM questions ORDER BY created_at DESC";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Question q = new Question();
                q.setQuestionId(rs.getInt("question_id"));
                q.setMemberId(rs.getInt("member_id"));
                q.setContent(rs.getString("content"));
                q.setCreatedAt(rs.getTimestamp("created_at"));

                // ✅ 답변까지 함께 셋팅
                q.setAnswers(getAnswersByQuestionId(q.getQuestionId(), conn));
                questions.add(q);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return questions;
    }

    // ✅ 특정 질문의 답변 조회 (Connection 재사용 가능)
    private List<Answer> getAnswersByQuestionId(int questionId, Connection conn) {
        List<Answer> answers = new ArrayList<>();
        String sql = "SELECT * FROM answers WHERE question_id = ? ORDER BY created_at";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, questionId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Answer a = new Answer();
                    a.setAnswerId(rs.getInt("answer_id"));
                    a.setQuestionId(rs.getInt("question_id"));
                    a.setContent(rs.getString("content"));
                    a.setCreatedAt(rs.getTimestamp("created_at"));
                    answers.add(a);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return answers;
    }

    // ✅ 질문 등록
    public void insertQuestion(Question question) {
        String sql = "INSERT INTO questions (member_id, content) VALUES (?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, question.getMemberId());
            pstmt.setString(2, question.getContent());
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ 답변 등록
    public void insertAnswer(Answer answer) {
        String sql = "INSERT INTO answers (question_id, content) VALUES (?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, answer.getQuestionId());
            pstmt.setString(2, answer.getContent());
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ 질문 삭제 (답변 먼저 삭제)
    public void deleteQuestion(int questionId) {
        String deleteAnswers = "DELETE FROM answers WHERE question_id = ?";
        String deleteQuestion = "DELETE FROM questions WHERE question_id = ?";

        try (Connection conn = getConnection()) {
            try (PreparedStatement pstmt1 = conn.prepareStatement(deleteAnswers)) {
                pstmt1.setInt(1, questionId);
                pstmt1.executeUpdate();
            }

            try (PreparedStatement pstmt2 = conn.prepareStatement(deleteQuestion)) {
                pstmt2.setInt(1, questionId);
                pstmt2.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ 답변 삭제
    public void deleteAnswer(int answerId) {
        String sql = "DELETE FROM answers WHERE answer_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, answerId);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
