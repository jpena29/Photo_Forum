<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%> 
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>login</title>
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
			
			if(userid.length()==0 && pwd.length()==0)
            {
				out.println("You Must Enter Username and Password!");
            }
			else
			{
			
          	ResultSet rs = stmt.executeQuery("select * from userAccounts where username = '"+userid+"'");
		
    		if(rs.next()) {
                if(rs.getString(2).equals(pwd))
                {
                	out.println("Logged In Successfully! Welcome \t"+userid);
                	
                	
                	session.setAttribute("userid", userid);
                	session.setAttribute("fname", rs.getString(3));
                	session.setAttribute("lname", rs.getString(4));
                	session.setAttribute("email", rs.getString(5));
                	response.sendRedirect("profile.jsp");
              	} 
                else 
              	{
                	out.println("Invalid Password Try Again!");
                }
          	}
    		else
    		{
    			out.println("Invalid Username Try Again!");
    		}
			}
		    con.close();

	} catch (Exception e) { out.println("Error! \t:" + e); }
%>
		<h1></h1>
		<a href="hello.jsp">Main Page</a> 
</body>
</html>