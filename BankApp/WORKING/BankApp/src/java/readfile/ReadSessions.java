package readfile;

import java.io.*;
import javax.servlet.http.*;

public class ReadSessions extends HttpServlet {
    public void getPost(HttpServletRequest request, HttpServletResponse response, HttpSession session){
        try{
            ReadTitles t = new ReadTitles();
            t.ReadTitles(1);
            String uid = (String)session.getAttribute(t.getSQLTitles());
            if(uid == null){
                //response.sendRedirect("javascript:history.go(-1)");
                response.sendRedirect("notAdminAvailable.jsp");
            }
            else{
                session.setAttribute(t.getSQLTitles(), uid);
            }
        }
        catch(IOException exp){
            System.out.println(exp);
        }
    }
}