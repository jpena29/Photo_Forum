<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%> 
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Post</title>
</head>
<body>
			<a href="home.jsp">Home</a><br>
			<a href="forum.jsp">Back to Forum</a><br><br>
		<% 
       	
       	String threadID = request.getParameter("tid");
       	session.setAttribute("tid", threadID);
        String url = "jdbc:mysql://cs336-8.cs.rutgers.edu:3306/photo";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, "csuser", "csb52177");
   		String userid = (String)request.getSession().getAttribute("userid");
		
try {      
		int count;
        Statement stmt = con.createStatement();
        Statement stm = con.createStatement();
        Statement st = con.createStatement();

       	ResultSet rs3 = stmt.executeQuery("select * from thread where thread.threadID= '"+threadID+"'");
       	if(rs3.next()) {
       		out.print("<h2>" + rs3.getString(4) + " </h2>");
       		out.print("<h4>" + rs3.getString(5) + "</h4><br>");
            count = rs3.getInt("views");
            count++;
			stmt.executeUpdate("update thread set views='"+count+"' where threadID = '"+threadID+"'"); 
       	}
			
       	int i = 1; //number of post to be printed
       	
          	ResultSet rs = stmt.executeQuery("select * from post where threadID= '"+threadID+"'");

			if(rs.next()){
				String pid = rs.getString(1);
			    String usern = rs.getString(3);
				out.println("<table>");
				
				out.println("Post #: "+i+"&nbsp;&nbsp;&nbsp;");
				out.println("Username: "+rs.getString(3)+"&nbsp;&nbsp;&nbsp;");
				out.println("Date: "+rs.getString(5)+"&nbsp;&nbsp;&nbsp;");

				%>
						<a href="like.jsp?pid=<%= rs.getString(1)%>"><% out.println("Like:"); %></a>				
				<%		
				out.println(rs.getString(6)+"&nbsp;&nbsp;&nbsp;");
				%>
						<a href="likedis.jsp?pid=<%= rs.getString(1)%>"><% out.println("Dislike:"); %></a>				
				<%
				out.println(rs.getString(7)+"&nbsp;&nbsp;&nbsp;");
				out.print("<br>");
				i++;
			    out.println(rs.getString(4));

			    ResultSet rs5 = st.executeQuery("select userAccounts_username from adminmoderator where userAccounts_username='"+userid+"'");
				if(rs5.next()){
			    	if(rs5.getString(1).equals(userid))
			   		{%>
						<a href="editPost.jsp?pid=<%= rs.getString(1)%>"><% out.println("Edit"); %></a>
					<%}%>
			<%}			%>	<br><br><%
				
				while(rs.next()){
		
					out.println("Post #: "+i+"&nbsp;&nbsp;&nbsp;");
					out.println("Username: "+rs.getString(3)+"&nbsp;&nbsp;&nbsp;");
					out.println("Date: "+rs.getString(5)+"&nbsp;&nbsp;&nbsp;");
					%>
					<a href="like.jsp?pid=<%= rs.getString(1)%>"><% out.println("Like:"); %></a>				
			<%		
			out.println(rs.getString(6)+"&nbsp;&nbsp;&nbsp;");
			%>
					<a href="likedis.jsp?pid=<%= rs.getString(1)%>"><% out.println("Dislike:"); %></a>				
			<%
			out.println(rs.getString(7)+"&nbsp;&nbsp;&nbsp;");
			out.print("<br>");
					i++;
					out.println(rs.getString(4));
					ResultSet rs6 = st.executeQuery("select userAccounts_username from adminmoderator where userAccounts_username='"+userid+"'");
					if(rs6.next()){
				    	if(rs6.getString(1).equals(userid))
				   		{%>
							<a href="editPost.jsp?pid=<%= rs.getString(1)%>"><% out.println("Edit"); %></a>
						<%}%>
					
					<%}		%>	<br><br><%
				}
				out.println("</table>");
			} 
			else
				out.println("No posts found");
    	%>	
			<br></br>
			
		<form action="cpost.jsp" method="post">
			<textarea placeholder="Write your post..." rows="5" cols="40" name="post"></textarea><br>
			<input type="submit" value="Post It!"/>
		</form>
			
		<% 

	} catch (Exception e) { out.println("Error!:" + e); }

 
      con.close();
%>

</body>
</html>
