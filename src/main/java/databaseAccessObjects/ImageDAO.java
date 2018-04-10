package databaseAccessObjects;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.apache.derby.impl.tools.sysinfo.Main;
import org.springframework.web.multipart.MultipartFile;


//This is not really a DAO has no connections to the actual database
public class ImageDAO {

	//Don't need this method anymore because can get the bytes directly from file
	public byte[] readImageOldWay(File file) throws IOException
	{
	  Logger.getLogger(Main.class.getName()).log(Level.INFO, "[Open File] " + file.getAbsolutePath());
	  InputStream is = new FileInputStream(file);
	  // Get the size of the file
	  long length = file.length();
	  // You cannot create an array using a long type.
	  // It needs to be an int type.
	  // Before converting to an int type, check
	  // to ensure that file is not larger than Integer.MAX_VALUE.
	  if (length > Integer.MAX_VALUE)
	  {
	    // File is too large
	  }
	  // Create the byte array to hold the data
	  byte[] bytes = new byte[(int) length];
	  // Read in the bytes
	  int offset = 0;
	  int numRead = 0;
	  while (offset < bytes.length && (numRead = is.read(bytes, offset, bytes.length - offset)) >= 0)
	  {
	    offset += numRead;
	  }
	  // Ensure all the bytes have been read in
	  if (offset < bytes.length)
	  {
	    throw new IOException("Could not completely read file " + file.getName());
	  }
	  // Close the input stream and return bytes
	  is.close();
	  return bytes;
	}
	
	//------this method wont work because of admin rights------
	public File convert(MultipartFile file) throws IOException
	{    
	    File convFile = new File(file.getOriginalFilename());
	    convFile.createNewFile(); 
	    FileOutputStream fos = new FileOutputStream(convFile); 
	    fos.write(file.getBytes());
	    fos.close(); 
	    return convFile;
	}
	//------this method wont work because of admin rights------
	public File multipartToFile(MultipartFile multipart) throws IllegalStateException, IOException 
	{
	    File convFile = new File( multipart.getOriginalFilename());
	    multipart.transferTo(convFile);
	    return convFile;
	}
	
	
}
