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
<%@page import ="java.sql.*"%>
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
<%    
    ReadSessions r = new ReadSessions();
    r.getPost(request, response, session);
    
    int sqlInt = 0;
    String currentUser = request.getParameter("temp");    
    
    try{
        // Create a new clean connection to database.          
        ConnectDB dbc = new ConnectDB();
        dbc.ConnectDB();
        Connection con = dbc.getConnections();
        // Create object
        ReadSQL s = new ReadSQL();
        // Create object
        ReadTitles t = new ReadTitles();
        // String used for SQL Query
        sqlInt = 37;
        s.ReadSQL(sqlInt);
        PreparedStatement psp = con.prepareStatement(s.getSQLAll());
        psp.setString(1,currentUser);
        ResultSet rs = psp.executeQuery();    
        if (rs.next()){
            session.removeAttribute(currentUser);
            response.sendRedirect("index.html");              
        }
        else{
            session.removeAttribute(currentUser);
            response.sendRedirect("error.jsp");
        }
        psp.close();
        rs.close();
        con.close();
        }
    catch(Exception e){     
        out.println(e); 
    }   
%> 
</html>
