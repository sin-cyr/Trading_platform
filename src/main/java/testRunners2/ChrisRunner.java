package testRunners2;

import databaseAccessObjects.UsersDAO;
import databaseEntities.User;

public class ChrisRunner {

	public static void main(String[] args) {

		UsersDAO dao = new UsersDAO();
		User user = dao.getUserByUsername("Jesse");
		System.out.println(user.getPassword());
//		dao.updatePasswordForUser(user, "meme");
//		System.out.println(user.getPassword());
		
	}

}
