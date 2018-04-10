package databaseAccessObjects;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import databaseEntities.OwnedShare;
import databaseEntities.Share;
import databaseEntities.Trade;
import databaseEntities.User;

public class OwnedSharesDAO {

	private static final String PERSISTENCE_UNIT_NAME = "persunit";
	private static EntityManagerFactory emf;

	public OwnedSharesDAO() {
		emf = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
	}

	public OwnedShare getOwnedShareByShareAndUser(Share share, User user) {
		EntityManager em = emf.createEntityManager();
		Query query = em.createQuery("select o from OwnedShare o where o.share = :shareid and o.user = :userid");
		query.setParameter("shareid", share);
		query.setParameter("userid", user);
		List<OwnedShare> ownedShares = query.getResultList();
		if (ownedShares.size() > 0) {
			return ownedShares.get(0);
		}

		return null;
	}

	public List<OwnedShare> getAllOwnedShares() {
		EntityManager em = emf.createEntityManager();
		Query query = em.createQuery("select o from OwnedShare o");
		List<OwnedShare> ownedShares = query.getResultList();
		return ownedShares;

	}

	public List<OwnedShare> getOwnedSharesForUser(User user) {
		EntityManager em = emf.createEntityManager();
		Query query = em.createQuery("select o from OwnedShare o where o.user = :userid");
		query.setParameter("userid", user);
		List<OwnedShare> ownedShares = query.getResultList();
		return ownedShares;
	}

	public boolean transferSharesBetweenUsers(User userseller, User userbuyer, Share share, double quantity,
			double pricePerShare) {
		
		if(quantity < 0){
			return false;
		}
		
		OwnedShare sellerOwned = getOwnedShareByShareAndUser(share, userseller);
		OwnedShare buyerOwned = getOwnedShareByShareAndUser(share, userbuyer);
		
		if (sellerOwned == null) {
			// Seller doesn't own that share
			return false;
		} else if (sellerOwned.getQuantity() < quantity) {
			// Seller doesn't own enough of that share
			return false;
		}

		EntityManager em = emf.createEntityManager();
		// If buyer already owns the share
		if (buyerOwned != null) {
			// Persist owned share to data base, remove quantity from buyer
			em.getTransaction().begin();
			OwnedShare searchedShare = em.find(OwnedShare.class, buyerOwned.getOwnedShareId());
			searchedShare.setQuantity(searchedShare.getQuantity() + quantity);
			searchedShare.setPricePerShare(pricePerShare);
			
			if (removeCreditFromBuyer(userbuyer,pricePerShare * quantity) &&  removeOwnedShareForUser(share, userseller, quantity)) {
				addCreditToSeller(userseller,pricePerShare * quantity);
				em.getTransaction().commit();
			} else {
				em.getTransaction().rollback();
			}
			manageTrade(userseller,userbuyer, share, quantity, pricePerShare);
			return true;
		}
		// Buyer doesn't have this share, create entity and persist
		OwnedShare ownedShare = new OwnedShare();
		ownedShare.setQuantity(quantity);
		ownedShare.setShare(share);
		ownedShare.setUser(userbuyer);
		ownedShare.setPricePerShare(pricePerShare);
		em.getTransaction().begin();
		em.merge(ownedShare);

		// Was trade successful
		if (removeCreditFromBuyer(userbuyer,pricePerShare * quantity) && removeOwnedShareForUser(share, userseller, quantity)) {	
			manageTrade(userseller,userbuyer, share, quantity,pricePerShare);	
			addCreditToSeller(userseller,pricePerShare * quantity);
			em.getTransaction().commit();
			return true;
		} else {
			em.getTransaction().rollback();
			return false;
		}
	}

	private boolean removeCreditFromBuyer(User userbuyer, double amount) {
		UsersDAO uDAO = new UsersDAO();
		User u = uDAO.removeCreditForUser(userbuyer, amount);
		return
	}

	private void addCreditToSeller(User userseller, double amount) {
		UsersDAO uDAO = new UsersDAO();
		uDAO.addCreditForUser(userseller, amount);
	}

	private void manageTrade(User userseller, User userbuyer, Share share, double quantity, double pricePerShare) {
		Trade trade = new Trade();
		trade.setQuantity(quantity);
		trade.setShare(share);
		trade.setTransactionTime(new Timestamp(System.currentTimeMillis()));
		trade.setBuyer(userbuyer);
		trade.setSeller(userseller);
		trade.setPriceTotal(quantity * pricePerShare);
		TradesDAO tradeDAO = new TradesDAO();
		tradeDAO.addTrade(trade);
	}


	private boolean removeOwnedShareForUser(Share share, User user, double quantity) {
		OwnedShare ownedShare = getOwnedShareByShareAndUser(share, user);
		if (ownedShare == null || ownedShare.getQuantity() < quantity) {
			// User doesn't own that share, or enough of that share;
			return false;
		}
		// User can sell that share, amend quantity in table
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();
		OwnedShare searchedShare = em.find(OwnedShare.class, ownedShare.getOwnedShareId());
		if (searchedShare.getQuantity() - quantity == 0) {// If remove sets
															// owned to 0
			OwnedShare toBeRemoved = em.merge(searchedShare);
			em.remove(toBeRemoved);
		} else {
			searchedShare.setQuantity(searchedShare.getQuantity() - quantity);
		}
		em.getTransaction().commit();
		return true;
	}

	public boolean addOwnedShare(OwnedShare ownedShare) {
		EntityManager em = emf.createEntityManager();

		for (OwnedShare os : getAllOwnedShares()) {
			if (os.getOwnedShareId() == ownedShare.getOwnedShareId()) {
				return false;
			}
		}
		
		em.getTransaction().begin();
		em.persist(ownedShare);
		em.getTransaction().commit();
		em.close();
		return true;
	}
	
	public Share getSharebyShareid(long shareid){
		EntityManager em = emf.createEntityManager();
		Share share = em.find(Share.class, shareid);
			
		return share;
	}
	
	public List<Share> getAllShares(){
		EntityManager em = emf.createEntityManager();
		Query query = em.createQuery("select s from Share s");
		List<Share> shares = query.getResultList(); 
		return shares;
	}

}
