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
	        
	        	String recipient = request.getParameter("recipient");
	        	String subject = request.getParameter("subject");
	        	String message = request.getParameter("message");
	        	
	        	String sender = (String)request.getSession().getAttribute("userid");
	        
	        	
	        	ResultSet rs = stmt.executeQuery("select * from userAccounts where userAccounts.username= '"+recipient+"'");
	        	
	        	boolean check = false;	//check if recipient is a user in our system
	        	
	        	if(recipient.length() != 0 && subject.length() != 0 && message.length() != 0) {
	        		if(rs.next()) {
	        			if(rs.getString(1).equalsIgnoreCase(recipient)) {
	        				check = true;
	        			}
	        			while(rs.next()) {
	        				if(rs.getString(1).equalsIgnoreCase(recipient)) {
	        					check = true;
	        				}
	        			}
	        		}
	        		if(check == false) {
	        			out.println("Incorrect recipient of the message!");
	        		}
	        		
	        		int i = stmt.executeUpdate("insert into message (send_username, receive_username, subject, msgbody) values ('"+sender+"', '"+recipient+"','"+subject+"','"+message+"')");
	        		response.sendRedirect("messages.jsp");
				 	
                }
                else
                {
                    out.println("Both Fields Are Required!");
                }
       			con.close();
			} catch (Exception e) {out.println("Error! \t:" + e);}
		
		%>
	</body>
</html>