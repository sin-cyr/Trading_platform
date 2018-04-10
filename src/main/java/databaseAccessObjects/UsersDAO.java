package databaseAccessObjects;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import databaseEntities.User;

public class UsersDAO {

	private static final String PERSISTENCE_UNIT_NAME = "persunit";
	private static EntityManagerFactory emf;

	public UsersDAO() {
		emf = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
	}
	
	public List<User> getAllUsers(){
		EntityManager em = emf.createEntityManager();
		Query query = em.createQuery("select u from User u");
		List<User> users = query.getResultList();
		return users;
	}
	
	public List<User> getUserByUserId(long uInfo){
	EntityManager em = emf.createEntityManager();
	em.getTransaction().begin();
	String string = "select u from User u where u.userId = :userId";
	Query query = em.createQuery(string);
	query.setParameter("userId", uInfo);
	List<User> user = query.getResultList();
	em.close();
	return user;
	}

	public User getUserByUsername(String username) {
		EntityManager em = emf.createEntityManager();
		String string = "select u from User u where u.username = :username";
		Query query = em.createQuery(string);
		query.setParameter("username", username);
		List<User> users = query.getResultList();

		if (users.size() > 0) {
			// User successfully retrieved
			return users.get(0);
		}
		// No user match found
		return null;
	}

	public User getUserByEmail(String email) {
		EntityManager em = emf.createEntityManager();
		String string = "select u from User u where u.email = :email";
		Query query = em.createQuery(string);
		query.setParameter("email", email);
		List<User> users = query.getResultList();

		if (users.size() > 0) {
			// User successfully retrieved
			return users.get(0);
		}
		// No user match found
		return null;
	}

	public boolean updateUser(User user) {
		EntityManager em = emf.createEntityManager();
		User getUser = getUserByUsername(user.getUsername());
		if (getUser != null) {
			em.getTransaction().begin();
			User searchUser = em.find(User.class, getUser.getUserId());
			searchUser.setCurrentTrades(user.getCurrentTrades());
			searchUser.setEmail(user.getEmail());
			searchUser.setOwnedShares(user.getOwnedShares());
			searchUser.setTrackedShares(user.getTrackedShares());
			searchUser.setPassword(user.getPassword());
			searchUser.setBoughtTrades(user.getBoughtTrades());
			searchUser.setSoldTrades(user.getSoldTrades());
			searchUser.setCredit(user.getCredit());
			searchUser.setImageFile(user.getImageFile());
			em.merge(searchUser);
			em.getTransaction().commit();
			// User found and updated on the database
			return true;
		}
		// User not found on database;
		return false;
	}

	public boolean addUser(User user) {
		EntityManager em = emf.createEntityManager();
		if (getUserByUsername(user.getUsername()) == null && getUserByEmail(user.getEmail()) == null) {
			em.getTransaction().begin();
			em.persist(user);
			em.getTransaction().commit();
			em.close();
			// Logging user added sucessfully
			return true;
		}
		// Logging user exists;
		return false;
	}

	public boolean removeUser(User user) {
		EntityManager em = emf.createEntityManager();
		User getUser = getUserByUsername(user.getUsername());
		if (getUser == null) {
			return false;
		}

		em.getTransaction().begin();
		User searchedUser = em.find(User.class, getUser.getUserId());
		em.remove(searchedUser);
		em.getTransaction().commit();
		em.close();
		return true;
	}

	public boolean removeCreditForUser(User user, double amount) {
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();
		User getUser = getUserByUsername(user.getUsername());

		if (getUser.getCredit() - amount < 0) {
			em.close();
			return false;
		}

		getUser.setCredit(getUser.getCredit() - amount);
		em.merge(getUser);
		em.getTransaction().commit();
		return true;
	}

	public void addCreditForUser(User user, double amount) {
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();
		User getUser = getUserByUsername(user.getUsername());
		getUser.setCredit(getUser.getCredit() + amount);
		em.merge(getUser);
		em.getTransaction().commit();
	}
	
	public void updatePasswordForUser(User user, String newPass){
		EntityManager em = emf.createEntityManager();
		if (getUserByUsername(user.getUsername()) != null){
		User getUser = getUserByUsername(user.getUsername());
		String oldPass = getUser.getPassword();
		em.getTransaction().begin();
		getUser.setPassword(newPass);
		em.merge(getUser);
		em.getTransaction().commit();
	
		} else {
			System.out.println("user not found");
		}
	}

	public void changeBanStateByUsername(String username) {
		EntityManager em = emf.createEntityManager();
		User getUser = getUserByUsername(username);
		em.getTransaction().begin();
		if(getUser.getBanned() == 0){
			getUser.setBanned(1);
		}else{
			getUser.setBanned(0);
		}
		em.merge(getUser);
		em.getTransaction().commit();
	}
	
	public void changeAdminStatusByUsername(String username){
		EntityManager em = emf.createEntityManager();
		User getUser = getUserByUsername(username);
		em.getTransaction().begin();
		if(getUser.getAdminBoolean() == 0){
			getUser.setAdminBoolean(1);
		}else{
			getUser.setAdminBoolean(0);
		}
		em.merge(getUser);
		em.getTransaction().commit();
	}
	
}
