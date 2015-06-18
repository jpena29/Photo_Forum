<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%> 
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
		<title>Create Topic</title>
	</head>
	<body>
		<%
			try {      
	        	String url = "jdbc:mysql://cs336-8.cs.rutgers.edu:3306/photo";
	        	Class.forName("com.mysql.jdbc.Driver");
	        	Connection con = DriverManager.getConnection(url, "csuser", "csb52177");
	        	Statement stmt = con.createStatement();
	        
	        	String title = request.getParameter("topicTitle");		
				String tags = request.getParameter("topicTags");
				
				if(title.length() != 0 && tags.length() != 0) {
					int i = stmt.executeUpdate("insert into topic (title, tags, views, noofthread) values ('"+title+"', '"+tags+"')");
				 	out.println("Topic successfully created!");
				 	response.sendRedirect("topics.jsp");
                }
                else
                {
                    out.println("Both Fields Are Required!");
                }
       			con.close();
			} catch (Exception e) {out.println("Error! \t:" + e);}
		
		%>
		<h1></h1>
		<a href="admin.html">Back To Create Topic Page</a>  
	</body>
</html>
