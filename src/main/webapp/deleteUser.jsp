<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");

    if (id == null || id.trim().equals("")) {
        out.println("삭제할 회원 ID가 없습니다.");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3305/user_db?useUnicode=true&characterEncoding=UTF-8", "root", "1234");

        String deleteSql = "DELETE FROM users WHERE id = ?";
        pstmt = conn.prepareStatement(deleteSql);
        pstmt.setString(1, id);
        int result = pstmt.executeUpdate();

        if (result > 0) {
            response.sendRedirect("userList.jsp");  // 삭제 성공하면 목록으로 돌아가기
        } else {
            out.println("삭제 실패: 해당 회원이 존재하지 않습니다.");
        }
    } catch (Exception e) {
        out.println("DB 오류: " + e.getMessage());
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("리소스 닫기 오류: " + e.getMessage());
        }
    }
%>
