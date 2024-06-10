<%@page import="himedia.dao.EmailDaoImple"%>
<%@page import="himedia.dao.EmailDao"%>
<%@page import="himedia.dao.EmailVo"%>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
// 데이터베이스 접속 정보 확인
ServletContext context = getServletContext();

String dbuser = context.getInitParameter("dbuser");
String dbpass = context.getInitParameter("dbpass");

String no = request.getParameter("no");
/* Long no = null;
no = Long.parseLong(noParameter); */
EmailVo vo = new EmailVo();
vo.setNo(no);
EmailDao dao = new EmailDaoImple(dbuser, dbpass);
boolean success = dao.delete(no);


/*
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";

 try {
	//	드라이버 로드
	Class.forName("oracle.jdbc.driver.OracleDriver");
	//  커넥션 얻기
	Connection conn = DriverManager.getConnection(dburl, dbuser, dbpass);
	//	실행 계획
	String sql = "DELETE FROM emaillist WHERE no = ?";
	//	PreparedStatment
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, no);
	
	int insertedCount = pstmt.executeUpdate();	//	영향 받은 레코드 카운트
	
	if (insertedCount == 1) {	//	INSERT 성공
		//	다른 페이지로 리다이렉트 : 3xx
		response.sendRedirect(request.getContextPath());
	} else { 
		*/
if (success){
	response.sendRedirect(request.getContextPath());
} else {
		%>
		<h1>Error</h1>
		<p>데이터 입력 중 오류가 발생했습니다</p>
		<%
}
/*
}
	//	자원 정리
	pstmt.close();
	conn.close();
	
} catch (Exception e){
	throw e;
} 
*/

%>