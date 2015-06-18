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
        String threadID = (String) request.getSession().getAttribute("tid");
       	String pid = request.getParameter ("pid");
       	session.setAttribute("pid", pid);
       	int count;
       	out.print(threadID + pid);
       	
       	ResultSet rs3 = stmt.executeQuery("select likes from post where postID= '"+pid+"'");
       	if(rs3.next()) {
            count = rs3.getInt("likes");
            count++;
			stmt.executeUpdate("update post set likes='"+count+"' where postID = '"+pid+"'");
		 	response.sendRedirect("posts.jsp?tid="+threadID);
       	}

       	} catch (Exception e) { out.println("Error! \t:" + e); }
 %>                                                                                  
</body>
</html>