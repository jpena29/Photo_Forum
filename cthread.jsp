<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%> 
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>register</title>
</head>
<body>
<%
    try {      
        String url = "jdbc:mysql://cs336-8.cs.rutgers.edu:3306/photo";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, "csuser", "csb52177");
        Statement stmt = con.createStatement();
        String title = request.getParameter("title");
        String content = request.getParameter("thread");
        String tags = request.getParameter("tags");
        Object userid = request.getSession().getAttribute("userid");
        int likes = 0;
        int dislikes = 0;
        int views = 0;
        String topicId = (String) request.getSession().getAttribute("topicID");
        
        
        if(title.length()!=0 && content.length()!=0)
        {
		 	int i = stmt.executeUpdate("insert into thread(topicID, userAccounts_username, title, content, tags, likes, dislikes, views) values ('"+topicId+"', '"+userid+"', '"+title+"', '"+content+"', '"+tags+"', '"+likes+"', '"+dislikes+"', '"+views+"')");
		 	response.sendRedirect("cthread.html");
        }
        else
        {
            out.println("All Fields Are Required!");
        }
			con.close();
			

	} catch (Exception e) { out.println("Error! \t:" + e); }
%>          
		<h1></h1>
		<a href="cthread.html">Back Page</a>                                                                           
</body>
</html>
