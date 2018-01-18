package customer.user.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Date;
import java.util.Vector;

public class OracleConnectionMakerForL extends Vector<Date> {
	
	Vector<String> llDate = new Vector<String>();
	
	public Connection getConnection() throws ClassNotFoundException,
			SQLException {
		Class.forName("com.oracle.jdbc.Driver");
		Connection c = DriverManager.getConnection(
				"jdbc:oracle://localhost/springbook?characterEncoding=UTF-8", "spring", "book");

	    Date d = new Date();	        
	    String s = d.toString();
	    add(d);
	    llDate.add(s);
		
		return c;
	}
	
}
