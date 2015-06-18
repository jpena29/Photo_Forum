<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%> 
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Post</title>
</head>
<body>
<%
    try {      
        String url = "jdbc:mysql://cs336-8.cs.rutgers.edu:3306/photo";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, "csuser", "csb52177");
        Statement stmt = con.createStatement();
        
        String content = request.getParameter("post");
        Object userid = request.getSession().getAttribute("userid");
        int likes = 0;
        int dislikes = 0;
        int check = -1;
        String threadId = (String) request.getSession().getAttribute("tid");
        
        if(content.length()!=0)
        {
		 	int i = stmt.executeUpdate("insert into post (threadID, userAccounts_username, string, likes, dislikes, checkFlag) values ('"+threadId+"', '"+userid+"', '"+content+"', '"+likes+"', '"+dislikes+"', '"+check+"')");
		 	response.sendRedirect("posts.jsp?tid="+threadId);
        }
        else
        {
            out.println("All Fields Are Required!");
        }
			con.close();
			

	} catch (Exception e) { out.println("Error! \t:" + e); }
%>          
		<h1></h1>
		<a href="cpost.html">Back Page</a>                                                                           
</body>
</html>