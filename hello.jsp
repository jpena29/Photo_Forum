<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%> 
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
		<title>hello</title>
		<link rel="stylesheet" type="text/css" href="style/register.css">
	</head>
	<body>
		<div id="login">
			<div id="title">
				<h1>Photography Forum</h1>
			</div>
			<form action="login.jsp" method="post">
				<input placeholder="Username" type="text" name="user_id"/>
				<input placeholder="Password" type="password" name="pwd"/>
				<input id="submit" type="submit"/>
			</form>
		</div>
		<div id="register">
			<h2>New to our site!</h2>
			<form action="register.jsp" method="post">
				<input placeholder="Username" type="text" name="user_id"/><br>
				<input placeholder="First Name" type="text" name="fname"/><br>
				<input placeholder="Last Name" type="text" name="lname"/><br>
				<input placeholder="Email" type="text" name="email"/><br>
				<input placeholder="Password" type="password" name="pwd"/><br>
				<input placeholder="Confirm Password" type="password" name="cpwd"/><br>
				<input id="submit" type="submit"/>
			</form>
		</div>
		<div id="camera"></div>
	</body>
</html>