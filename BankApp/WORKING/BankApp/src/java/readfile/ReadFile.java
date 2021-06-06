package readfile;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;

public class ReadFile {
    // String for the JBDC Driver
    String classDriver;
    // String used for link to the Remote Database
    String link;
    // String used for username of the Remote Database
    String user;
    // String used for password to the Remote Database
    String pass;
    // String used for no reply email in the Remote Database
    String emailUser;
    // String used for no reply password in the Remote Database
    String emailPass;
    // Row Count
    int i = 0;
    // Individual Element Count
    int p = 0;
    
    public void ReadFile() throws FileNotFoundException, IOException{
        // File URL Location
        String fName = "https://dl.dropboxusercontent.com/s/m138ecyktyaqney/linkread.csv";
        // URL Object
        URL url = new URL(fName);
        // Buffered Reader and Input Sctream to read CSV File located in cloud.
        BufferedReader reader = new BufferedReader(new InputStreamReader(url.openStream()));
        // Determine what is considered a line
        String thisLine;
        // Iterate through CSV File to find the proper connection information.
        while((thisLine = reader.readLine()) != null){
            // Array to store all elements seperated by commas
            String readBlock[] = thisLine.split(",");
            // For loop to read through the array
            for(int j = 0; j < readBlock.length; j++){
                // If not Title row of the CSV file, write to variables to be 
                // passed back to JSP files. 
                if(i != 0){
                    // Class Driver information storage.
                    if(p == 4){
                        classDriver = readBlock[j];
                    }
                    // Remote Database Link information storage.
                    else if(p == 5){
                        link = readBlock[j];
                    }
                    // Remote Database Username information storage.
                    else if(p == 6){
                        user = readBlock[j];
                    }
                    // Remote Database Password information storage.
                    else if(p == 7){
                        pass = readBlock[j];
                    }
                    // Remote Database Password information storage.
                    else if(p == 10){
                        emailUser = readBlock[j];
                    }
                    // Remote Database Password information storage.
                    else if(p == 11){
                        emailPass = readBlock[j];
                    }
                    p++;
                }
                else{
                    p++;
                }
            }
                // Add new row in loop to attempt to iterate through.
                i++;
        }
    }
    public String getClassDriver(){
        return classDriver;
    }
    public String getLink(){
        return link;
    }
    public String getUser(){
        return user;
    }
    public String getPass(){
        return pass;
    }
    public String getEmailUser(){
        return emailUser;
    }
    public String getEmailPass(){
        return emailPass;
    }
}

