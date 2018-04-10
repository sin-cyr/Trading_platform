package testRunners2;

import java.sql.Date;
import java.sql.Timestamp;

import databaseAccessObjects.CompaniesDAO;
import databaseAccessObjects.CurrentTradesDAO;
import databaseEntities.Company;
import databaseEntities.CurrentTrade;
import databaseEntities.OwnedShare;
import databaseEntities.Share;
import databaseEntities.Trade;
import databaseEntities.User;

public class SinansRunner {
//Sinans Runner working FAM!
	public static void main(String[] args) {

		CompaniesDAO cdao = new CompaniesDAO();
		Company company = new Company();
		User user = new User();
		Trade trade = new Trade();
		CurrentTradesDAO spd = new CurrentTradesDAO();
		Share share = new Share();
		CurrentTrade ct = new CurrentTrade();
		OwnedShare ow = new OwnedShare();
		// cdao.addCompany(company);
		// cdao.removeCompany(company);
		// cdao.listAllCompaniesAndShares();
		// cdao.searchCompanyShares("Erat");
		// cdao.updateCompany(company);

		// spd.showBuyPricesByShare(share);
		// spd.showSellPricesByShare(share);
//working
//		company.setName("Test Comapny");
//		user.setUsername("usernmae");
//		user.setEmail("email@.com");
//		user.setPassword("password");
//
//		share.setShareId(28l);
//		share.setCompany(company);
//		
//		trade.setShare(share);
//		ow.setShare(share);
//		ow.setUser(user);
//		ct.setBuyPrice(99);
//		ct.setSellPrice(80);
//		ct.setShare(share);
//
//		Timestamp newdate = new Timestamp(System.currentTimeMillis());
//		ct.setTimePosted(newdate);
//		ct.setUser(user);
//		spd.addShareDetails(ct);

		//spd.showAllCurrentTrades();
	//.setShareId(70l);
		
		//spd.showCurrentTradesByShare(share);
		//	company.setName("Erat");
		//cdao.removeCompany("Auctor Velit Eget Consulting");
		//cdao.removeCompanyByName("BT");
		//cdao.compRemove(7l);
		
		//spd.showCurrentTradesByIndustry("Advertising");
//		company.setName("In Corporation");
//		share.setCompany(company);
//		spd.showCurrentTradesByShare(share);
		cdao.getCompanyByIndustry("Payroll");

	}
}