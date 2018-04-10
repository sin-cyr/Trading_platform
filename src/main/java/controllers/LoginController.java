package controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import databaseAccessObjects.UsersDAO;
import databaseEntities.CurrentTrade;
import databaseEntities.User;
import com.fdmgroup.tools.BCrypt;

@Controller
public class LoginController {

	@RequestMapping(value = "/Login", method = RequestMethod.POST)
	protected String doGet(@RequestParam String email, @RequestParam String password, HttpServletRequest request) {
		UsersDAO dao = new UsersDAO();

		HttpSession session = request.getSession();
		if (!(dao.getUserByEmail(email) == null)) {
			User user = dao.getUserByEmail(email);
			// BCrypt.checkpw(password, user.getPassword())
			if (password.equals(user.getPassword())) {
				if (user.getBanned() == 1) {
					// Banned user
					request.setAttribute("timers", "2");
					request.setAttribute("message", "You're Banned");
					return "/redirecter";
				}
				session.setAttribute("popup", 0);
				session.setAttribute("loggedUser", user);
				return "redirect:/listcurrent";
			} else {
				// wrong password
				request.setAttribute("messages", "You got the wrong password, please try again!");
				request.setAttribute("timers", "2");
				request.setAttribute("message", "Incorrect Password");
				return "/redirecter";
			}
		} else if (!(dao.getUserByUsername(email) == null)) {
			User user = dao.getUserByUsername(email);
			// BCrypt.checkpw(password, user.getPassword())
			if (password.equals(user.getPassword())) {
				if (user.getBanned() == 1) {
					// Banned user
					request.setAttribute("timers", "2");
					request.setAttribute("message", "You're Banned");
					return "/redirecter";
				}
				session.setAttribute("popup", 0);
				session.setAttribute("loggedUser", user);
				return "redirect:/listcurrent";
			} else {
				// wrong password
				request.setAttribute("messages", "You got the wrong password, please try again!");
				request.setAttribute("timers", "2");
				request.setAttribute("message", "Incorrect Password");
				return "/redirecter";
			}
		} else {
			request.setAttribute("messages", "User does not exist!");
			request.setAttribute("timers", "2");
			request.setAttribute("message", "User doesn't exist");
			return "/redirecter";
		}
	}

}
