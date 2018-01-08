package customer.user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import customer.user.domain.User;

public class UserDao { //테이블 하나 당 클래스 하나. user 테이블 담당.
	
	public void add(User user) throws ClassNotFoundException, SQLException {
		//ClassNotFoundException : 클래스가 정의되어 있지 않거나 잘못 참조되어 찾을 수 없을 때 호출된다
		//SQLException : SQL Server에서 경고 또는 오류를 반환할 때 throw되는 예외
		
		GetConnection G = new GetConnection();
		Connection c = G.getConnection(); 
		
		/* 데이타 설정하는 과정 */
		PreparedStatement ps = c.prepareStatement("insert into users(id, name, password) values(?,?,?)");
		//PreparedStatement : DB에 쿼리 보내기 위한 필요 객체 statement에서 반복적인 수행을 더 쉽게 할 수 있다.
		ps.setString(1, user.getId());
		ps.setString(2, user.getName());
		ps.setString(3, user.getPassword());

		ps.executeUpdate(); //삽입, 수정, 삭제와 관련된 SQL문을 실행할 때 사용.

		ps.close();
		c.close();
		// close()를 제대로 안 할 경우, 서버가 다운될 확률이 올라간다. 메모리가 소모되기 때문
	}


	public User get(String id) throws ClassNotFoundException, SQLException {
		GetConnection G = new GetConnection();
		Connection c = G.getConnection(); 
		
		PreparedStatement ps = c
				.prepareStatement("select * from users where id = ?");
		ps.setString(1, id);

		ResultSet rs = ps.executeQuery();
		rs.next();
		User user = new User();
		user.setId(rs.getString("id"));
		user.setName(rs.getString("name"));
		user.setPassword(rs.getString("password"));

		rs.close();
		ps.close();
		c.close();

		return user;
	}

}
