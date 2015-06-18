<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%> 
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Register</title>
</head>
<body>
<%
        try {    
                 String url = "jdbc:mysql://cs336-8.cs.rutgers.edu:3306/photo";
                 Class.forName("com.mysql.jdbc.Driver");
                 Connection con = DriverManager.getConnection(url, "csuser", "csb52177");
                 Statement stmt = con.createStatement();
                 Statement stmt2 = con.createStatement();
                 
                         String userid = request.getParameter("userid");
                         String pwd = request.getParameter("pwd");
                         String cpwd = request.getParameter("cpwd");
                         
                         /*Check if user confirmed password correctly*/
                         if(!pwd.equals(cpwd)) {
                        	 out.println("Passwords did not match");
                        	 return;
                         }
                         String checkuser = (String)request.getSession().getAttribute("userid");
                         ResultSet rs = stmt.executeQuery("select * from userAccounts");
                        
                         if(!userid.equalsIgnoreCase(checkuser)) {
                        	 out.println("Incorrect username for password change request!");
                        	return;
                         }
                         
                         if(userid.length()!=0 && pwd.length()!=0 && cpwd.length()!=0)
                         {
                        	if(rs.next()) {
                        		
                        		if(rs.getString(1).equalsIgnoreCase(userid)) {
                		 			int i = stmt2.executeUpdate("update userAccounts set password='"+pwd+"' where username='"+userid+"'");
                           			out.println("Successfully Changed Password!");
                        		
                     %>
                     			<br><br>
                     			<a href="hello.jsp">Login with your new password!</a>
                    <%
                        		}
                        		
                        	
                     
                     			while(rs.next()) {
                        			if(rs.getString(1).equalsIgnoreCase(userid)) {
                        				int i = stmt2.executeUpdate("update userAccounts set password='"+pwd+"' where username= '"+userid+"'");
                           				out.println("Successfully Changed Password!");
                        			
                 %>
                 				<br><br>
             					<a href="hello.jsp">Login with your new password!</a>
             	<%
                        			}
                        		}
                         	}
                         }
                         else
                         {
                             out.println("All Fields Are Required!");
                         }
                 		con.close();

        
         } catch (Exception e) {    out.println("Error!: \t" + e);     }       
%>                                                                                   
</body>
</html>