<%@page import="himedia.dao.EmailVo"%>
<%@page import="java.util.List"%>
<%@page import="himedia.dao.EmailDaoImple"%>
<%@page import="himedia.dao.EmailDao"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// DB 접속 정보를 컨텍스트 파라미터로부터 받아오기
ServletContext context = getServletContext();
String dbuser = context.getInitParameter("dbuser");
String dbpass = context.getInitParameter("dbpass");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일링 리스트:메인</title>
</head>
<body>
	<h1>메일링 리스트</h1>
	<h3>Model 1 방식</h3>
	<%
	/* 	String dburl = "jdbc:oracle:thin:@localhost:1521:xe";

		try {
			//	드라이버 로드
			Class.forName("oracle.jdbc.driver.OracleDriver");
			//	데이터베이스 연결
			Connection conn = DriverManager.getConnection(dburl, dbuser, dbpass);
			//	Statement 생성
			Statement stmt = conn.createStatement();
			//	SQL 실행
			String sql = "SELECT * FROM emaillist ORDER BY created_at DESC";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) { */
	EmailDao dao = new EmailDaoImple(dbuser, dbpass);
	List<EmailVo> list = dao.getList();

	for (EmailVo vo : list) {
	%>
	<!-- 리스트 -->
	<!-- vo 객체의 getter를 이용, 리스트를 표시 -->
	<table border="1" cellpadding="5" cellspacing="2">
		<tr>
			<th>성</th>
			<td>
				<%--=rs.getString("last_name")--%><%=vo.getLastName()%></td>
		</tr>
		<tr>
			<th>이름</th>
			<td><%--=rs.getString("first_name")--%><%=vo.getFirstName() %></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><%--=rs.getString("email")--%><%=vo.getEmail() %></td>
		</tr>
		<%-- <tr>
			<form action="<%=request.getContextPath()%>/delete.jsp"
				method="POST">
			<td name="no" value="<%=rs.getString("no")%>">
			<%=rs.getString("no")%></td>
			<th><button>삭제</button></th>
			</form>
		</tr> --%>
		<tr>
			<td colspan="2" align="right">
				<form action="<%=request.getContextPath()%>/delete.jsp"
					method="POST" onsubmit="return confirm('정말로 삭제하시겠습니까?');">
					<input type="hidden" name="no" value="<%=vo.getNo()%>">
					<input type="submit" value="Delete">
				</form>
			</td>
		</tr>
	</table>
	<br />
	<!-- /End -->
	<%
	}
	/* }

	rs.close();
	stmt.close();
	conn.close();
	} catch (ClassNotFoundException e) {
	throw new ClassNotFoundException("드라이버를 찾을 수 없습니다.");
	} catch (Exception e) {
	throw e;
	} */
	%>
	<p>
		<!-- ContextPath를 받아와서 form.jsp에 링크 -->
		<a href="<%=request.getContextPath()%>/form.jsp">추가 이메일 등록</a>
	</p>

</body>
</html>