<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%> 
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<link rel="stylesheet" type="text/css" href="style/register.css">
<title>Register</title>
</head>
<body>
<%
        try {    
                 String url = "jdbc:mysql://cs336-8.cs.rutgers.edu:3306/photo";
                 Class.forName("com.mysql.jdbc.Driver");
                 Connection con = DriverManager.getConnection(url, "csuser", "csb52177");
                 Statement stmt = con.createStatement();
                 
                         String userid = request.getParameter("user_id");
                         String pwd = request.getParameter("pwd");
                         String fname = request.getParameter("fname");
                         String lname = request.getParameter("lname");
                         String email = request.getParameter("email");
                         String cpwd = request.getParameter("cpwd");
                         
                         /*Check if user confirmed password correctly*/
                         if(!pwd.equals(cpwd)) {
                        	 out.println("Passwords did not match");
           %>				<a href="hello.jsp"><input type="button" value="Main Page"/></a>
           <%             	 
                        	 return;
                         }
                         
                         ResultSet rs = stmt.executeQuery("select * from userAccounts");
                         if(rs.next()) {
                        	 if(rs.getString(1).equalsIgnoreCase(userid)) {
                        		 out.println("Username is already in use!");
                        		 %>	<a href="hello.jsp"><input type="button" value="Main Page"/></a>
                                 <%
                        		 return;
                        	 }
                        	 if(rs.getString(5).equalsIgnoreCase(email)) {
                        		 out.println("Email is already in use!");
                        		 %>	<a href="hello.jsp"><input type="button" value="Main Page"/></a>
                                 <%
                        		 return;
                        	 }
                        	 while(rs.next()) {
                        		 if(rs.getString(1).equalsIgnoreCase(userid)) {
                        			 out.println("Username is already in use!");
                        			 %>	<a href="hello.jsp"><input type="button" value="Main Page"/></a>
                        	           <%
                        			 return;
                        		 }
                        		 if(rs.getString(5).equalsIgnoreCase(email)) {
                        			 out.println("Email is already in use!");
                        			 %>	<a href="hello.jsp"><input type="button" value="Main Page"/></a>
                        	           <%
                        			 return;
                        		 }
                        	 }
                         } 
                         
                         
                         if(userid.length()!=0 && pwd.length()!=0 && fname.length()!=0 && lname.length()!=0 && email.length()!=0 && cpwd.length()!=0)
                         {
                		 	int i = stmt.executeUpdate("insert into userAccounts (username, password, fname, lname, email) values ('"+userid+"', '"+pwd+"','"+fname+"','"+lname+"','"+email+"')");
                            out.println("Successfully Registered!");
                        	session.setAttribute("userid", userid);
                        	session.setAttribute("fname", fname);
                        	session.setAttribute("lname", lname);
                        	session.setAttribute("email", email);
                        	response.sendRedirect("profile.jsp");
                         }
                         else
                         {
                             out.println("All Fields Are Required!");
                         }
                 con.close();

        
         } catch (Exception e) {    out.println("Error!: \t" + e);     }       
%>
		<h1></h1>
		<a href="hello.jsp">Main Page</a>                                                                                    
</body>
</html>