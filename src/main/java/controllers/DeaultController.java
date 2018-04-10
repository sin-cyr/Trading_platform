package controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import databaseAccessObjects.SharesPriceDAO;
import databaseEntities.SharesPrices;

@Controller
public class DeaultController {

	@Autowired
	private GeneratePriceScheduler genP;

	public boolean genRunning = false;

	@RequestMapping("/")
	public String runApp() {
		if (genRunning == false) {
			genRunning = true;
			genP.genPrices();
		}
		return "index";
	}

	@RequestMapping("/aboutspage")
	public String runAbout() {
		return "about";
	}

	@RequestMapping("/currenttrades")
	public String runCurrentTrades() {
		return "currentTrades";
	}

	@RequestMapping("/ownedshares")
	public String runOwnedShares() {
		return "ownedShares";
	}

	@RequestMapping("/trackedshares")
	public String runTrackedShares() {
		return "trackedShares";
	}

	@RequestMapping("/tradinghistory")
	public String runTradingHistory() {
		return "tradingHistory";
	}

	@RequestMapping(value = "/Logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("loggedUser");
		request.setAttribute("message", "You are being logged out ");
		request.setAttribute("timers", "2");
		return "redirecter";
	}

}// tetstingl
