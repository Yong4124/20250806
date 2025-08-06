<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    String username = request.getParameter("username");
    String address = request.getParameter("address");
    String email = request.getParameter("email");
    String cel = request.getParameter("cel");

    if (username == null || username.trim().isEmpty() ||
        address == null || address.trim().isEmpty() ||
        email == null || email.trim().isEmpty() ||
        cel == null || cel.trim().isEmpty()) {
        out.println("<h3 style='color:red;'>모든 입력 필드를 채워주세요.</h3>");
        out.println("<a href='signUp.jsp'>회원가입 페이지로 돌아가기</a>");
        return;
    }

    String jdbcURL = "jdbc:mysql://localhost:3305/user_db?useUnicode=true&characterEncoding=UTF-8";
    String dbUser = "root";
    String dbPassword = "1234";

    Connection conn = null;
    PreparedStatement stmt = null;
    PreparedStatement checkStmt = null;
    ResultSet checkRs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // 중복 전화번호 체크
        String checkSql = "SELECT COUNT(*) FROM users WHERE cel = ?";
        checkStmt = conn.prepareStatement(checkSql);
        checkStmt.setString(1, cel);
        checkRs = checkStmt.executeQuery();

        boolean isDuplicate = false;
        if (checkRs.next() && checkRs.getInt(1) > 0) {
            isDuplicate = true;
        }

        if (isDuplicate) {
            out.println("<h3 style='color:red;'>이미 등록된 전화번호입니다. 다른 번호를 입력하세요.</h3>");
        } else {
            // 회원 등록
            String sql = "INSERT INTO users (username, address, email, cel) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, address);
            stmt.setString(3, email);
            stmt.setString(4, cel);

            int result = stmt.executeUpdate();

            if (result > 0) {
                out.println("<h3>회원 가입이 완료되었습니다!</h3>");
            } else {
                out.println("<h3>회원 가입에 실패했습니다.</h3>");
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h3>오류 발생: " + e.getMessage() + "</h3>");
    } finally {
        try {
            if (checkRs != null) checkRs.close();
            if (checkStmt != null) checkStmt.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
response.sendRedirect("index.jsp");
%>

<br><hr>
<a href="signUp.jsp">회원가입 페이지로 돌아가기</a><br>
<a href="index.jsp">← 메인으로 돌아가기</a><br>
<a href="userList.jsp">회원 목록 보기</a>
</body>
</html>
