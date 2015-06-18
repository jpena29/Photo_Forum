<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%> 
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>hello</title>
</head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Main</title>
<body>
		<%
		String productID =request.getParameter("productID");
		session.setAttribute("productID", productID);
    	response.sendRedirect("purchasePageForm.jsp");
		%>
</body>
</html>
