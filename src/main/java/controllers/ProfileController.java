package controllers;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.eclipse.persistence.internal.oxm.conversion.Base64;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import databaseAccessObjects.UsersDAO;
import databaseEntities.User;

@Controller
public class ProfileController {

	@RequestMapping(value = "/profile")
	public String runProfilePage(HttpServletRequest request, Model model) {
		UsersDAO dao = new UsersDAO();
		HttpSession session = request.getSession();
		User loggedUser = (User) session.getAttribute("loggedUser");
		User user = dao.getUserByUsername(loggedUser.getUsername());
		byte[] imagebytes = Base64.base64Encode(user.getImageFile()); 
		String base64Encoded = null;
		try {

			if (imagebytes != null) {
				base64Encoded = new String(imagebytes, "UTF-8");
				System.out.println("length of encoded string:" + base64Encoded.length());
			}
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("usercredit", user.getCredit());
		model.addAttribute("useremail", user.getEmail());
		model.addAttribute("username", user.getUsername());
		model.addAttribute("profileimage", base64Encoded);

		return "/userProfile";
	}

	@RequestMapping(value = "/updatepassword")
	public String runChangePassword(@RequestParam String pwd, @RequestParam String pwd1, @RequestParam String pwd2,
			HttpServletRequest request, Model model) {
		UsersDAO dao = new UsersDAO();
		HttpSession session = request.getSession();
		User loggedUser = (User) session.getAttribute("loggedUser");
		User user = dao.getUserByUsername(loggedUser.getUsername());
		// check the old password has been entered correctly
		if (pwd.equals(user.getPassword())) {
			// check the new password was correctly confirmed
			if (pwd1.equals(pwd2)) {
				if (pwd.equals(pwd1)) {
					model.addAttribute("errormsg1", "Error: New password matches old password");
					model.addAttribute("color", "red");
				} else {
					dao.updatePasswordForUser(user, pwd1);
					
					model.addAttribute("errormsg1", "Password changed successfully!");
					model.addAttribute("color", "green");
				}
			} else {
				// two new passwords don't match
				model.addAttribute("errormsg1", "Error: Passwords don't match");
				model.addAttribute("color", "red");
			}
		} else {
			// incorrect old password
			model.addAttribute("errormsg1", "Error: Entered old password incorrectly.");
			model.addAttribute("color", "red");
		}
		loggedUser = dao.getUserByUsername(loggedUser.getUsername());
		session.setAttribute("loggedUser", loggedUser);
		model.addAttribute("usercredit", user.getCredit());
		model.addAttribute("useremail", user.getEmail());
		model.addAttribute("username", user.getUsername());
		return "/userProfile";
	}

	@RequestMapping(value = "/imageupload")
	public String addImage(HttpServletRequest request, @RequestParam("filename") MultipartFile file, Model model) {

		// ------------------WE DONT NEED ANY OF THIS--------------------------
		// String filename = file.getOriginalFilename();
		// System.out.println(filename);
		// byte[] bytes = null;
		// try {
		// bytes = file.getBytes();
		// } catch (IOException e1) {
		// // TODO Auto-generated catch block
		// e1.printStackTrace();
		// }
		//
		// File dir = new File("H:/images");
		// if (!dir.exists()) {
		// dir.mkdirs();
		// }
		// File serverFile = new File(dir.getAbsolutePath()+ File.separator +
		// filename);
		// BufferedOutputStream stream = null;
		// try {
		// stream = new BufferedOutputStream(new FileOutputStream(serverFile));
		// } catch (FileNotFoundException e1) {
		// // TODO Auto-generated catch block
		// e1.printStackTrace();
		// }
		// try {
		// stream.write(bytes);
		// stream.close();
		// } catch (IOException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// } finally {
		//
		// }

		UsersDAO udao = new UsersDAO();
		HttpSession session = request.getSession();
		User loggedUser = (User) session.getAttribute("loggedUser");
		User user = udao.getUserByUsername(loggedUser.getUsername());

		try {
			user.setImageFile(file.getBytes());
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		udao.updateUser(user);

		return "redirect:/profile";
	}

}
