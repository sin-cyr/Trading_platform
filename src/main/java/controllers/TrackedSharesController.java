package controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import databaseAccessObjects.CompaniesDAO;
import databaseAccessObjects.OwnedSharesDAO;
import databaseAccessObjects.SharesPriceDAO;
import databaseAccessObjects.TrackedSharesDAO;
import databaseAccessObjects.UsersDAO;
import databaseEntities.Company;
import databaseEntities.Share;
import databaseEntities.SharesPrices;
import databaseEntities.TrackedShare;
import databaseEntities.User;

@Controller
public class TrackedSharesController {

	@RequestMapping(value = "/trackedShares")
	public String addTrackedSharesForUser(@RequestParam String shareid, HttpServletRequest request, Model model) {
		TrackedSharesDAO track = new TrackedSharesDAO();
		UsersDAO users = new UsersDAO();

		SharesPriceDAO sdao = new SharesPriceDAO();
		OwnedSharesDAO odao = new OwnedSharesDAO();
		HttpSession session = request.getSession();
		User loggedUser = (User) session.getAttribute("loggedUser");
		System.out.println(shareid);
		Share share = odao.getSharebyShareid(Long.parseLong(shareid));
		track.addTrackedSharesForUser(loggedUser, sdao.getSharePriceByShare(share));
		User user = users.getUserByUsername(loggedUser.getUsername());
		String company = share.getCompany().getName();
		session.setAttribute("tracked", "You are now tracking " + company);
		session.setAttribute("loggedUser", user);
		return "redirect:/listcurrent";
	}

	@RequestMapping(value = "/removeTrackedShares")
	public String removeTrackedSharesForUser(@RequestParam String untrack, HttpServletRequest request, Model model) {
		TrackedSharesDAO track = new TrackedSharesDAO();
		UsersDAO users = new UsersDAO();
		OwnedSharesDAO odao = new OwnedSharesDAO();
		SharesPriceDAO sdao = new SharesPriceDAO();
		HttpSession session = request.getSession();
		User loggedUser = (User) session.getAttribute("loggedUser");
		User user = users.getUserByUsername(loggedUser.getUsername());
		Share share = odao.getSharebyShareid(Long.parseLong(untrack));
/*
		List<TrackedShare> tracked = track.getAllTrackedShareByUser(user);
		for (TrackedShare trackedshare : tracked) {
			if (trackedshare.getSharePrice().getShare() != null) {
				if (trackedshare.getSharePrice().getShare().getShareId() == share.getShareId()) {
					track.removeTrackedShareForUser(trackedshare);
				}
			}
		}*/
		track.removeTrackedShareBySharePrice(sdao.getSharePriceByShare(share));
		
	
		
		session.setAttribute("popup", 1);
		session.setAttribute("loggedUser", user);
		return "redirect:/listtracked";

	}

}
