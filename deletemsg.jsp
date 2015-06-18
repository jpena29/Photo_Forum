<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%> 
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
		<link rel="stylesheet" type="text/css" href="style/messageform.css">
		<title>Send Message</title>
	</head>
	<body>
	
	<%
		try {
			String url = "jdbc:mysql://cs336-8.cs.rutgers.edu:3306/photo";
        	Class.forName("com.mysql.jdbc.Driver");
        	Connection con = DriverManager.getConnection(url, "csuser", "csb52177"); 
        	Statement stmt = con.createStatement();
       		String userid = (String)request.getSession().getAttribute("userid");
       		
       		String msgId = (String) request.getSession().getAttribute("msgId");
		
			ResultSet rs = stmt.executeQuery("select * from message where msgID = '"+msgId+"'");	
			if(rs.next()){
				int i = stmt.executeUpdate("delete from message where msgID='"+msgId+"'");
				response.sendRedirect("receivemessage.jsp");
			}
			con.close();
		} catch (Exception e) {out.println("Error! \t:" + e);}
				
				 %>
	</body>
</html>