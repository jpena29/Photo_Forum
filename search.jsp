<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%> 
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Search</title>
</head>
<body>

<%
    try {      
        String url = "jdbc:mysql://cs336-8.cs.rutgers.edu:3306/photo";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, "csuser", "csb52177");
        Statement stmt = con.createStatement();
        Statement stm = con.createStatement();


			String userid = request.getParameter("user_id");
			String keyword = request.getParameter("keyword");
			String pkeyword = request.getParameter("postkeyword");
			String message = request.getParameter("message");

			if(userid.length() == 0 && keyword.length() == 0 && pkeyword.length() == 0 && message.length() == 0)
            {
				out.println("You Must Enter a Username or Email to Search Users!" + "<h1></h1>");
				out.println("You Must Enter a Keyword or Tag to Search Forum!" + "<h1></h1>");
				out.println("You Must Enter a Keyword to Search Message!" + "<h1></h1>");
            }
			else
			{
				if(userid.length() != 0){      		 //searching usernames or emails
          		ResultSet rs = stmt.executeQuery("select * from userAccounts where username like '"+userid+"%" +"' or email like '"+userid+"%" +"'");
		        	
				if(rs.next()){
					String username = rs.getString(1);
					out.println("<table>");
					out.print("<tr><td>Username</td>");
					out.print("<td>Email</td></tr>");
					out.print("<tr><td>");
				    %>
				    <a href="profile.jsp?username=<%= rs.getString(1)%>"><% out.println(username); %></a> 
				  
				    <%
					
					out.print("&nbsp;&nbsp;&nbsp;&nbsp"+ "</td>");
					out.print("<td>" + rs.getString(5) + "</td></tr>");
				
					while(rs.next()){
						out.print("<tr><td>");
					    %>
					    <a href="profile.jsp?username=<%= rs.getString(1)%>"><% out.println(username); %></a> 
					  
					    <%
						
						out.print("&nbsp;&nbsp;&nbsp;&nbsp"+ "</td>");
						out.print("<td>" + rs.getString(5) + "</td></tr>");
					}
					out.println("</table>");
				}
				else
					out.println("No results found");
			}
    				
			if(keyword.length() != 0)	//searching inside forum: thread
			{
          		ResultSet rss = stmt.executeQuery("select threadID, title, tags from thread where match(title, tags) against('"+keyword+"' in boolean mode)");
		        	
				if(rss.next()){
					out.println("<table>");
					out.print("<tr><td>Title</td>");
					out.print("<td>Tags</td></tr>");
					out.print("<tr><td>");
				    %>
				    <a href="posts.jsp?tid=<%= rss.getString(1)%>"><% out.println(rss.getString(2)); %></a> 
				  
				    <%
					
					out.print("&nbsp;&nbsp;&nbsp;&nbsp"+ "</td>");
					out.print("<td>" + rss.getString(3) + "</td></tr>");
				
					while(rss.next()){
						out.print("<tr><td>");
					    %>
					    <a href="posts.jsp?tid=<%= rss.getString(1)%>"><% out.println(rss.getString(2)); %></a> 
					  
					    <%
						
						out.print("&nbsp;&nbsp;&nbsp;&nbsp"+ "</td>");
						out.print("<td>" + rss.getString(3) + "</td></tr>");
					}
				}
				else
					out.println("No results found");
    			}
			
			if(pkeyword.length() != 0)	//searching inside forum: post
			{
          		ResultSet rs5 = stmt.executeQuery("select threadID, string from post where match(string) against('"+pkeyword+"' in boolean mode)");
          		if(rs5.next()){
          		ResultSet rss = stm.executeQuery("select threadID, title, tags from thread where threadID='"+rs5.getString(1)+"'");
				if(rss.next()){
					out.println("<table>");
					out.print("<tr><td>Title</td>");
					out.print("<td>Tag</td></tr>");
					out.print("<tr><td>");
				    %>
				    <a href="posts.jsp?tid=<%= rss.getString(1)%>"><% out.println(rss.getString(2)); %></a> 
				  
				    <%
					
					out.print("&nbsp;&nbsp;&nbsp;&nbsp"+ "</td>");
					out.print("<td>" + rss.getString(3) + "</td></tr>");
				
					while(rss.next()){
						out.print("<tr><td>");
					    %>
					    <a href="posts.jsp?tid=<%= rss.getString(1)%>"><% out.println(rss.getString(2)); %></a> 
					  
					    <%
						
						out.print("&nbsp;&nbsp;&nbsp;&nbsp"+ "</td>");
						out.print("<td>" + rss.getString(3) + "</td></tr>");
					}
				}
          		}
				else
					out.println("No results found");
    			}
			
			if(message.length() != 0) //searching inside message
			{
		        Object user = request.getSession().getAttribute("userid");
				ResultSet rs3 = stmt.executeQuery("select subject, send_username, msgID from message where (receive_username='"+user+"') and match(subject,msgbody) against('"+message+"' in boolean mode)");
	        	
				if(rs3.next()){
					out.println("<table>");
					out.print("<tr><td>Subject</td>");
					out.print("<td>Sender</td></tr>");
					out.print("<tr><td>");
				    %>
				    <a href="openmsg.jsp?msgId=<%=rs3.getString(3)%>"><% out.println(rs3.getString(1)); %></a> 
				  
				    <%
					
					out.print("&nbsp;&nbsp;&nbsp;&nbsp"+ "</td>");
					out.print("<td>" + rs3.getString(2) + "</td></tr>");
				
					while(rs3.next()){
						out.print("<tr><td>");
					    %>
					    <a href="openmsg.jsp?msgId=<%=rs3.getString(3)%>"><% out.println(rs3.getString(1)); %></a> 
					  
					    <%
						
						out.print("&nbsp;&nbsp;&nbsp;&nbsp"+ "</td>");
						out.print("<td>" + rs3.getString(2) + "</td></tr>");
					}
			}
			else
				out.println("No results found");
			}
  		}

		con.close();

	} catch (Exception e) { out.println("Error!:" + e); }
%>
		<h1></h1>
		<a href="search.html">Back to Search</a>
</body>
</html>