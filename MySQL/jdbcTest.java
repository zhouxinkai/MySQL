/*
 *	jdbcTest.java  2015-7-8
 *  author: zhouxinkai
 *  Copyright 2015 zhouxinkai, All rights reserved.
 */
import java.sql.*;

public class jdbcTest {

	public static void main(String[] args) {
		ResultSet rs = null;
		Statement stmt = null;
		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			//new oracle.jdbc.driver.OracleDriver();
			conn = DriverManager.getConnection("jdbc:mysql://localhost/mydata?user=root&password=683004");
			//最重要的一行代码
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from dept");
			while(rs.next()) {
				System.out.println(rs.getString("deptno"));
				System.out.println(rs.getInt("deptno"));
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) {
					rs.close();
					rs = null;
				}
				if(stmt != null) {
					stmt.close();
					stmt = null;
				}
				if(conn != null) {
					conn.close();
					conn = null;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}

