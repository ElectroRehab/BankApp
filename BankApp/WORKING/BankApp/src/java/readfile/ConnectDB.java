package readfile;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectDB {
    Connection con = null;
    public void ConnectDB()throws FileNotFoundException, IOException, ClassNotFoundException, SQLException{
        // Create object
        ReadFile rf = new ReadFile();
        // Run the CSV Reader Class
        rf.ReadFile();
        // Connect to Database
        Class.forName(rf.getClassDriver());
        // Variable to be passed 
        con = DriverManager.getConnection(rf.getLink(),rf.getUser(),rf.getPass());
    }
    public Connection getConnections(){
        return con;
    }
}
