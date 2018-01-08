package customer.user.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class GetConnection {
	public Connection getConnection() throws ClassNotFoundException, SQLException {
		
		//<드라이버 로딩> Class.forName("package.ClassName"); 을 실행하는 경우 문자열로 전달되는 클래스를 메모리에 로드한다. jdbc Driver가 등록되는 과정이다.
		Class.forName("com.mysql.jdbc.Driver"); 
		Connection c;
		//<DB 연결> 로컬호스트 : 위치(자신의 컴퓨터가 아니면 다른 아이피가 뜸)
		c = DriverManager.getConnection("jdbc:mysql://localhost/springbook?characterEncoding=UTF-8", "spring", "book");
		return c;
	}
}
