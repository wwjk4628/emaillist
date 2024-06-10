package himedia.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class EmailDaoImple implements EmailDao {
	private String dbuser;
	private String dbpass;

	// 생성자
	public EmailDaoImple(String dbuser, String dbpass) {
		this.dbuser = dbuser;
		this.dbpass = dbpass;
	}
	// 데이터베이스 접속 정보 -> 컨텍스트 파라미터로부터 받아옴
	// Connection 공통 메서드
	private Connection getConnection() throws SQLException {

		Connection conn = null;

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String dburl = "jdbc:oracle:thin:@localhost:1521:xe";

			conn = DriverManager.getConnection(dburl, dbuser, dbpass);

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
//			System.err.println("JDBC 드라이버를 로드하지 못했습니다.");
		}
		
		return conn;
	}

	@Override
	public List<EmailVo> getList() {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		List<EmailVo> list = new ArrayList<EmailVo>();
		
		try {
			//	connection
			conn = getConnection();
			//	statment 생성
			stmt = conn.createStatement();
			//	쿼리 전송
			String sql = "SELECT * FROM emaillist"; 
			//	결과 셋
			rs = stmt.executeQuery(sql);
			//	결과 셋 -> 자바 객체로 전환
			while (rs.next()) {
				//	Java 객체로 전환
				String no = rs.getString("no");
				String lastName = rs.getString("last_name");
				String firstName = rs.getString("last_name");
				String email = rs.getString("email");
				Date createdAt = rs.getDate("created_at");
				
				EmailVo vo = new EmailVo(no, lastName, firstName, email, createdAt);
				list.add(vo);
			}
			
		} catch(SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}

	@Override
	public boolean insert(EmailVo vo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int insertCount = 0;
		
		try {
			conn = getConnection();
			String sql = "INSERT INTO emaillist (no, last_name, first_name, email) VALUES (seq_emaillist_pk.nextval, ?, ?, ?)";
			//	PreparedStatment
			pstmt = conn.prepareStatement(sql);
			//	데이터 바인딩
			pstmt.setString(1, vo.getLastName());
			pstmt.setString(2, vo.getFirstName());
			pstmt.setString(3, vo.getEmail());
			insertCount = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		return insertCount == 1;
	}

	@Override
	public boolean delete(String no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int deleteCount = 0;
		
		try {
			conn = getConnection();
			String sql = "DELETE FROM emaillist WHERE no = ?";
			//	PreparedStatment
			pstmt = conn.prepareStatement(sql);
			//	데이터 바인딩
			pstmt.setString(1, no);
			deleteCount = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return deleteCount == 1;
	}

}
