<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%> 
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>register</title>
</head>
<body>
<%
        try {    
                 String url = "jdbc:mysql://cs336-8.cs.rutgers.edu:3306/photo";
                 Class.forName("com.mysql.jdbc.Driver");
                 Connection con = DriverManager.getConnection(url, "csuser", "csb52177");
                 Statement stmt = con.createStatement();
                 	
                         String name = request.getParameter("name");
                         String location = request.getParameter("location");
                         String phone = request.getParameter("phone");
                         String fax = request.getParameter("fax");
                         String homepage = request.getParameter("homepage");
                         int noofpro = 0;

                         if(name.length()!=0 && location.length()!=0 && phone.length()!=0)
                         {
                         	int i = stmt.executeUpdate("insert into company(name,location,phone,fax,homepage,numofproduct) values ('"+name+"','"+location+"','"+phone+"','"+fax+"','"+homepage+"','"+noofpro+"')");
                         	out.println("Successfully Registered!");
                        	response.sendRedirect("companyList.jsp");
                         	
                         }
                         else
                         {
                             out.println("All Fields Are Required!");
                         }
                 con.close();

         } catch (Exception e) {    out.println("Error!: \t" + e);     }       
%>
		<h1></h1>
		<a href="companyList.jsp"> Back to Company</a>                                                                                    
</body>
</html>