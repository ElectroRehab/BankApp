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
    <title>Checking Account</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Averia+Serif+Libre">
    <link rel="stylesheet" href="assets/fonts/fontawesome-all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css">
    <link rel="stylesheet" href="assets/css/vanilla-zoom.min.css">
</head>

<body id="page-top" style="background: radial-gradient(black, var(--bs-blue) 50%, white);">
    <%
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
    <div id="wrapper">
        <div class="d-flex flex-column" id="content-wrapper">
            <div id="content">
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
                                <div class="nav-item dropdown no-arrow"><a class="dropdown-toggle nav-link" aria-expanded="false" data-bs-toggle="dropdown" href="#"><span class="d-none d-lg-inline me-2 text-gray-600 small"><%out.print(fullName);%></span><img class="border rounded-circle img-profile" src="assets/img/avatars/user.jpg"></a>
                                    <div class="dropdown-menu shadow dropdown-menu-end animated--grow-in"><a class="dropdown-item" href="#"><i class="fas fa-user fa-sm fa-fw me-2 text-gray-400"></i>&nbsp;Profile</a><a class="dropdown-item" href="#"><i class="fas fa-cogs fa-sm fa-fw me-2 text-gray-400"></i>&nbsp;Settings</a><a class="dropdown-item" href="#"><i class="fas fa-list fa-sm fa-fw me-2 text-gray-400"></i>&nbsp;Activity log</a>
                                        <div class="dropdown-divider"></div><a class="dropdown-item" href="index.html"><i class="fas fa-sign-out-alt fa-sm fa-fw me-2 text-gray-400"></i>&nbsp;Logout</a>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>
                <div class="container-fluid">
                    <h3 class="text-dark mb-4">Account Info</h3>
                    <div class="card shadow">
                        <div class="card-body" style="background: radial-gradient(var(--bs-blue), white), var(--bs-blue);font-size: 18px;font-family: Montserrat, sans-serif;text-shadow: 1px 1px 2px rgb(255,148,22);">
                            <div class="row">
                                <div class="col-md-6 text-nowrap">
                                    <div id="dataTable_length" class="dataTables_length" aria-controls="dataTable"><label class="form-label">Show&nbsp;<select class="d-inline-block form-select form-select-sm">
                                                <option value="10" selected="">10</option>
                                                <option value="25">25</option>
                                                <option value="50">50</option>
                                                <option value="100">100</option>
                                            </select>&nbsp;</label></div>
                                </div>
                                <div class="col-md-6">
                                    <div class="text-md-end dataTables_filter" id="dataTable_filter"><label class="form-label"><input type="search" class="form-control form-control-sm" aria-controls="dataTable" placeholder="Search"></label></div>
                                </div>
                            </div>
                            
                            <div class="table-responsive table mt-2" id="dataTable" role="grid" aria-describedby="dataTable_info">
                                <table class="table my-0" id="dataTable">
                                    <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Description</th>
                                            <th>Amount</th>
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
                                            <!--DATE-->
                                            <%t.ReadTitles(1);%>
                                            <td><%=rs.getString(t.getSQLTitles())%></td>
                                            <!--DESCRIPTION-->
                                            <%t.ReadTitles(2);%>
                                            <td><%=rs.getString(t.getSQLTitles()) %></td>
                                            <!--AMOUNT-->
                                            <%t.ReadTitles(3);%>
                                            <td>$ <%=(String.format("%,10.2f", rs.getDouble(t.getSQLTitles())))%></td>
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
                                    <!--TOTAL-->
                                    <td class="text-end"><strong>TOTAL:</strong></td>
                                    <td><strong>$ <%out.print(String.format("%,10.2f", total));%></strong></td>
                                    </tr>
                                    </tbody>
                                    <tfoot>
                                        <tr></tr>
                                    </tfoot>
                                </table>
                            </div>
                            <div class="row">
                                <div class="col-md-6 align-self-center">
                                    <%
                                        if(count < 10){
                                            %><p id="dataTable_info" class="dataTables_info" role="status" aria-live="polite">Showing 1 to <%out.print(count);%> of <%out.print(count);%></p><%
                                        }
                                        else{
                                            %><p id="dataTable_info" class="dataTables_info" role="status" aria-live="polite">Showing 1 to <%out.print(count);%></p><%
                                        }
                                    %>
                                </div>
                                <div class="col-md-6">
                                    <nav class="d-lg-flex justify-content-lg-end dataTables_paginate paging_simple_numbers">
                                        <ul class="pagination">
                                            <li class="page-item disabled"><a class="page-link" href="#" aria-label="Previous"><span aria-hidden="true">«</span></a></li>
                                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                                            <li class="page-item"><a class="page-link" href="#" aria-label="Next"><span aria-hidden="true">»</span></a></li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <footer class="bg-white sticky-footer">
                <div class="container my-auto">
                    <div class="text-center my-auto copyright"><span>© 2021 ElectroRehab</span></div>
                </div>
            </footer>
        </div><a class="border rounded d-inline scroll-to-top" href="#page-top"><i class="fas fa-angle-up"></i></a>
    </div>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/js/bs-init.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.js"></script>
    <script src="assets/js/vanilla-zoom.js"></script>
    <script src="assets/js/theme.js"></script>
    <script src="assets/js/theme-1.js"></script>
</body>

</html>