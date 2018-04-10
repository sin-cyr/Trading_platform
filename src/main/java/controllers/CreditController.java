package controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import databaseAccessObjects.UsersDAO;
import databaseEntities.User;

@Controller
public class CreditController {

	@RequestMapping(value="/credit")
	public String runCreditPage(HttpServletRequest request, Model model){
		UsersDAO dao = new UsersDAO();
		HttpSession session = request.getSession();
		User loggedUser = (User) session.getAttribute("loggedUser");
		User user = dao.getUserByUsername(loggedUser.getUsername());
		model.addAttribute("user", user);
		return "buyCredits";
	}
	
	@RequestMapping(value="/updatecredits")
	public String addCredits(Model model, HttpServletRequest request, @RequestParam String amount){
		UsersDAO dao = new UsersDAO();
		HttpSession session = request.getSession();
		User loggedUser = (User) session.getAttribute("loggedUser");
		User user = dao.getUserByUsername(loggedUser.getUsername());
		Double credits = Double.parseDouble(amount);
		dao.addCreditForUser(user, credits);
		user.setCredit(user.getCredit()+credits);
		System.out.println("Credits added");
		model.addAttribute("user",user);
		session.setAttribute("loggedUser", user);
		return "buyCredits";
	}
	
}
