<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%> 
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Company</title>
<style> h1 {text-align:center;} h2 {text-align:center;} </style>

</head>
<body>
		<a href="home.jsp">Home page</a>
		<h2>Add Company</h2>
		<form action="company.jsp" method="post">
			<table>
			<tr>
			<td>Name<input type="text" name="name"/></td>
			<td>Location<input type="text" name="location"/></td>
			<td>Phone<input type="text" name="phone"/></td>
			<td>Fax<input type="text" name="fax"/></td>
			<td>Homepage<input type="text" name="homepage"/></td></tr></table>
			<p><input type="submit"/>
		</form>
		<h1></h1>
		<h1>Company List</h1>
		
<%
    try {      
        String url = "jdbc:mysql://cs336-8.cs.rutgers.edu:3306/photo";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, "csuser", "csb52177");
        Statement stmt = con.createStatement();

          	ResultSet rs = stmt.executeQuery("select * from company");
		          	
			if(rs.next()){
				out.println("<table>");
				out.print("<tr><td>CompanyID</td>");
				out.print("<td>Name</td>");
				out.print("<td>Location</td>");
				out.print("<td>Phone</td>");
				out.print("<td>Fax</td>");
				out.print("<td>Homepage</td>");
				out.print("<td>#Products</td>");
				out.print("<td>Date</td></tr>");
				
				out.print("<tr><td>" + rs.getString(1) + "</td>");
				out.print("<td>" + rs.getString(2) + "</td>");
				out.print("<td>" + rs.getString(3) + "</td>");
				out.print("<td>" + rs.getString(4) + "</td>");
				out.print("<td>" + rs.getString(5) + "</td>");
				out.print("<td>" + rs.getString(6) + "</td>");
				out.print("<td>" + rs.getString(7) + "</td>");
				out.print("<td>" + rs.getString(8) + "</td></tr>");
				
				while(rs.next()){
					out.print("<tr><td>" + rs.getString(1) + "</td>");
					out.print("<td>" + rs.getString(2) + "</td>");
					out.print("<td>" + rs.getString(3) + "</td>");
					out.print("<td>" + rs.getString(4) + "</td>");
					out.print("<td>" + rs.getString(5) + "</td>");
					out.print("<td>" + rs.getString(6) + "</td>");
					out.print("<td>" + rs.getString(7) + "</td>");
					out.print("<td>" + rs.getString(8) + "</td></tr>");
				}
				out.println("</table>");
			}
			else
				out.println("No results found");
    		
		    con.close();

	} catch (Exception e) { out.println("Error!:" + e); }
%>

</body>
</html>