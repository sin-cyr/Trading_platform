package databaseAccessObjects;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Before;
import org.junit.Test;

import databaseEntities.Company;
import databaseEntities.CurrentTrade;
import databaseEntities.Share;
import databaseEntities.SharesPrices;
import databaseEntities.Trade;
import databaseEntities.User;

public class TestSharesPricesDAO {

	SharesPriceDAO spdao;
	SharesPrices sp;
	Share share;
	CurrentTrade ct;
	Trade trade;
	User user;
	Company company;
	
	@Before
	public void setUp() throws Exception {
		spdao = new SharesPriceDAO();
		sp = new SharesPrices();
		share = new Share();
		ct = new CurrentTrade();
		trade = new Trade();
		user = new User();
		company = new Company();
		
	}
	
	
	
	@Test
	public void test_ifGetAllSharesPricesAreListed(){
	List <SharesPrices> sharesPrice = spdao.getAllSharesPrices();
	System.out.println(sharesPrice.size());	
	assertEquals(4, sharesPrice.size());
	
	}

	//@Test
	public void test_ifSharesPricesDetailsAreAdded() {
		user.setUsername("newuser");
	//	trade.setUser(user);		
		trade.setShare(share);
		share.setCompany(company);
		ct.setShare(share);
		sp.setShare(share);
		sp.setPrice(13.13);
		spdao.addPrice(share, sp);
		System.out.println(share);
		System.out.println(sp);
		assertNotNull(sp);
		assertNotNull(share);
		assertNotNull(ct);
	}

	

}
