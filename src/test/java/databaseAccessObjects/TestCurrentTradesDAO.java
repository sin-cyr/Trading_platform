package databaseAccessObjects;

import static org.junit.Assert.*;

import java.util.List;
import org.junit.Before;
import org.junit.Test;
import databaseEntities.Company;
import databaseEntities.CurrentTrade;
import databaseEntities.OwnedShare;
import databaseEntities.Share;
import databaseEntities.Trade;
import databaseEntities.User;

public class TestCurrentTradesDAO {

	
	CurrentTradesDAO ctdao;
	CurrentTrade ct,ct2;
	Company company;
	User user;
	Share share;
	OwnedShare ow;
	Trade trade;
	
	
	
	@Before
	public void setUp() throws Exception {
		ctdao = new CurrentTradesDAO();
		ct = new CurrentTrade();
		ct2 = new CurrentTrade();
		company = new Company();
		user = new User();
		share = new Share();
		ow = new OwnedShare();
	}

	@Test
	public void test_ifShowAllCurrentTradesForAllCompaniesAreDisplayed(){
		List <CurrentTrade> current = ctdao.showAllCurrentTrades();
		//assertNotNull(current);
		System.out.println(current.size());
		current.add(ct2);
		assertNotNull(current);
		assertEquals(103, current.size());
		System.out.println(current.size());
	}
	@Test
	public void test_ifShowAllCurrentTradesByShare(){
		share.setShareId(9l);
		List<CurrentTrade> currents =ctdao.showCurrentTradesByShare(share);
		assertNotNull(currents);
		//assertEquals(ct.getBuyPrice(),currents.get(0).getBuyPrice());
		assertEquals(12,currents.get(0).getBuyPrice(),1);
		
		
	}
//	@Test
	public void test_ifSharesBuyPriceSellPriceAndTimePostedIsAdded() {
		company.setName("Company Test");
		user.setUsername("USername");
		trade.setShare(share);
		ow.setUser(user);
		ow.setShare(share);
		ct.setBuyPrice(82);
		ct.setSellPrice(21);
		ct.setShare(share);
		ct.setUser(user);
		ctdao.addShareDetails(ct);
		assertNotNull(ct);
		assertEquals(82, ct.getBuyPrice(),1);
		assertEquals(21, ct.getSellPrice(),1);
	}
}





