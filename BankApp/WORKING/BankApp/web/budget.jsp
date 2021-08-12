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
        ReadSessions r = new ReadSessions();
        r.getPost(request, response, session);
        int count = 0;
        int sqlInt = 0;
        String email = request.getParameter("temp");
        String fName = "";
        String lName = "";
        String fullName = "";   
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
                sqlInt = 6;
                s.ReadSQL(sqlInt);
                PreparedStatement ps = con.prepareStatement(s.getSQLAll());
                // Set Strings to locations in the database.
                ps.setString(1,email);
                // Iterate through database to set new fields
                ResultSet rs = ps.executeQuery();
                if(rs.next()){
                    // Get user's First Name
                    sqlInt = 4;
                    t.ReadTitles(sqlInt);
                    fName = rs.getString(t.getSQLTitles());
                    // Get user's Last Name
                    sqlInt = 5;
                    t.ReadTitles(sqlInt);
                    lName = rs.getString(t.getSQLTitles());
                    // Combine user's First and Last name
                    fullName = fName + " " + lName;
                }     
                else{
                    // Incorrect Response
                    fullName = "ERROR";
                }
                // Close all recently opened connections. 
                ps.close();
                rs.close();
                con.close();
            }
            catch(Exception e){     
                out.println(e); 
                // Incorrect Response
                fullName = "ERROR";
            }
    %>
    
    <nav class="navbar navbar-light navbar-expand bg-white shadow mb-4 topbar static-top" style="background: linear-gradient(var(--bs-blue), white);">
        <div class="container-fluid"><button class="btn btn-link d-md-none rounded-circle me-3" id="sidebarToggleTop" type="button"><i class="fas fa-bars"></i></button>
            <ul class="navbar-nav flex-nowrap ms-auto">
                <li class="nav-item dropdown d-sm-none no-arrow"><a class="dropdown-toggle nav-link" aria-expanded="false" data-bs-toggle="dropdown" href="#"><i class="fas fa-search"></i></a>
                    <div class="dropdown-menu dropdown-menu-end p-3 animated--grow-in" aria-labelledby="searchDropdown">
                        <form class="me-auto navbar-search w-100">
                            <div class="input-group"><input class="bg-light form-control border-0 small" type="text" placeholder="Search for ...">
                                <div class="input-group-append"><button class="btn btn-primary py-0" type="button"><i class="fas fa-search"></i></button></div>
                            </div>
                        </form>
                    </div>
                </li>
                <li class="nav-item dropdown no-arrow mx-1">
                    <div class="nav-item dropdown no-arrow"><a class="dropdown-toggle nav-link" aria-expanded="false" data-bs-toggle="dropdown" href="#"><span class="badge bg-danger badge-counter">1+</span><i class="fas fa-bell fa-fw"></i></a>
                        <div class="dropdown-menu dropdown-menu-end dropdown-list animated--grow-in">
                            <h6 class="dropdown-header">alerts center</h6><a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
                        </div>
                    </div>
                </li>
                <li class="nav-item dropdown no-arrow mx-1">
                    <div class="nav-item dropdown no-arrow"><a class="dropdown-toggle nav-link" aria-expanded="false" data-bs-toggle="dropdown" href="#"><span class="badge bg-danger badge-counter">1</span><i class="fas fa-envelope fa-fw"></i></a>
                        <div class="dropdown-menu dropdown-menu-end dropdown-list animated--grow-in">
                            <h6 class="dropdown-header">alerts center</h6><a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
                        </div>
                    </div>
                    <div class="shadow dropdown-list dropdown-menu dropdown-menu-end" aria-labelledby="alertsDropdown"></div>
                </li>
                <div class="d-none d-sm-block topbar-divider"></div>
                <li class="nav-item dropdown no-arrow">
                    <div class="nav-item dropdown no-arrow"><a class="dropdown-toggle nav-link" aria-expanded="false" data-bs-toggle="dropdown" href="#"><span class="d-none d-lg-inline me-2 text-gray-600 small">Jon King</span><img class="border rounded-circle img-profile" src="avatars/avatar1.jpeg"></a>
                        <div class="dropdown-menu shadow dropdown-menu-end animated--grow-in"><a class="dropdown-item" href="#"><i class="fas fa-user fa-sm fa-fw me-2 text-gray-400"></i>&nbsp;Profile</a><a class="dropdown-item" href="#"><i class="fas fa-cogs fa-sm fa-fw me-2 text-gray-400"></i>&nbsp;Settings</a><a class="dropdown-item" href="#"><i class="fas fa-list fa-sm fa-fw me-2 text-gray-400"></i>&nbsp;Activity log</a>
                            <div class="dropdown-divider"></div><a class="dropdown-item" href="logout.jsp<%out.print("?temp="+email);%>"><i class="fas fa-sign-out-alt fa-sm fa-fw me-2 text-gray-400"></i>&nbsp;Logout</a>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </nav>
    <main class="page product-page">
        <section class="clean-block clean-product dark" style="background: radial-gradient(black, var(--bs-blue) 50%, white);">
            <div class="container" style="background: radial-gradient(black, var(--bs-blue) 50%, white);">
                <div class="block-content" style="background: radial-gradient(black, var(--bs-blue) 50%, white);">
                    <div class="product-info">
                        <div class="row">
                            <div class="col-md-6" style="border-style: inset;">
                                <form action="updateDep.jsp<%out.print("?temp="+email);%>" method="post">
                                <div class="text-md-end d-xxl-flex justify-content-xxl-start dataTables_filter" id="dataTable_filter-3" style="width: 450px;margin-bottom: 0px;margin-left: 120px;"><label class="form-label d-xxl-flex justify-content-xxl-center align-items-xxl-center dataTables_info" role="status" aria-live="polite" style="color: rgb(0,0,0);font-weight: bold;font-style: italic;font-size: 20px;text-shadow: 1px 2px 3px rgb(255,163,77);margin-bottom: 0px;width: 225px;margin-left: 0px;">Amount&nbsp;</label><label class="form-label d-xxl-flex justify-content-xxl-center align-items-xxl-center dataTables_info" role="status" aria-live="polite" style="color: rgb(0,0,0);font-weight: bold;font-style: italic;font-size: 20px;text-shadow: 1px 2px 3px rgb(255,163,77);margin-bottom: 0px;width: 225px;margin-left: 0px;">Description:&nbsp;</label></div>
                                <div class="text-md-end dataTables_filter" id="dataTable_filter" style="width: 575px;margin-bottom: 20px;"><label class="form-label dataTables_info" role="status" aria-live="polite" style="color: rgb(0,0,0);font-weight: bold;font-style: italic;font-size: 20px;text-shadow: 1px 2px 3px rgb(255,163,77);">Deposits: $</label><input type="text" name="depoCurrency" style="border-style: groove;padding-right: 2px;margin-right: 10px;"><input type="text" name="depoDescription" style="border-style: groove;padding-right: 2px;margin-right: 10px;"><button class="btn btn-primary bg-primary bg-gradient border rounded-pill border-dark shadow-lg" data-bss-hover-animate="jello" type="submit" style="padding-right: 5px;padding-left: 5px;width: 100px;text-shadow: 1px 2px 3px rgb(255,163,77);font-style: italic;">Deposit</button></div>
                                </form>
                                <form action="updateWit.jsp<%out.print("?temp="+email);%>" method="post">
                                <div class="text-md-end d-xxl-flex justify-content-xxl-start dataTables_filter" id="dataTable_filter-4" style="width: 450px;margin-bottom: 0px;margin-left: 120px;"><label class="form-label d-xxl-flex justify-content-xxl-center align-items-xxl-center dataTables_info" role="status" aria-live="polite" style="color: rgb(0,0,0);font-weight: bold;font-style: italic;font-size: 20px;text-shadow: 1px 2px 3px rgb(255,163,77);margin-bottom: 0px;width: 225px;margin-left: 0px;">Amount&nbsp;</label><label class="form-label d-xxl-flex justify-content-xxl-center align-items-xxl-center dataTables_info" role="status" aria-live="polite" style="color: rgb(0,0,0);font-weight: bold;font-style: italic;font-size: 20px;text-shadow: 1px 2px 3px rgb(255,163,77);margin-bottom: 0px;width: 225px;margin-left: 0px;">Description:&nbsp;</label></div>
                                <div class="text-md-end dataTables_filter" id="dataTable_filter-1" style="width: 575px;margin-bottom: 20px;"><label class="form-label dataTables_info" role="status" aria-live="polite" style="color: rgb(0,0,0);font-weight: bold;font-style: italic;font-size: 20px;text-shadow: 1px 2px 3px rgb(255,163,77);">Bills: $</label><input type="text" name="withCurrency" style="border-style: groove;padding-right: 2px;margin-right: 10px;"><input type="text" name="withDescription" style="border-style: groove;padding-right: 2px;margin-right: 10px;"><button class="btn btn-primary bg-primary bg-gradient border rounded-pill border-dark shadow-lg" data-bss-hover-animate="jello" type="submit" style="padding-right: 5px;padding-left: 5px;width: 100px;text-shadow: 1px 2px 3px rgb(255,163,77);font-style: italic;">Withdraw</button></div>
                                </form>
                            </div>
                            <div class="col" style="font-weight: bold;border-style: inset;">
                                <div class="table-responsive table mt-2" id="dataTable-1" role="grid" aria-describedby="dataTable_info">
                                    <table class="table my-0" id="dataTable">
                                        <thead>
                                            <tr>
                                                <th style="color: rgb(0,0,0);font-size: 20px;font-weight: bold;font-style: italic;text-shadow: 1px 2px 3px rgb(255,163,77);">Remove</th>
                                                <th style="color: rgb(0,0,0);font-size: 20px;font-weight: bold;font-style: italic;text-shadow: 1px 2px 3px rgb(255,163,77);">Date</th>
                                                <th style="text-shadow: 1px 2px 3px rgb(255,163,77);color: rgb(0,0,0);font-size: 20px;font-weight: bold;font-style: italic;">Description</th>
                                                <th style="text-shadow: 1px 2px 3px rgb(255,163,77);color: rgb(0,0,0);font-size: 20px;font-weight: bold;font-style: italic;">Amount</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr></tr>
                                            
                                            <%
                                                double total = 0.00;
                                                try{
                                                    java.util.Date date=new java.util.Date();
                                                    // Create a new clean connection to database.          
                                                    ConnectDB dbc = new ConnectDB();
                                                    dbc.ConnectDB();
                                                    Connection con = dbc.getConnections();
                                                    // Create object
                                                    ReadSQL s = new ReadSQL();
                                                    // Create object
                                                    ReadTitles t = new ReadTitles();
                                                    // Create a Prepared Statement to run query from database.
                                                    sqlInt = 4;
                                                    s.ReadSQL(sqlInt);
                                                    PreparedStatement ps = con.prepareStatement(s.getSQLAll());
                                                    // Set Strings to locations in the database.
                                                    ps.setString(1,email);
                                                    // Iterate through database to set new fields
                                                    ResultSet rs = ps.executeQuery();
                                                    while(rs.next()){
                                                        count++;
                                                        t.ReadTitles(3);
                                                        total = total + rs.getDouble(t.getSQLTitles());
                                        %>
                                            <tr>
                                                <!--REMOVE SECTION-->
                                                <%t.ReadTitles(14);%>
                                                
                                                
                                                <td style="color: rgb(255,255,255);font-weight: bold;text-shadow: 1px 2px 3px rgb(255,163,77);">
                                                    <form action="updateItem.jsp<%out.print("?temp="+email);%>" method="post">
                                                    <button class="btn btn-primary bg-primary bg-gradient border rounded-pill border-dark shadow-lg" data-bss-hover-animate="jello" type="submit" name="slot" value="<%=rs.getString(t.getSQLTitles())%>" style="padding-right: 5px;padding-left: 5px;width: 100px;text-shadow: 1px 2px 3px rgb(255,163,77);font-style: italic;">Remove</button>
                                                    </form>
                                                </td>
                                                <!--DATE-->
                                                <%t.ReadTitles(1);%>
                                                <td style="color: rgb(255,255,255);font-weight: bold;text-shadow: 1px 2px 3px rgb(255,163,77);"><%=rs.getString(t.getSQLTitles())%></td>
                                                <!--DESCRIPTION-->
                                                <%t.ReadTitles(2);%>
                                                <td style="color: rgb(255,255,255);font-weight: bold;text-shadow: 1px 2px 3px rgb(255,163,77);"><%=rs.getString(t.getSQLTitles()) %></td>
                                                <!--AMOUNT-->
                                                <%t.ReadTitles(3);%>
                                                <td style="color: rgb(255,255,255);font-weight: bold;text-shadow: 1px 2px 3px rgb(255,163,77);">$ <%=(String.format("%,10.2f", rs.getDouble(t.getSQLTitles())))%></td>
                                            </tr>
                                            <%
                                                   }
                                                }
                                                catch(Exception e){
                                                    out.print(e.getMessage());%><br><%
                                                }
                                                finally{         
                                                }
                                            %>
                                            <tr>
                                                <td></td>
                                                <td class="text-end" style="color: rgb(0,0,0);font-size: 20px;font-weight: bold;font-style: italic;text-shadow: 1px 2px 3px rgb(255,163,77);"><strong>Total:</strong><br></td>
                                                <td style="color: rgb(255,255,255);text-shadow: 1px 2px 3px rgb(255,163,77);">$ <%out.print(String.format("%,10.2f", total));%></td>
                                            </tr>
                                        </tbody>
                                        <tfoot>
                                            <tr></tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
    <div class="footer-copyright" style="background: radial-gradient(black, var(--bs-blue) 50%, white);">
        <p class="d-xxl-flex justify-content-xxl-center align-items-xxl-center" style="color: rgb(255,255,255);font-weight: bold;text-shadow: 1px 2px 3px rgb(255,163,77);">© 2021 ElectroRehab<br></p>
    </div>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/js/bs-init.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.js"></script>
    <script src="assets/js/vanilla-zoom.js"></script>
    <script src="assets/js/theme.js"></script>
    <script src="assets/js/theme-1.js"></script>
</body>

</html>