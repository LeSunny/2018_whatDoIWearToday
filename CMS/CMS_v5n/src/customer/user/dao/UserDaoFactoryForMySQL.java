package customer.user.dao;

public class UserDaoFactoryForMySQL {
	public UserDao userDao() {
		UserDao dao = new UserDao(connectionMaker());
		return dao;
	}

	public ConnectionMaker connectionMaker() {
		ConnectionMaker connectionMaker = new MySQLConnectionMakerForK();
		return connectionMaker;
	}
}
