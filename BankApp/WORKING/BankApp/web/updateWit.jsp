<%@page import="readfile.ConnectDB"%>
<%@page import="readfile.ReadSessions"%>
<%@page import="readfile.ReadTitles"%>
<%@page import="readfile.ReadSQL"%>
<%@page import="readfile.ReadFile"%>
<%@page import ="java.sql.*"%>
<%@page import ="java.time.LocalDateTime"%> 
<%@page import ="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Product - Brand</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Averia+Serif+Libre">
    <link rel="stylesheet" href="assets/fonts/fontawesome-all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css">
    <link rel="stylesheet" href="assets/css/vanilla-zoom.min.css">
</head>

<body style="background: radial-gradient(black, var(--bs-blue) 50%, white);">
    
    <%
        int sqlInt = 0;
        String email = request.getParameter("temp");
        String witCur = request.getParameter("withCurrency");
        String witDes = request.getParameter("withDescription");
                                            
        try{
            //Get Current date and time   
            java.util.Date date=new java.util.Date();
            // Date and Time Check 
            Timestamp createTime =new java.sql.Timestamp(date.getTime());            
            // Create a new clean connection to database.          
            ConnectDB dbc = new ConnectDB();
            dbc.ConnectDB();
            Connection con = dbc.getConnections();
            // Create SQL Statement
            Statement st = con.createStatement();
            // Create object
            ReadSQL s = new ReadSQL();
            // Check if email is currently in use.
            sqlInt = 4;
            s.ReadSQL(sqlInt);                
            PreparedStatement ps = con.prepareStatement(s.getSQLAll());
            ps.setString(1,email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()){
                // Insert new user into bank database
                sqlInt = 5;
                s.ReadSQL(sqlInt);
                st.executeUpdate(s.getSQLAll() + "('"+email+"','"+createTime+"','"+witDes+"','-"+witCur+"')");
                response.sendRedirect("budget.jsp?temp="+email);

            }
            else{
                response.sendRedirect("budget.jsp?temp="+email);
            }
        }
        catch(Exception e){
            out.println(e); 
        }
        finally{         
        }

    %>                
</body>

</html>