package com.fdmgroup.tools;

import controllers.GeneratePriceScheduler;

public class DatabasePriceGeneration {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		GeneratePriceScheduler gps = new GeneratePriceScheduler();
		//Generate 100 prices for each company
		gps.genPrices(50);
	}

}
