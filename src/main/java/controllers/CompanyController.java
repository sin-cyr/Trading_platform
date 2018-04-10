package controllers;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import databaseAccessObjects.CompaniesDAO;
import databaseAccessObjects.SharesPriceDAO;
import databaseEntities.Company;
import databaseEntities.Share;
import databaseEntities.SharesPrices;

@Controller
public class CompanyController {

	@RequestMapping(value = "/company")
	public String runCompanyInfo(Model model, @RequestParam String cinfo) {
		JSONObject jObject = new JSONObject();
		JSONArray jArray = new JSONArray();
		
		
		
		CompaniesDAO cdao = new CompaniesDAO();
		SharesPriceDAO spdao = new SharesPriceDAO();
		Company c = cdao.getCompanyByCompanyName(cinfo);
		System.out.println(cinfo);
		model.addAttribute("chosenCompany", c);
		List<SharesPrices> sps = spdao.getAllSharesPrices();
		List<SharesPrices> priceHistory = new ArrayList<SharesPrices>();
		for (SharesPrices sp : sps) {
			if (c.getShares().get(0) != null && sp.getShare() != null) {
				if (sp.getShare().getShareId() == c.getShares().get(0).getShareId()) {
					// IF SHARESPRICE BELONGS TO COMPANY
					// ADD TO LIST
					priceHistory.add(sp);
				}
			}
		}

		// Sort latest to oldest
		Collections.sort(priceHistory, new Comparator<SharesPrices>() {
			public int compare(SharesPrices sp1, SharesPrices sp2) {
				// return sp2.getTimestamp().compareTo(sp1.getTimestamp());
				long t1 = sp1.getTimestamp().getTime();
				long t2 = sp2.getTimestamp().getTime();
				return Long.compare(t2, t1);

			}
		});

		List<SharesPrices> limitedList = new ArrayList<SharesPrices>();

		int it = 0;

		for (int i = 0; i < priceHistory.size(); i++) {
			if (it < 22) {
				limitedList.add(priceHistory.get(i));
			} else {
				break;
			}
			it++;
		}

		// Sort oldest to latest
		Collections.sort(limitedList, new Comparator<SharesPrices>() {
			public int compare(SharesPrices sp1, SharesPrices sp2) {
				return sp1.getTimestamp().compareTo(sp2.getTimestamp());
			}
		});
		
		model.addAttribute("priceHistory",limitedList);
		
//json object created and array added
		
		jArray.put(limitedList);
		jObject.put("priceHistory", jArray);
		return "companyInfo";
	}

	@RequestMapping(value = "/querycompany")
	public String queryCompanyName(Model model, @RequestParam String query) {
		CompaniesDAO cdao = new CompaniesDAO();
		List<Company> companies = new ArrayList<Company>();
		companies = cdao.queryCompany(query);
		if (companies.isEmpty()) {
			companies = cdao.listAllCompaniesAndShares();
			model.addAttribute("error", "No search results");
		}
		Collections.sort(companies, new Comparator<Company>() {
			public int compare(Company c1, Company c2) {
				return c1.getName().compareTo(c2.getName());
			}
		});
		model.addAttribute("companies", companies);
		return "companies";

	}

}
