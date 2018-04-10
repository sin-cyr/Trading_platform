package controllers;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import databaseAccessObjects.CurrentTradesDAO;
import databaseAccessObjects.OwnedSharesDAO;
import databaseAccessObjects.UsersDAO;
import databaseEntities.CurrentTrade;
import databaseEntities.OwnedShare;
import databaseEntities.Share;
import databaseEntities.User;

@Controller
public class Trade {

	@RequestMapping(value = "/trade")
	public String populate(Model model, HttpServletRequest request) {
		UsersDAO users = new UsersDAO();
		OwnedSharesDAO owned2 = new OwnedSharesDAO();

		HttpSession session = request.getSession();
		User loggedUser = (User) session.getAttribute("loggedUser");
		User user = users.getUserByUsername(loggedUser.getUsername());

		List<CurrentTrade> myTrade = user.getCurrentTrades();
		List<Share> allShares = owned2.getAllShares();
		List<OwnedShare> owned = owned2.getOwnedSharesForUser(user);

		model.addAttribute("mytrade", myTrade);
		model.addAttribute("mybuy", allShares);
		model.addAttribute("mysell", owned);

		return "Trade";
	}

	@RequestMapping(value = "/whatAvailableTrades")
	public String getAvailableTrades(Model model, HttpServletRequest request) {
		UsersDAO users = new UsersDAO();
		OwnedSharesDAO owned2 = new OwnedSharesDAO();

		HttpSession session = request.getSession();
		User loggedUser = (User) session.getAttribute("loggedUser");
		User user = users.getUserByUsername(loggedUser.getUsername());

		List<CurrentTrade> myTrade = user.getCurrentTrades();
		List<Share> allShares = owned2.getAllShares();
		List<OwnedShare> owned = owned2.getOwnedSharesForUser(user);

		model.addAttribute("mytrade", myTrade);
		model.addAttribute("mybuy", allShares);
		model.addAttribute("mysell", owned);

		// Bind share to the object, perhaps current guide price
		Share share = owned2.getSharebyShareid(Long.parseLong(request.getParameter("options")));
		OwnedShare ownedShare = owned2.getOwnedShareByShareAndUser(share, user);
		session.setAttribute("selectedshare", share);

		if (ownedShare == null || ownedShare.getQuantity() == 0) {
			session.setAttribute("quantityowned", 0);
		} else {
			session.setAttribute("quantityowned", ownedShare.getQuantity());
		}
		return "Trade";
	}

	@RequestMapping("/modalCreateTrade")
	public String generateModelForTrade(Model model, HttpServletRequest request) {

		UsersDAO users = new UsersDAO();
		OwnedSharesDAO owned2 = new OwnedSharesDAO();

		HttpSession session = request.getSession();
		User loggedUser = (User) session.getAttribute("loggedUser");
		User user = users.getUserByUsername(loggedUser.getUsername());

		List<CurrentTrade> myTrade = user.getCurrentTrades();
		List<Share> allShares = owned2.getAllShares();
		List<OwnedShare> owned = owned2.getOwnedSharesForUser(user);

		model.addAttribute("mytrade", myTrade);
		model.addAttribute("mybuy", allShares);
		model.addAttribute("mysell", owned);

		String tradeType = request.getParameter("tradeOptions");

		if (tradeType.equals("buyTrade")) {
			model.addAttribute("modalType", 1);
		} else if (tradeType.equals("sellTrade")) {
			model.addAttribute("modalType", 2);
		} else if (tradeType.equals("bothTrade")) {
			model.addAttribute("modalType", 3);
		}

		return "Trade";
	}

	@RequestMapping("/postBuyTrade")
	public String postBuyTrade(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		System.out.println(((Share)session.getAttribute("selectedshare")).getShareId());
		addCurrentTradeToDatabase((Share) session.getAttribute("selectedshare"),
				(User) session.getAttribute("loggedUser"), Double.parseDouble(request.getParameter("shareAmount")),
				Double.parseDouble(request.getParameter("price")), 0, 0);
		return populate(model, request);
	}

	@RequestMapping("/postSellTrade")
	public String postSellTrade(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		addCurrentTradeToDatabase((Share) session.getAttribute("selectedshare"),
				(User) session.getAttribute("loggedUser"), 0, 0,
				Double.parseDouble(request.getParameter("shareAmount")),
				Double.parseDouble(request.getParameter("price")));
		return populate(model, request);
	}

	@RequestMapping("/postBothTrade")
	public String postBothTrade(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		addCurrentTradeToDatabase((Share) session.getAttribute("selectedshare"),
				(User) session.getAttribute("loggedUser"), Double.parseDouble(request.getParameter("buyPrice")),
				Double.parseDouble(request.getParameter("shareBuyAmount")),
				Double.parseDouble(request.getParameter("shareSellAmount")),
				Double.parseDouble(request.getParameter("sellPrice")));
		return populate(model, request);
	}

	private void addCurrentTradeToDatabase(Share share, User user, double buyAmount, double buyPrice, double sellAmount,
			double sellPrice) {
		CurrentTrade ct = new CurrentTrade();
		ct.setShare(share);
		ct.setTimePosted(new Timestamp(System.currentTimeMillis()));
		ct.setAmountSelling(sellAmount);
		ct.setSellPrice(sellPrice);
		ct.setBuyPrice(buyPrice);
		ct.setAmountBuying(buyAmount);
		ct.setUser(user);
		CurrentTradesDAO dao = new CurrentTradesDAO();
		dao.addShareDetails(ct);
	}

}
