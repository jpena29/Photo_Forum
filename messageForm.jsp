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
		<div id="logout">
			<a href="logout.jsp"><input type="button" value="Logout"></a>
		</div>
		<div id="menu">
			<h2>Menu</h2>
			<div id="home">
				<p><a href="home.jsp"><input type="button" value="Home"/></a></p>
			</div>
			<div id="message">
				<p><a href="messages.jsp"><input type="button" value="Messages"/></a>
			</div>
		<%
		try {
			
			
			String url = "jdbc:mysql://cs336-8.cs.rutgers.edu:3306/photo";
        	Class.forName("com.mysql.jdbc.Driver");
        	Connection con = DriverManager.getConnection(url, "csuser", "csb52177"); 
        	Statement stmt = con.createStatement();
       		String userid = (String)request.getSession().getAttribute("userid");
		
			ResultSet rs = stmt.executeQuery("select username from userAccounts, adminmoderator where username = '"+userid+"' AND username=userAccounts_username");	
			if(rs.next()){
		
		%>
			<div id="admin">
				<p><a href="admin.html"><input type="button" value="Admin"></a></p>
			</div>
		
		<%}
			ResultSet rs2 = stmt.executeQuery("select username from userAccounts, salesPerson where username='"+userid+"' AND username=userAccounts_username");
			if(rs2.next()) {%>
			<div id="salesperson">
				<p><a href="sales.html"><input type="button" value="Sales"/></a></p>
			</div>
		<%} 
		%>
		<% con.close();
		
		}
		 catch (Exception e) { out.println("Error! \t:" + e); }%>
		 
		</div>
		<div id="msgform">
			<h1>Send Message</h1>
			<form action="sendmessage.jsp" method="post">
				<input placeholder="To" type="text" name="recipient"><br>
				<input placeholder="Subject" type="text" name="subject"/><br>
				<textarea placeholder="Message" rows="10" cols="40" name="message"></textarea><br>
				<input id="submit" type="submit" value="Send"/>
			</form>
		</div>
	</body>
</html>