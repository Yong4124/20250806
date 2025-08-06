<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");  // 무조건 가장 위에 넣기
    response.setContentType("text/html; charset=UTF-8");

    String id = request.getParameter("id");
    String method = request.getMethod();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
</head>
<body>
<h2>회원 정보 수정</h2>

<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3305/user_db?useUnicode=true&characterEncoding=UTF-8", "root", "1234");

    if ("POST".equalsIgnoreCase(method)) {

        String username = request.getParameter("username");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String cel = request.getParameter("cel");

        String updateSql = "UPDATE users SET username = ?, address = ?, email = ?, cel = ? WHERE id = ?";
        pstmt = conn.prepareStatement(updateSql);
        pstmt.setString(1, username);
        pstmt.setString(2, address);
        pstmt.setString(3, email);
        pstmt.setString(4, cel);
        pstmt.setString(5, id);
        int rows = pstmt.executeUpdate();

        if (rows > 0) {
            response.sendRedirect("userList.jsp");
            return;
        } else {
            out.println("수정 실패: 해당 사용자가 존재하지 않습니다.<br>");
        }

    } else {
        String selectSql = "SELECT username, address, email, cel FROM users WHERE id = ?";
        pstmt = conn.prepareStatement(selectSql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
%>
<form method="post" action="updMemForm.jsp?id=<%= id %>" accept-charset="UTF-8">
    이름: <input type="text" name="username" value="<%= rs.getString("username") %>"><br>
    주소: <input type="text" name="address" value="<%= rs.getString("address") %>"><br>
    이메일: <input type="email" name="email" value="<%= rs.getString("email") %>"><br>
    전화번호: <input type="text" name="cel" value="<%= rs.getString("cel") %>"><br>
    <input type="submit" value="수정하기">
</form>
<%
        } else {
            out.println("해당 ID를 가진 사용자가 없습니다.");
        }
    }
} catch (SQLException e) {
    out.println("DB 오류: " + e.getMessage());
} catch (ClassNotFoundException e) {
    out.println("드라이버 오류: " + e.getMessage());
} finally {
    try {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    } catch (SQLException e) {
        out.println("리소스를 닫는 도중 오류 발생: " + e.getMessage());
    }
}
%>

<br><a href="userList.jsp">← 목록으로 돌아가기</a>
</body>
</html>
