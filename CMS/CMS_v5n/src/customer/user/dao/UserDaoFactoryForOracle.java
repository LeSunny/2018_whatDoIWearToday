package customer.user.dao;

public class UserDaoFactoryForOracle {
	public UserDao userDao() {
		UserDao dao = new UserDao(connectionMaker());
		return dao;
	}

	public ConnectionMaker connectionMaker() {
		ConnectionMaker connectionMaker = new OracleConnectionMakerForL();
		return connectionMaker;
	}
}
