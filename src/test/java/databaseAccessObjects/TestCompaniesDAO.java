package databaseAccessObjects;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Before;
import org.junit.Test;

import databaseEntities.Company;
import databaseEntities.Share;

public class TestCompaniesDAO {

	
	CompaniesDAO cdao;
	Company company;
	Share share;
	
	
	@Before
	public void setUp() throws Exception {
	cdao = new CompaniesDAO();
	company = new Company();
	share = new Share();
	}

	
//	@Test
//	public void test_ifCompanyIsInsertedIntoTheTradingDatabase() {
//		company.setName("BT");
//		share.setCompany(company);
//		cdao.addCompany(company);
//		assertNotNull(company);
//		assertEquals("BT", company.getName());
//	}
//	

	
	@Test
	public void test_ifGetCompanyMethodReturnsTheCompanySearchedFor(){
	
		//Company com = cdao.getCompanyByCompanyName("Company");
		//Company com = cdao.getCompanyByCompanyName("Pellentesque Ut LLC");
	//	assertEquals("Company", com.getName());
		//assertNotNull(companies);
		//System.out.println(companies);
		
		
	}
	

}
