package databaseAccessObjects;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import databaseEntities.User;

public class TestUsersDAO {
	
	UsersDAO dao;
	
	@Before
	public void setUp(){
		dao = new UsersDAO();
	}
	
	@Test
	public void test_AddingAUserToDatabaseWithUniqueEmailAndUsernameReturnsTrue(){
		User user = new User();
		user.setEmail("f@f");
		user.setUsername("test");
		assertTrue(dao.addUser(user));	
		dao.removeUser(user);
	}
	
	@Test
	public void test_RemoveUserCorrectlyRemovesUserFromDatabaseIfAlreadyExists(){
		User user = new User();
		user.setEmail("f@f");
		user.setUsername("test");
		dao.addUser(user);	
		dao.removeUser(user);
		User user2 = dao.getUserByUsername(user.getUsername());
		assertEquals(null,user2);
	}
	
	@Test
	public void test_RemoveUserWithNoneExistingUserCorrectlyDoesNothingAndReturnsFalse(){
		User user = new User();
		user.setUsername("im not in the database");
		assertFalse(dao.removeUser(user));
	}
	
	@Test
	public void test_GetUserByEmailReturnsNullWithNoneExistingUser(){
		User user = new User();
		user.setEmail("this email");
		user.setUsername("test");
		assertEquals(null,dao.getUserByEmail(user.getEmail()));
	}
	
	@Test
	public void test_GetUserByUsernameReturnsNullWithNoneExistingUser(){
		User user = new User();
		user.setEmail("this email");
		user.setUsername("test");
		assertEquals(null,dao.getUserByUsername(user.getUsername()));
	}
	
	@Test
	public void test_GetUserByUsernameReturnsTheUserPreviouslyAddedUser(){
		User user = new User();
		user.setUsername("user1");
		dao.addUser(user);
		User usert = dao.getUserByUsername(user.getUsername());
		dao.removeUser(user);
		assertEquals(user.getUserId(),usert.getUserId());
	}
	
	@Test
	public void test_GetUserByEmailReturnsThePreviouslyAddedUser(){
		User user = new User();
		user.setEmail("user1");
		user.setUsername("test");
		dao.addUser(user);
		User usert = dao.getUserByEmail(user.getEmail());
		dao.removeUser(user);
		assertEquals(user.getUserId(),usert.getUserId());
	}

}
