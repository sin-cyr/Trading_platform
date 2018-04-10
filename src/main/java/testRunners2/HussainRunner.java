package testRunners2;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import databaseAccessObjects.UsersDAO;
import databaseAccessObjects.ImageDAO;
import databaseEntities.User;

public class HussainRunner {

	public static void main(String[] args) {
		UsersDAO udao = new UsersDAO();
		User user = udao.getUserByUsername("Tad");
		
		File file = new File("C:/Users/hussain.adam/Downloads/NewLogo.jpg");
		
		
		ImageDAO imdao = new ImageDAO();
		try {
			user.setImageFile(imdao.readImageOldWay(file));
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		udao.updateUser(user);
		
		
		
		
		
			
			
		}

	}
