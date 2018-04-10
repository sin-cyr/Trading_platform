package databaseAccessObjects;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.List;

import org.junit.Before;
import org.junit.Test;

import databaseEntities.OwnedShare;
import databaseEntities.Share;
import databaseEntities.User;

public class TestOwnedSharesDAO {
	
	OwnedSharesDAO dao;
	
	@Before
	public void setUp(){
		 dao = new OwnedSharesDAO();
	}
	
	@Test
	public void test_AddShareReturnsTrueForNoneExistingOwnedShare(){
		OwnedShare ownedShare = new OwnedShare();
		ownedShare.setOwnedShareId(1L);
		ownedShare.setQuantity(10);
		assertTrue(dao.addOwnedShare(ownedShare));
	}
	
	@Test
	public void test_AddShareReturnsFalseForExistingOwnedShare(){
		OwnedShare ownedShare = new OwnedShare();
		ownedShare.setOwnedShareId(1L);
		ownedShare.setQuantity(10);
		assertFalse(dao.addOwnedShare(ownedShare));
	}
	
	@Test
	public void test_GetAllSharesReturnsListThatIncreasesInSizeByOneWhenOwnedShareIsAdded(){
		OwnedShare ownedShare = new OwnedShare();
		ownedShare.setOwnedShareId(2L);
		ownedShare.setQuantity(10);
		int before = dao.getAllOwnedShares().size();
		dao.addOwnedShare(ownedShare);
		int after = dao.getAllOwnedShares().size();
		assertEquals(before + 1, after);
	}
	
	@Test 
	public void test_TransferSharesBetweenUsersCorrectlyRemovesQuantityFromSellerAndAddsToBuyer(){
		//Create new ownedShare and add to the database
		OwnedShare ownedShare = new OwnedShare();
		ownedShare.setOwnedShareId(3L);
		Share share = new Share();
		User user = new User();
		user.setUserId(1L);
		ownedShare.setShare(share);
		ownedShare.setUser(user);
		ownedShare.setQuantity(10);
		List<OwnedShare> os = new ArrayList<OwnedShare>();
		os.add(ownedShare);
		user.setOwnedShares(os);
		share.setShareId(1L);
		dao.addOwnedShare(ownedShare);
		
		//Create new user and trade with them
		User user2 = new User();
		user2.setUserId(2L);
		
		OwnedShare beforeretShare1 = dao.getOwnedShareByShareAndUser(share, user);
		OwnedShare beforeretShare2 = dao.getOwnedShareByShareAndUser(share, user2);
		dao.transferSharesBetweenUsers(user, user2, share, 5.0,1.0);	
		OwnedShare afterretShare1 = dao.getOwnedShareByShareAndUser(share, user);
		OwnedShare afterretShare2 = dao.getOwnedShareByShareAndUser(share, user2);
		
		assertEquals(beforeretShare1.getQuantity() + beforeretShare2.getQuantity(),afterretShare1.getQuantity() + afterretShare2.getQuantity(),1);
	}

}
