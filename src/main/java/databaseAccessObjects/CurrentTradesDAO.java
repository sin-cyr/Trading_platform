package databaseAccessObjects;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import databaseEntities.Company;
import databaseEntities.CurrentTrade;
import databaseEntities.OwnedShare;
import databaseEntities.Share;
import databaseEntities.SharesPrices;

public class CurrentTradesDAO {

	private static final String PERSISTENCE_UNIT_NAME = "persunit";
	private static EntityManagerFactory emf;
	EntityManager em;

	public CurrentTradesDAO() {
		emf = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
		em = emf.createEntityManager();
	}
	// Add the share details adds buy,sell price, time posted etc..
	public boolean addShareDetails(CurrentTrade current) {
		em.getTransaction().begin();
		em.merge(current);
		em.getTransaction().commit();
		em.close();
		return true;
	}

	// show the current trades details based on a share
	public List showCurrentTradesByShare(Share share) {
		em.getTransaction().begin();
		Query query = em.createQuery("select ct from CurrentTrade ct where ct.share = :share");
		query.setParameter("share", share);
		List<CurrentTrade> trade = query.getResultList();
		em.getTransaction().commit();
		return trade;
	}
	
	
	public void setAmountToZero(long tradeID){
		em.getTransaction().begin();
		CurrentTrade ctrade = em.find(CurrentTrade.class, tradeID);
		ctrade.setAmountBuying(0);
		ctrade.setAmountSelling(0);
		em.persist(ctrade);
		em.getTransaction().commit();
		em.close();
	}
	
	
	//show all current trades for all companies
	public List showAllCurrentTrades(){
		Query query= em.createQuery("select ct from CurrentTrade ct");
		List<CurrentTrade> allTrades = query.getResultList();
		return allTrades;
	}
	
	public CurrentTrade getCurrentTradebyid(long id){
		EntityManager em = emf.createEntityManager();
		CurrentTrade trade = em.find(CurrentTrade.class, id);
		return trade;
	}
	
	public List getCurrentTradesByShare(Share share){
		Query query= em.createQuery("select ct from CurrentTrade ct where ct.share= :share");
		query.setParameter("share", share);
		List<CurrentTrade> current = query.getResultList();
		return current;	
	}
	
	
	// show the sell prices based on a share
	public List showSellPricesByShare(Share share) {
		Query query = em.createQuery("select ct from CurrentTrade ct where ct.share = :share");
		query.setParameter("share", share);
		List<CurrentTrade> sellPrices = query.getResultList();
		return sellPrices;
	}	

}


