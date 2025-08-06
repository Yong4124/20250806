<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<style>
	ul {
	    list-style-type: none;
	    margin: 0;
	    padding: 0;
	    overflow: hidden;
	    background-color: rgb(53,94,169);
	}
	li {
	    float: left;
	}
	li a, .dropbtn {
	    display: inline-block;
	    color: white;
	    text-align: center;
	    padding: 14px 16px;
	    text-decoration: none;
	}
	li a:hover, .dropdown:hover .dropbtn {
	    background-color: #6799FF;
	}
	li.dropdown {
	    display: inline-block;
	}
	li a.active, a.active:hover {
	    background-color: #6799FF;
	}
	.dropdown-content {
	    display: none;
	    position: absolute;
	    background-color: #f9f9f9;
	    min-width: 160px;
	    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
	    z-index: 1;
	}
	.dropdown-content a {
	    color: black;
	    padding: 12px 16px;
	    text-decoration: none;
	    display: block;
	    text-align: left;
	}
	.dropdown-content a:hover {
	    background-color: #f1f1f1;
	}
	.dropdown:hover .dropdown-content {
	    display: block;
	}
</style>
</head>
<body>
<ul>
	<li><a href="#home">Home</a></li>
	<li><a href="signUp.jsp">회원가입</a></li>
	<li><a href="userList.jsp">회원목록</a></li>
	<li><a href="#blog">블로그</a></li>
	<li class="dropdown">
		<a href="#shopping" class="dropbtn">쇼핑</a>
		<div class="dropdown-content">
			<a href="#">가전제품</a>
			<a href="#">의류/악세사리</a>
			<a href="#">가방/신발</a>
		</div>
	</li>
	<li class="dropdown">
		<a href="#new" class="dropbtn">뉴스</a>
		<div class="dropdown-content">
			<a href="#">정치</a>
			<a href="#">경제</a>
			<a href="#">생활/문화</a>
		</div>
	</li>
	<li style="float:right"><a class="active" href="#login">로그인</a></li>
</ul>

<h2>회원 목록</h2>
<table border="1" cellpadding="5" cellspacing="0">
	<tr>
		<th>회원번호</th>
		<th>이름</th>
		<th>주소</th>
		<th>이메일</th>
		<th>전화번호</th>
		<th>삭제</th>
	</tr>

<%
	String jdbcURL = "jdbc:mysql://localhost:3305/user_db?useUnicode=true&characterEncoding=UTF-8";
	String dbUser = "root";
	String dbPassword = "1234";

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
		stmt = conn.createStatement();
		rs = stmt.executeQuery("SELECT id, username, address, email, cel FROM users");

		while (rs.next()) {
			String id = rs.getString("id");
%>
	<tr>
		<td><a href="updMemForm.jsp?id=<%= id %>"><%= id %></a></td>
		<td><%= rs.getString("username") %></td>
		<td><%= rs.getString("address") %></td>
		<td><%= rs.getString("email") %></td>
		<td><%= rs.getString("cel") %></td>
		<td>
			<a href="deleteUser.jsp?id=<%= id %>" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
		</td>
	</tr>
<%
		}
	} catch (Exception e) {
		e.printStackTrace();
%>
	<tr><td colspan="6">목록 조회 중 오류: <%= e.getMessage() %></td></tr>
<%
	} finally {
		try {
			if (rs != null) rs.close();
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
%>
</table>

<br>
<a href="index.jsp">← 메인으로 돌아가기</a>
</body>
</html>
