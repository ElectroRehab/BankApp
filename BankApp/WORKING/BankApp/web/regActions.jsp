
<%@page import="readfile.ConnectDB"%>
<%@page import="readfile.ReadSessions"%>
<%@page import="readfile.ReadTitles"%>
<%@page import="readfile.ReadSQL"%>
<%@page import="readfile.ReadFile"%>
<%@page import="java.security.NoSuchAlgorithmException"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.math.BigInteger"%>
<%@page import="readfile.HashSHA512Encryption"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*,java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
        <title>Login - ElectroRehab</title>
        <meta name="description" content="Created by Jon King">
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Averia+Serif+Libre">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css">
        <link rel="stylesheet" href="assets/css/vanilla-zoom.min.css">
    </head>
    <body>
    <%
        int sqlInt = 0;
        HashSHA512Encryption hashText = new HashSHA512Encryption();
        //Get parameters from login form
        String fName = request.getParameter("fname");
        String lName = request.getParameter("lname");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String email = request.getParameter("email");    
        String passID = request.getParameter("passID");
        if(email == "" || passID == ""){
            response.sendRedirect("error.html");
        }
        else{
            //Make changes to the connection string(database name, user/password)
            //Make changes to the String query(change table name)
            hashText.hashText = "";
            hashText.setHashText(passID);
            passID = hashText.getHashText();
            try{            
                // Create a new clean connection to database.          
                ConnectDB dbc = new ConnectDB();
                dbc.ConnectDB();
                Connection con = dbc.getConnections();
                // Create SQL Statement
                Statement st = con.createStatement();
                // Create object
                ReadSQL s = new ReadSQL();
                // Create object
                ReadTitles t = new ReadTitles();
                // Check if email is currently in use.
                sqlInt = 2;
                s.ReadSQL(sqlInt);                
                PreparedStatement ps = con.prepareStatement(s.getSQLAll());
                ps.setString(1,email);
                ResultSet rs = ps.executeQuery();
                
                if (rs.next()){
                    response.sendRedirect("exists.html");
                }
                else{
                    // Insert new user into bank database
                    sqlInt = 1;
                    s.ReadSQL(sqlInt);
                    // Add registration  
                    st.executeUpdate(s.getSQLAll() + "('"+fName+"','"+lName+"','"+address+"','"+city+"','"+state+"','"+email+"','"+passID+"')");
                    response.sendRedirect("congrats.html");
                }
            }
            catch(Exception e){
                out.println(e); 
            }
        }
    %>
    </body>
</html>
