package com.fdmgroup.tools;

import java.util.List;

import databaseAccessObjects.SharesPriceDAO;
import databaseAccessObjects.UsersDAO;
import databaseEntities.OwnedShare;
import databaseEntities.User;

public class ProfitLossCalculator {
	
	public static Double calcProfitLoss(User user){
		
		UsersDAO udao = new UsersDAO();
		SharesPriceDAO sdao = new SharesPriceDAO();
		User u = udao.getUserByEmail(user.getEmail());
		List<OwnedShare> os = u.getOwnedShares();
		if(os == null || os.isEmpty()){
			return 0.0;
		}
		Double currentPrice = 0.0;
		Double profitLoss = 0.0;
		for (OwnedShare o : os){
			currentPrice = sdao.showPrice(o.getShare());
			profitLoss += currentPrice - o.getPricePerShare();
		}
	
		return  (double) Math.round(profitLoss*100.0) /100.0;
	}

}
