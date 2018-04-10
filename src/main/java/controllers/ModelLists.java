package controllers;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fdmgroup.tools.ProfitLossCalculator;

import databaseAccessObjects.CompaniesDAO;
import databaseAccessObjects.CurrentTradesDAO;
import databaseAccessObjects.TrackedSharesDAO;
import databaseAccessObjects.UsersDAO;
import databaseEntities.Company;
import databaseEntities.CurrentTrade;
import databaseEntities.OwnedShare;
import databaseEntities.Share;
import databaseEntities.TrackedShare;
import databaseEntities.Trade;
import databaseEntities.User;

@Controller
public class ModelLists {
	@RequestMapping(value = "/listcurrent")
	public String listCurrentTrade(Model model, HttpSession session, HttpServletRequest request) {
		if (session.getAttribute("loggedUser") == null) {

			return "index";
		} else {
			CurrentTradesDAO dao = new CurrentTradesDAO();
			List<CurrentTrade> currentTrades = dao.showAllCurrentTrades();
			model.addAttribute("currentTrades", currentTrades);
			session.setAttribute("profitLoss",
					ProfitLossCalculator.calcProfitLoss((User) session.getAttribute("loggedUser")));

			return "/currentTrades";
		}
	}

	@RequestMapping(value = "/filterByCompany")
	public String searchByCompany(@RequestParam String comp2, Model model, HttpSession session,
			HttpServletRequest request) {
		if (session.getAttribute("loggedUser") == null) {

			return "index";
		}
		
		CurrentTradesDAO dao = new CurrentTradesDAO();
		CompaniesDAO cdao = new CompaniesDAO();
		List<Company> companyList = cdao.queryCompany(comp2);
		List<Share> shares = new ArrayList<>();
		List<CurrentTrade> search = new ArrayList<>();
		session.setAttribute("profitLoss",
				ProfitLossCalculator.calcProfitLoss((User) session.getAttribute("loggedUser")));
		if (!(companyList.isEmpty())) {

			for (Company c : companyList) {
				for (Share s : c.getShares()) {
					if (!(s == null)) {
						shares.add(s);
					}
				}

			}
			for (Share sh : shares) {
				List<CurrentTrade> currentTradeList = dao.getCurrentTradesByShare(sh);
				for (CurrentTrade ct : currentTradeList) {
					search.add(ct);
				}

			}

			model.addAttribute("currentTrades", search);
			return "/currentTrades";

		} else {
			session.setAttribute("no", "Company does not exist");
			return "redirect:/listcurrent";
		}

	}

	@RequestMapping(value = "/listowned")
	public String listOwnedShares(Model model, HttpSession session, HttpServletRequest request) {
		if (session.getAttribute("loggedUser") == null) {

			return "index";
		} else {
			session.setAttribute("profitLoss",
					ProfitLossCalculator.calcProfitLoss((User) session.getAttribute("loggedUser")));
			UsersDAO dao = new UsersDAO();
			User loggedUser = (User) session.getAttribute("loggedUser");
			User user = dao.getUserByUsername(loggedUser.getUsername());

			List<OwnedShare> ownedShares = user.getOwnedShares();
			model.addAttribute("ownedShares", ownedShares);
			return "/ownedShares";
		}
	}

	@RequestMapping(value = "/listtracked")
	public String listTrackedShares(Model model, HttpSession session, HttpServletRequest request) {
		if (session.getAttribute("loggedUser") == null) {
			return "index";
		} else {
			session.setAttribute("profitLoss",
					ProfitLossCalculator.calcProfitLoss((User) session.getAttribute("loggedUser")));
			UsersDAO dao = new UsersDAO();
			User loggedUser = (User) session.getAttribute("loggedUser");
			User user = dao.getUserByUsername(loggedUser.getUsername());
			List<TrackedShare> trackedShares = user.getTrackedShares();
			// List<Long> trackedShares = new ArrayList<Long>();
			// for (TrackedShare share : trackedShareObjects){
			// //trackedShares.add(share.getTrackedId());
			// System.out.println(share.getTrackedId());
			// }
			if (session.getAttribute("popup").equals(1)) {
				model.addAttribute("showpopup", 1);
				session.setAttribute("popup", 0);
			}

			model.addAttribute("trackedShares", trackedShares);
			
			return "/trackedShares";
		}
	}

	@RequestMapping(value = "/listhistory")
	public String listTradingHistory(Model model, HttpSession session, HttpServletRequest request) {
		if (session.getAttribute("loggedUser") == null) {
			return "index";
		} else {
			session.setAttribute("profitLoss",
					ProfitLossCalculator.calcProfitLoss((User) session.getAttribute("loggedUser")));
			UsersDAO dao = new UsersDAO();
			User loggedUser = (User) session.getAttribute("loggedUser");
			User user = dao.getUserByUsername(loggedUser.getUsername());
			List<Trade> boughtTrades = user.getBoughtTrades();
			List<Trade> soldTrades = user.getSoldTrades();

			model.addAttribute("boughtTrades", boughtTrades);
			model.addAttribute("soldTrades", soldTrades);
			return "/tradingHistory";
		}
	}

	@RequestMapping(value = "/listcompanies")
	public String listCompanies(Model model, HttpSession session, HttpServletRequest request) {
		if (session.getAttribute("loggedUser") == null) {
			return "index";
		} else {
			session.setAttribute("profitLoss",
					ProfitLossCalculator.calcProfitLoss((User) session.getAttribute("loggedUser")));
			CompaniesDAO cdao = new CompaniesDAO();
			List<Company> companies = cdao.listAllCompaniesAndShares();
			if (companies != null && !companies.isEmpty()) {
				Collections.sort(companies, new Comparator<Company>() {
					public int compare(Company c1, Company c2) {
						return c1.getName().compareTo(c2.getName());
					}
				});
				model.addAttribute("companies", companies);
			}
			return "/companies";
		}
	}

}
