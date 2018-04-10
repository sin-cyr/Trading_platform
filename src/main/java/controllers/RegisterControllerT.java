package controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import databaseAccessObjects.UsersDAO;
import databaseEntities.User;
import com.fdmgroup.tools.BCrypt;

@Controller
public class RegisterControllerT {

	@RequestMapping(value = "/Register", method = RequestMethod.POST)
	protected String doGet(@RequestParam String username, @RequestParam String email, @RequestParam String password, @RequestParam String password2, Model model, HttpServletRequest request) {
		UsersDAO dao = new UsersDAO();
		HttpSession session = request.getSession();
		User user = new User();
		System.out.println(dao.getUserByUsername(username));
		if(dao.getUserByUsername(username)!=null){
			return "index";
		} else {
			user.setUsername(username);
			user.setEmail(email);
			if(password.equals(password2)){
				//String pw_hash = BCrypt.hashpw(password, BCrypt.gensalt());
				user.setPassword(password);
				dao.addUser(user);
				session.setAttribute("popup", 0);
				session.setAttribute("loggedUser", user);
				return "redirect:/listcurrent";
			}
		}
		return "index";

	}
}
