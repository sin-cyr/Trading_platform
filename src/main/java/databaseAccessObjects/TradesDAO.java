package databaseAccessObjects;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import databaseEntities.Company;
import databaseEntities.Share;
import databaseEntities.Trade;
import databaseEntities.User;

public class TradesDAO {
	
	private static final String PERSISTENCE_UNIT_NAME = "persunit";
	private static EntityManagerFactory emf;
	EntityManager em;

	public TradesDAO() {
		emf = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
	}	
	
	public List<Trade> getTradesByUser(User user){
		EntityManager em = emf.createEntityManager();
		Query query = em.createQuery("select t from Trade t where t.user_id = :userid");
		query.setParameter("userid", user.getUserId());
		List<Trade> trades = query.getResultList();
		return trades;
	}
	
	public List<Trade> getTradesByShare(Share share){
		EntityManager em = emf.createEntityManager();
		Query query = em.createQuery("select t from Trade t where t.share_shareid = :shareid");
		query.setParameter("shareid", share.getShareId());
		List<Trade> trades = query.getResultList();

		return trades;
	}
	
	
	public List<Trade> getAllTrades(){
		EntityManager em = emf.createEntityManager();
		Query query = em.createQuery("select t from Trade t");
		List<Trade> trades = query.getResultList();
		return trades;
	}
	
	public boolean addTrade(Trade trade){
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();
		em.merge(trade);
		em.getTransaction().commit();
		return true;
	}
	
	public boolean removeTrade(long tradeid){
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();
		Trade searchTrade = em.find(Trade.class, tradeid);
		em.remove(searchTrade);
		em.getTransaction().commit();
		return true;
	}
	

}
