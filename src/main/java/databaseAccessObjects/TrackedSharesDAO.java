package databaseAccessObjects;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import databaseEntities.SharesPrices;
import databaseEntities.TrackedShare;
import databaseEntities.User;

public class TrackedSharesDAO {
	
	private static final String PERSISTENCE_UNIT_NAME = "persunit";
	private static EntityManagerFactory emf;

	public TrackedSharesDAO() {
		emf = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
	}
	
	
	public boolean addTrackedSharesForUser(User user,SharesPrices sharePrice){
		TrackedShare tShare = new TrackedShare();
		tShare.setUser(user);
		tShare.setSharePrice(sharePrice);
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();
		em.merge(tShare);
		em.getTransaction().commit();
		return true;
	}
	
	public boolean removeTrackedShareForUser(TrackedShare tShare){
		EntityManager em = emf.createEntityManager();
		em.getTransaction().begin();
		TrackedShare searched = em.find(TrackedShare.class, tShare.getTrackedId());
		TrackedShare toBeRemoved = em.merge(searched);
		em.remove(toBeRemoved);
		em.getTransaction().commit();
		return true;
	}
	
	public List<TrackedShare> getAllTrackedShareByUser(User user){
		EntityManager em = emf.createEntityManager();	
		Query query = em.createQuery("select t from TrackedShare t where t.user = :user");
		query.setParameter("user",user);
		List<TrackedShare> tShares = query.getResultList();
		return tShares;
	}

	public void removeTrackedShareBySharePrice(SharesPrices sp){
		EntityManager em = emf.createEntityManager();
		Query query = em.createQuery("select t from TrackedShare t where t.sharePrice = :sp");
		query.setParameter("sp", sp);
		List<TrackedShare> ts = query.getResultList();
		removeTrackedShareForUser(ts.get(0));
	}
	

}
