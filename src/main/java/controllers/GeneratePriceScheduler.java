package controllers;

import java.sql.Timestamp;
import java.util.List;
import java.util.Random;

import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import databaseAccessObjects.*;

import databaseEntities.Company;
import databaseEntities.Share;
import databaseEntities.SharesPrices;

@Component
public class GeneratePriceScheduler {

	@Async
	public void genPrices() {
		System.out.println("-- Price Generation Started --");
		while (true) {

			try {
				// Update price every 5 minutes
				// 5 mins in milli 300000
				Thread.sleep(300000); // milliseconds
				addPricesToDB();
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public void genPrices(int it) {
		System.out.println("-- Price Population started --");
		int i = 0;
		while (i < it) {
			addPricesToDB();
			i++;
		}
	}

	public static void addPricesToDB() {
		SharesPriceDAO spdao = new SharesPriceDAO();
		CompaniesDAO cdao = new CompaniesDAO();
		List<Company> companies = cdao.listAllCompaniesAndShares();

		for (Company c : companies) {
			List<Share> shares = c.getShares();
			for (Share s : shares) {
				SharesPrices sp = new SharesPrices();
				Double oldPrice = spdao.showPrice(s);
				sp.setShare(s);
				Double newprice = generatePrice(oldPrice);
				sp.setPrice(newprice);
				sp.setTimestamp(new Timestamp(System.currentTimeMillis()));
				spdao.addPrice(sp.getShare(), sp);
			}
		}
	}

	public static Double generatePrice(double old_price) {
		Random r = new Random();
		double rangeMin = 0.0;
		double rangeMax = 1.0;
		double changePercent;
		double volatility = 0.02;
		double changeAmount;
		double new_price;
		double rValue = rangeMin + (rangeMax - rangeMin) * r.nextDouble();

		changePercent = 2 * volatility * rValue;

		if (changePercent > volatility) {
			changePercent -= (2 * volatility);
		}
		changeAmount = old_price * changePercent;
		new_price = old_price + changeAmount;
		return new_price;
	}

}
