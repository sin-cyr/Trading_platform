package databaseAccessObjects;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import databaseEntities.Company;
import databaseEntities.Share;
import databaseEntities.SharesPrices;

public class SharesPriceDAO {

	// sinan testing
	private static final String PERSISTENCE_UNIT_NAME = "persunit";
	private static EntityManagerFactory emf;
	EntityManager em;

	public SharesPriceDAO() {
		emf = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
		em = emf.createEntityManager();

	}

	
	
	
	public SharesPrices addPrice(Share share,SharesPrices sgp ){
		em = emf.createEntityManager();
		sgp.setShare(share);
		em.getTransaction().begin();
		em.merge(sgp);
		em.getTransaction().commit();
		em.close();
		return sgp;
	}
	
	// Show price of shares
	public Double showPrice(Share share) {
		em = emf.createEntityManager();
		Query query = em.createQuery("select s from SharesPrices s where s.share= :share");
		query.setParameter("share", share);
		List<SharesPrices> sp = query.getResultList();
		em.close();
		
		return sp.get(sp.size()-1).getPrice();
	}
	
	//Get All Sharesprices
	public List getAllSharesPrices(){
		em = emf.createEntityManager();
		Query query = em.createQuery("select s from SharesPrices s");
		List<SharesPrices> sharespriceslist = query.getResultList();
		em.close();
		return sharespriceslist;
	}
	
	public SharesPrices getSharePriceByShare(Share share){
		em = emf.createEntityManager();
		Query query = em.createQuery("select s from SharesPrices s where s.share= :share");
		query.setParameter("share", share);
		List<SharesPrices> sp = query.getResultList();
		em.close();
		
		return sp.get(sp.size()-1);
	}
	
	
}
