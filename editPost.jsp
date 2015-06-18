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
			<a href="home.jsp">Home</a><br>
			<a href="forum.jsp">Back to Forum</a>
		<h1></h1>
		<form action="editPost.jsp" method="post">
			<textarea placeholder="PostID" name="post"></textarea><br>
			<textarea placeholder="Edit your post..." rows="5" cols="40" name="text"></textarea><br>
			<input type="submit" name= "pro" value="Edit It!"/>

		</form><br><br>
				   
		    		<form action="editPost.jsp" method="post">
		    			<textarea placeholder="PostID" name="depost"></textarea><br>
		    			<input type="submit" name="2" value="Delete It!"/>	
		    			</form><br><br>
<% 
    try {      
        String url = "jdbc:mysql://cs336-8.cs.rutgers.edu:3306/photo";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, "csuser", "csb52177");
        Statement stmt = con.createStatement();

        String threadID = (String) request.getSession().getAttribute("tid");
       	String pid = request.getParameter ("pid");
       	session.setAttribute("pid", pid);

        String content = request.getParameter("text");
        String post = request.getParameter("post");
        String depost = request.getParameter("depost");
        String click = request.getParameter("2");

        if(content == null){
        	if(click == null){
        		
        	
      	ResultSet rs = stmt.executeQuery("select * from post where postID= '"+pid+"'");

		if(rs.next()){
			out.println("<table>");
			
			out.println("<b>PostID:</b> "+rs.getString(1)+"&nbsp;&nbsp;&nbsp;");
			out.println("Username: "+rs.getString(3)+"&nbsp;&nbsp;&nbsp;");
			out.println("Date: "+rs.getString(5)+"&nbsp;&nbsp;&nbsp;");
			out.print("<br>");
		    out.println(rs.getString(4));
					}
			}
        	if(click != null){
    		 	int i = stmt.executeUpdate("Delete from post where postID ='"+depost+"'");
    		 	response.sendRedirect("posts.jsp?tid="+threadID);
        	}
        }
       	else{
        if(content.length() != 0)
        {
		 	int i = stmt.executeUpdate("UPDATE post SET string= '"+content+"' WHERE postID= '"+post+"'");
		 	response.sendRedirect("posts.jsp?tid="+threadID);
        }
        else
        {
            out.println("All Fields Are Required!");
        }
		}	con.close();
			
	} catch (Exception e) { out.println("Error! \t:" + e); }
 %>                                                                                  
</body>
</html>