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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import databaseAccessObjects.CompaniesDAO;
import databaseAccessObjects.CurrentTradesDAO;
import databaseAccessObjects.UsersDAO;
import databaseEntities.CurrentTrade;
import databaseEntities.User;

@Controller
public class AdminUserController {

	@RequestMapping(value = "/changeBanStatus")
	public String changeBanStatus(Model model, HttpServletRequest request) {
		User currentUser = (User) request.getSession().getAttribute("loggedUser");
		if (currentUser == null || currentUser.getAdminBoolean() != 1) {
			return "index";
		} else {
			UsersDAO dao = new UsersDAO();
			String username = request.getParameter("banButton");
			dao.changeBanStateByUsername(username);
			User user = dao.getUserByUsername(username);
			request.setAttribute("user", user);
			return "/adminEditUser";
		}

	}

	@RequestMapping(value = "/changeAdminStatus")
	public String changeAdminStatus(Model model, HttpServletRequest request) {
		User currentUser = (User) request.getSession().getAttribute("loggedUser");
		if (currentUser == null || currentUser.getAdminBoolean() != 1) {
			return "index";
		} else {
			UsersDAO dao = new UsersDAO();
			String username = request.getParameter("adminStatusButton");
			dao.changeAdminStatusByUsername(username);
			User user = dao.getUserByUsername(username);
			request.setAttribute("user", user);
			return "/adminEditUser";
		}

	}

	@RequestMapping(value = "/sortUsers", method = RequestMethod.POST)
	public String searchTrades(@RequestParam("options") String choice, @RequestParam("filter") String choice2,
			Model model, HttpSession session, HttpServletRequest request) {
		if (session.getAttribute("loggedUser") == null) {

			return "index";
		}
		choice = request.getParameter("options");

		UsersDAO dao = new UsersDAO();
		List<User> users = dao.getAllUsers();

		if (choice.equals("usernameAZ")) {
			Collections.sort(users, new Comparator<User>() {
				public int compare(User u1, User u2) {
					return u1.getUsername().compareTo(u2.getUsername());
				}
			});

			List<User> userfiltered = new ArrayList<User>();

			for (User u : users) {
				if (u.getAdminBoolean() == 1 && choice2.equals("Admin")) {
					userfiltered.add(u);
					model.addAttribute("users", userfiltered);

				} else if (u.getBanned() == 1 && choice2.equals("Banned")) {
					userfiltered.add(u);
					model.addAttribute("users", userfiltered);
				} else if (choice2.equals("All")) {
					model.addAttribute("users", users);
				}
			}

			return "/adminUser";
		}

		else if (choice.equals("usernameZA")) {
			Collections.sort(users, new Comparator<User>() {
				public int compare(User u1, User u2) {
					return u2.getUsername().compareTo(u1.getUsername());
				}
			});
			List<User> userfiltered = new ArrayList<User>();

			for (User u : users) {
				if (u.getAdminBoolean() == 1 && choice2.equals("Admin")) {
					userfiltered.add(u);
					model.addAttribute("users", userfiltered);

				} else if (u.getBanned() == 1 && choice2.equals("Banned")) {
					userfiltered.add(u);
					model.addAttribute("users", userfiltered);
				} else if (choice2.equals("All")) {
					model.addAttribute("users", users);
				}
			}
			return "/adminUser";
		}

		else if (choice.equals("credLowest")) {
			Collections.sort(users, new Comparator<User>() {
				public int compare(User u1, User u2) {
					return Double.compare(u1.getCredit(), u2.getCredit());
				}
			});
			List<User> userfiltered = new ArrayList<User>();

			for (User u : users) {
				if (u.getAdminBoolean() == 1 && choice2.equals("Admin")) {
					userfiltered.add(u);
					model.addAttribute("users", userfiltered);

				} else if (u.getBanned() == 1 && choice2.equals("Banned")) {
					userfiltered.add(u);
					model.addAttribute("users", userfiltered);
				} else if (choice2.equals("All")) {
					model.addAttribute("users", users);
				}
			}
			return "/adminUser";

		} else if (choice.equals("credHighest")) {
			Collections.sort(users, new Comparator<User>() {
				public int compare(User u1, User u2) {
					return Double.compare(u2.getCredit(), u1.getCredit());
				}
			});
			List<User> userfiltered = new ArrayList<User>();

			for (User u : users) {
				if (u.getAdminBoolean() == 1 && choice2.equals("Admin")) {
					userfiltered.add(u);
					model.addAttribute("users", userfiltered);

				} else if (u.getBanned() == 1 && choice2.equals("Banned")) {
					userfiltered.add(u);
					model.addAttribute("users", userfiltered);
				} else if (choice2.equals("All")) {
					model.addAttribute("users", users);
				}
			}
			return "/adminUser";

		}
		
		return "/adminUser";
	}
}
