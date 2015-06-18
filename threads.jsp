<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%> 
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Thread</title>
</head>
<body>
			<a href="home.jsp">Home</a><br>
			<a href="forum.jsp">Back to Forum</a><br><br>
		<% 
		
try {      
        String url = "jdbc:mysql://cs336-8.cs.rutgers.edu:3306/photo";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, "csuser", "csb52177");
        Statement stm = con.createStatement();
        Statement stmt = con.createStatement();
        Statement st = con.createStatement();
       	String topicID = request.getParameter ("topicID");
       	session.setAttribute("topicID", topicID);
       	String tid;


          	ResultSet rs1 = stm.executeQuery("select topic.title from topic where topic.topicID= '"+topicID+"'");
          	rs1.next();
          	String topic = rs1.getString(1);
          	ResultSet rs = stmt.executeQuery("select * from thread where thread.topicID= '"+topicID+"'");
			if(rs.next()){
				out.println("<table>");
				out.print("<tr><td><h2>" + topic + " threads</h2></td><td>&nbsp;&nbsp;&nbsp;&nbsp;Posts</td><td>Views</td></tr>" + "<tr><td>");

			     %><a href="posts.jsp?tid=<%= rs.getString(1)%>"><% out.println(rs.getString(4)); %></a>
			     
			<% ResultSet rs2 = st.executeQuery("select count(*) from post where threadID = '"+rs.getString(1)+"'");
	    	
	    	if(rs2.next()){
	    	
	    		out.println("</td><td>&nbsp;&nbsp;&nbsp;&nbsp;" + rs2.getString(1) + "</td><td>"+ rs.getString(10)+ "</td></tr>");
	    	}
				
				while(rs.next()){
    				out.println("<tr><td>");
					%><a href="posts.jsp?tid=<%= rs.getString(1)%>"><% out.println(rs.getString(4)); %></a>
		<%
					ResultSet rs3 = st.executeQuery("select count(*) from post where threadID = '"+rs.getString(1)+"'");
    	
    				if(rs3.next()){
    	
   			 			out.println("</td><td>&nbsp;&nbsp;&nbsp;&nbsp;" + rs3.getString(1) + "</td><td>"+ rs.getString(10)+ "</td></tr>");
    				}
				}
				out.println("</table>");
			}
			else
				out.println("No results found");
    	%>	
			<br></br>
			<div id = "cthreadbutton">
				<a href="cthread.html"><input type="button" value="Create Thread"></a>
			</div>
			
		<%    con.close();

	} catch (Exception e) { out.println("Error!:" + e); }
		%>

</body>
</html>