package customer.user.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Date;
import java.util.LinkedList;

public class MySQLConnectionMakerForK extends LinkedList<Date> {
	
	LinkedList<String> llDate = new LinkedList<String>();
	
	public Connection getConnection() throws ClassNotFoundException,
			SQLException {
		Class.forName("com.mysql.jdbc.Driver");
		Connection c = DriverManager.getConnection(
				"jdbc:mysql://localhost/springbook?characterEncoding=UTF-8", "spring", "book");

	    Date d = new Date();	        
	    String s = d.toString();
	    add(d);
	    llDate.add(s);
		
		return c;
	}
	
}
