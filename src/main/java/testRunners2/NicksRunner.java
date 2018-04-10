package testRunners2;

import databaseAccessObjects.CompaniesDAO;
import databaseAccessObjects.OwnedSharesDAO;
import databaseAccessObjects.TrackedSharesDAO;
import databaseAccessObjects.UsersDAO;
import databaseEntities.Company;
import databaseEntities.OwnedShare;
import databaseEntities.Share;
import databaseEntities.SharesPrices;
import databaseEntities.TrackedShare;
import databaseEntities.User;

public class NicksRunner {

	public static void main(String[] args) {
		Share share = new Share();
		share.setShareId(101L);
		UsersDAO udao = new UsersDAO();
		User user = udao.getUserByEmail("arcu.Vestibulum@Duissit.edu");
		SharesPrices sp = new SharesPrices();
		sp.setShare(share);
		TrackedShare tShare = new TrackedShare();
		tShare.setTrackedId(2701L);
		tShare.setSharePrice(sp);
		tShare.setUser(user);
		
		TrackedSharesDAO dao = new TrackedSharesDAO();
		//dao.addTrackedSharesForUser(user, sp);
		dao.removeTrackedShareForUser(tShare);
		
		
	}

}
