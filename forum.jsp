<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%> 
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
	<link rel="stylesheet" type="text/css" href="style/messageform.css">
	<title>Forum</title>
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
		
		<%}%>
		<% 
		ResultSet rs4 = stmt.executeQuery("select username from userAccounts, salesPerson where username='"+userid+"' AND username=userAccounts_username");
		if(rs4.next()) {%>
		<div id="salesperson">
			<p><a href="sales.html"><input type="button" value="Sales"/></a></p>
		</div>
		<%}
		%>
		</div>
		<div id="forum">
		<h1>Forum</h1>
		<a href="search.html"><input type="button" value="Search Forums"/></a>
		
		<%
    
		ResultSet rs2 = stmt.executeQuery("select * from topic");
		
			if(rs2.next()){
				out.println("<table>");
				out.print("<h2>Topics</h2>");				
	        	int i = 3;
	    		String title = rs2.getString(i);
	    		String topicID;
	    %>
	    <a href="threads.jsp?topicID=<%= rs2.getString(1)%>"><input type="button" value="<% out.println(title); %>"/></a> 
	    <br>
	    <% 
	             	while(rs2.next()) {
	             		title = rs2.getString(i);
	             		
	     %>
	     <a href="threads.jsp?topicID=<%= rs2.getString(1)%>"><input type="button" value="<% out.println(title); %>"/></a>
	     <br>
	     <%
	             	}
	    	
				out.println("</table>");
			}
			else
				out.println("No results found");
    		
		    con.close();

	} catch (Exception e) { out.println("Error!:" + e); }
		%>
		<br></br>
	</div>
</body>
</html>