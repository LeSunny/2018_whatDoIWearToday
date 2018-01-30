package customer.user.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class OracleConnectionMaker extends SimpleConnectionMaker {
	public Connection getConnection() throws ClassNotFoundException,
			SQLException {
		Class.forName("com.oracle.jdbc.Driver");
		Connection c = DriverManager.getConnection(
				"jdbc:oracle://localhost/springbook?characterEncoding=UTF-8", "spring", "book");
		return c;
	}
}
