package controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller 
public class OwnedSharesController {


	
	@RequestMapping(value="/ownedShares")
	public String sellOwnedShare(@RequestParam String cinfo,HttpServletRequest request, Model model){		
		return "redirect:/listcurrent";
	}
	
	
	
}
