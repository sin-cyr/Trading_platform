package controllers;
import java.util.List;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


import com.fdmgroup.tools.ProfitLossCalculator;

import databaseAccessObjects.CurrentTradesDAO;
import databaseAccessObjects.SharesPriceDAO;
import databaseEntities.CurrentTrade;
import databaseEntities.Share;
import databaseEntities.SharesPrices;
import databaseAccessObjects.CompaniesDAO;
import databaseAccessObjects.UsersDAO;
import databaseEntities.Company;

import databaseEntities.User;

@Controller
public class AdminController {
	
	@RequestMapping(value = "/adminCompany")
	public String adminCompany(Model model,HttpServletRequest request){
		User currentUser = (User) request.getSession().getAttribute("loggedUser");
		if (currentUser == null || currentUser.getAdminBoolean() != 1) {
			return "index";
		} else {
			CompaniesDAO cdao = new CompaniesDAO();
			List<Company> companies = cdao.listAllCompaniesAndShares();
			if(companies != null && !companies.isEmpty()){
			Collections.sort(companies, new Comparator<Company>(){
				public int compare(Company c1, Company c2){
					return c1.getName().compareTo(c2.getName());
				}
			});
			model.addAttribute("companies",companies);
			}
			return "/adminCompany";
		}

	}
	
	@RequestMapping(value = "/queryCompanyName")
	public String queryCompanyName(Model model, @RequestParam String query,HttpServletRequest request) {
		User currentUser = (User) request.getSession().getAttribute("loggedUser");
		if (currentUser == null || currentUser.getAdminBoolean() != 1) {
			return "index";
		}
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
		return "/adminCompany";

	}
	
	@RequestMapping(value = "/addCompany")
	public String addCompany(Model model, @RequestParam String compName, @RequestParam String compBio, @RequestParam String compIndustry,
			@RequestParam String compShareAmount, @RequestParam String compSharePrice, HttpServletRequest request){
		User currentUser = (User) request.getSession().getAttribute("loggedUser");
		if (currentUser == null || currentUser.getAdminBoolean() != 1) {
			return "index";
		}
		CompaniesDAO cdao = new CompaniesDAO();
		Company c = cdao.getCompanyByCompanyName(compName);
		SharesPriceDAO spdao = new SharesPriceDAO();
		if(c == null){
			//Add company
			Company toAdd = new Company();
			toAdd.setName(compName);
			toAdd.setBio(compBio);
			toAdd.setIndustry(compIndustry);
			
			//Create Shares
			List<Share> shares = new ArrayList<Share>();
			List<SharesPrices> sps = new ArrayList<SharesPrices>();
			for(int i = 0; i < Integer.parseInt(compShareAmount); i++){
				Share s = new Share();
				s.setCompany(toAdd);
				SharesPrices sp = new SharesPrices();
				sp.setShare(s);
				sp.setPrice(Double.parseDouble(compSharePrice));
				sp.setTimestamp(new Timestamp(System.currentTimeMillis()));
				shares.add(s);
				sps.add(sp);
			}
			toAdd.setShares(shares);
			cdao.addCompany(toAdd);
			for (int i = 0; i < Integer.parseInt(compShareAmount); i++){
				spdao.addPrice(shares.get(i), sps.get(i));
			}
		} else{
			model.addAttribute("error", "Company Already Exists");
		}
		
		//Populate companies
		List<Company> companies = cdao.listAllCompaniesAndShares();
		if(companies != null && !companies.isEmpty()){
		Collections.sort(companies, new Comparator<Company>(){
			public int compare(Company c1, Company c2){
				return c1.getName().compareTo(c2.getName());
			}
		});
		model.addAttribute("companies",companies);
		}
		return "/adminCompany";
		

	}
	

	
	@RequestMapping(value = "/adminTrade")
	public String adminTrade(Model model,HttpServletRequest request, HttpSession session){
		User currentUser = (User) request.getSession().getAttribute("loggedUser");
		if (currentUser == null || currentUser.getAdminBoolean() != 1) {
			return "index";
		} else {
			CurrentTradesDAO dao = new CurrentTradesDAO();
			List<CurrentTrade> currentTrades = dao.showAllCurrentTrades();
			model.addAttribute("currentTrades", currentTrades);
			session.setAttribute("profitLoss", ProfitLossCalculator.calcProfitLoss((User)session.getAttribute("loggedUser")));
			return "adminTrade";
		}
	
	}
	@RequestMapping(value = "/deleteTrades")
	public String setBuyAndSellToZero(Model model, HttpServletRequest request, HttpSession session, @RequestParam long tradeID){
	User user = (User)session.getAttribute("loggedUser");
	if (user == null || user.getAdminBoolean() != 1) {
		return "index";
	}
	CurrentTradesDAO cDAO = new CurrentTradesDAO();
	cDAO.setAmountToZero(tradeID);
	System.out.println("passed: ");
	CurrentTradesDAO dao = new CurrentTradesDAO();
	List<CurrentTrade> currentTrades = dao.showAllCurrentTrades();
	model.addAttribute("currentTrades", currentTrades);
	session.setAttribute("profitLoss", ProfitLossCalculator.calcProfitLoss((User) session.getAttribute("loggedUser")));
	session.setAttribute("loggedUser", user);
	return "adminTrade";
	}
	
	@RequestMapping(value="adminUserInfo")
	public String returnUserInformation(Model model, HttpServletRequest request, HttpSession session, @RequestParam long uInfo){
		User currentUser = (User) request.getSession().getAttribute("loggedUser");
		if (currentUser == null || currentUser.getAdminBoolean() != 1) {
			return "index";
		} else {
	UsersDAO userDAO = new UsersDAO();
	List<User> userRequested = userDAO.getUserByUserId(uInfo);
	User user = (User)session.getAttribute("loggedUser");
	model.addAttribute("user", userRequested);
	session.setAttribute("loggedUser", user);
	return "adminEditUser2";
		}
	}
	
	@RequestMapping(value = "/adminFilterByCompany")
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
			return "adminTrade";

		} else {
			session.setAttribute("no", "Company does not exist");
			return "redirect:/adminTrade";
		}

	}
	
	@RequestMapping(value = "/adminSearchTrades", method = RequestMethod.POST)
	public String searchTrades(@RequestParam("options") String choice, @RequestParam("filter") String choice2,
			Model model, HttpSession session, HttpServletRequest request) {
		if (session.getAttribute("loggedUser") == null) {

			return "index";
		}
		choice = request.getParameter("options");
		CurrentTradesDAO dao = new CurrentTradesDAO();
		List<CurrentTrade> currentTrades = dao.showAllCurrentTrades();
		List<CurrentTrade> industryTrades = new ArrayList<CurrentTrade>();

		if (choice.equals("bplowest")) {
			Collections.sort(currentTrades, new Comparator<CurrentTrade>() {
				public int compare(CurrentTrade bp, CurrentTrade bp1) {
					return Double.compare(bp.getBuyPrice(), bp1.getBuyPrice());
				}
			});
			if (choice2.equals("All")) {
				model.addAttribute("currentTrades", currentTrades);
				return "adminTrade";
			}
			for (CurrentTrade c : currentTrades) {
				if (c.getShare().getCompany().getIndustry().equals(choice2)) {
					industryTrades.add(c);
					model.addAttribute("currentTrades", industryTrades);
				}
			}
		}

		else if (choice.equals("bphighest")) {
			Collections.sort(currentTrades, new Comparator<CurrentTrade>() {
				public int compare(CurrentTrade bp, CurrentTrade bp1) {
					return Double.compare(bp1.getBuyPrice(), bp.getBuyPrice());
				}
			});
			if (choice2.equals("All")) {
				model.addAttribute("currentTrades", currentTrades);
				return "adminTrade";
			}
			for (CurrentTrade c : currentTrades) {
				if (c.getShare().getCompany().getIndustry().equals(choice2)) {
					industryTrades.add(c);
					model.addAttribute("currentTrades", industryTrades);
				}
			}
		}

		else if (choice.equals("sphighest")) {
			Collections.sort(currentTrades, new Comparator<CurrentTrade>() {
				public int compare(CurrentTrade bp, CurrentTrade bp1) {
					return Double.compare(bp1.getSellPrice(), bp.getSellPrice());
				}
			});
			if (choice2.equals("All")) {
				model.addAttribute("currentTrades", currentTrades);
				return "adminTrade";
			}
			for (CurrentTrade c : currentTrades) {
				if (c.getShare().getCompany().getIndustry().equals(choice2)) {
					industryTrades.add(c);
					model.addAttribute("currentTrades", industryTrades);
				}
			}

		} else if (choice.equals("splowest")) {
			Collections.sort(currentTrades, new Comparator<CurrentTrade>() {
				public int compare(CurrentTrade bp, CurrentTrade bp1) {
					return Double.compare(bp.getSellPrice(), bp1.getSellPrice());
				}
			});
			if (choice2.equals("All")) {
				model.addAttribute("currentTrades", currentTrades);
				return "adminTrade";
			}
			for (CurrentTrade c : currentTrades) {
				if (c.getShare().getCompany().getIndustry().equals(choice2)) {
					industryTrades.add(c);
					model.addAttribute("currentTrades", industryTrades);
				}
			}

		} else if (choice.equals("tprecent")) {
			Collections.sort(currentTrades, new Comparator<CurrentTrade>() {
				public int compare(CurrentTrade ct1, CurrentTrade ct2) {
					return ct1.getTimePosted().compareTo(ct2.getTimePosted());
				}
			});
			if (choice2.equals("All")) {
				model.addAttribute("currentTrades", currentTrades);
				return "adminTrade";
			}
			for (CurrentTrade c : currentTrades) {
				if (c.getShare().getCompany().getIndustry().equals(choice2)) {
					industryTrades.add(c);
					model.addAttribute("currentTrades", industryTrades);
				}
			}

		} else if (choice.equals("tplatest")) {
			Collections.sort(currentTrades, new Comparator<CurrentTrade>() {
				public int compare(CurrentTrade ct1, CurrentTrade ct2) {
					return ct2.getTimePosted().compareTo(ct1.getTimePosted());
				}
			});
			if (choice2.equals("All")) {
				model.addAttribute("currentTrades", currentTrades);
				return "adminTrade";
			}
			for (CurrentTrade c : currentTrades) {
				if (c.getShare().getCompany().getIndustry().equals(choice2)) {
					industryTrades.add(c);
					model.addAttribute("currentTrades", industryTrades);
				}
			}
		}
		return "/adminTrade";
	}


	
	@RequestMapping(value = "/adminUser")
	public String adminUser(Model model,HttpServletRequest request){
		User currentUser = (User) request.getSession().getAttribute("loggedUser");
		if (currentUser == null || currentUser.getAdminBoolean() != 1) {
			return "index";
		} else {
			UsersDAO dao = new UsersDAO();
			List<User> users = dao.getAllUsers();
			Collections.sort(users, new Comparator<User>() {
				public int compare(User u1, User u2) {
					return u1.getUsername().compareTo(u2.getUsername());
				}
			});
			request.setAttribute("users", users);
			return "/adminUser";
		}
		
	}
	
	@RequestMapping(value = "/adminGoToUser")
	public String manageUser(Model model,HttpServletRequest request){
		
		User currentUser = (User) request.getSession().getAttribute("loggedUser");
		if (currentUser == null || currentUser.getAdminBoolean() != 1) {
			return "index";
		} else {
			UsersDAO dao = new UsersDAO();
			List<User> users = dao.getAllUsers();
			String choice = request.getParameter("edituserbutton");
			
			for(User user: users){
				if(choice.equals(user.getUsername())){
					request.setAttribute("user",dao.getUserByUsername(choice));
					return "/adminEditUser";
				}
			}
			return "redirect:adminUser";
		}
		
	}
	
	

}
