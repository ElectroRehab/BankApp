<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="readfile.ConnectDB"%>
<%@page import="readfile.ReadSessions"%>
<%@page import="readfile.ReadTitles"%>
<%@page import="readfile.ReadSQL"%>
<%@page import="readfile.ReadFile"%>
<%@page import="java.security.NoSuchAlgorithmException"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.math.BigInteger"%>
<%@page import="readfile.HashSHA512Encryption"%>
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
        String email = request.getParameter("email");    
        String pass = request.getParameter("passID");
        if(email == "" || pass == ""){
            response.sendRedirect("error.html");
        }
        else{
            //Make changes to the connection string(database name, user/password)
            //Make changes to the String query(change table name)
            hashText.hashText = "";
            hashText.setHashText(pass);
            pass = hashText.getHashText();
            try{            
                // Create a new clean connection to database.          
                ConnectDB dbc = new ConnectDB();
                dbc.ConnectDB();
                Connection con = dbc.getConnections();
                // Create object
                ReadSQL s = new ReadSQL();
                // Create object
                ReadTitles t = new ReadTitles();
                // Create a Prepared Statement to run query from database.
                sqlInt = 3;
                s.ReadSQL(sqlInt);
                PreparedStatement ps = con.prepareStatement(s.getSQLAll());
                // Set Strings to locations in the database.
                ps.setString(1,email);
                ps.setString(2,pass);
                // Iterate through database to set new fields
                ResultSet rs = ps.executeQuery();
                if(rs.next()){
                    // Go to user's info and pass email to next page
                    response.sendRedirect("checking.jsp?temp="+email);
                }     
                else{
                    // Incorrect Response
                    response.sendRedirect("incorrect.html");
                }
                // Close all recently opened connections. 
                ps.close();
                rs.close();
                con.close();
            }
            catch(Exception e){     
                out.println(e); 
            } 

        }
    %>
    </body>
</html>
