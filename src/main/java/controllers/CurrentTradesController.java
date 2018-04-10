package controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import databaseAccessObjects.CurrentTradesDAO;
import databaseAccessObjects.OwnedSharesDAO;
import databaseAccessObjects.UsersDAO;
import databaseEntities.CurrentTrade;
import databaseEntities.User;

@Controller
public class CurrentTradesController {
	
	@RequestMapping(value="/tradesSell")
	public String tradeSellLogic(Model model, @RequestParam String sellbutton, @RequestParam String quantity, HttpServletRequest request){
		OwnedSharesDAO odao = new OwnedSharesDAO();
		UsersDAO users = new UsersDAO();
		CurrentTradesDAO cdao = new CurrentTradesDAO();
		CurrentTrade trade = cdao.getCurrentTradebyid(Long.parseLong(sellbutton));
		
		HttpSession session = request.getSession();
		User loggedUser = (User) session.getAttribute("loggedUser");
		User userSeller = users.getUserByUsername(loggedUser.getUsername());
		odao.transferSharesBetweenUsers(userSeller, trade.getUser(), trade.getShare(), Double.parseDouble(quantity), trade.getSellPrice());
		request.getSession().setAttribute("loggedUser", users.getUserByUsername(loggedUser.getUsername()));

		return "redirect:/listcurrent";
	}
	
	
	
	@RequestMapping(value="/tradesBuy")
	public String tradeBuyLogic(Model model, @RequestParam String buybutton, @RequestParam String quantity, HttpServletRequest request){
		OwnedSharesDAO odao = new OwnedSharesDAO();
		UsersDAO users = new UsersDAO();
		CurrentTradesDAO cdao = new CurrentTradesDAO();
		CurrentTrade trade = cdao.getCurrentTradebyid(Long.parseLong(buybutton));
		
		HttpSession session = request.getSession();
		User loggedUser = (User) session.getAttribute("loggedUser");
		User userBuyer = users.getUserByUsername(loggedUser.getUsername());
		odao.transferSharesBetweenUsers(trade.getUser(), userBuyer, trade.getShare(), Double.parseDouble(quantity), trade.getSellPrice());
		request.getSession().setAttribute("loggedUser", users.getUserByUsername(loggedUser.getUsername()));

		return "redirect:/listcurrent";
	}
	
	

}
