<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%> 
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
		<title>Sales</title>
	</head>
	<body>
		<a href="home.html">Home page</a><br>
		<a href="profile.jsp">Profile page</a>
		<h1></h1>

		<%
		try{	
        String url = "jdbc:mysql://cs336-8.cs.rutgers.edu:3306/photo";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, "csuser", "csb52177");
        Statement stmt = con.createStatement();
        Statement stmt1 = con.createStatement();
        String click = request.getParameter("pro");
        String click2 = request.getParameter("ad");
        
        if(click != null){
            String companyID = request.getParameter("companyID");
            String productname = request.getParameter("productname");
            String category = request.getParameter("category");
            String pricePerItem = request.getParameter("pricePerItem");
            String description = request.getParameter("description");
			int sold = 0;
			int noofads = 0;
			int noofpur = 0;
            
          	 ResultSet rs = stmt.executeQuery("select companyID from company where companyID = '"+companyID+"'");
           
          	if(rs.next()){
           	 if(companyID.length()!=0)
            	{
           		int i = stmt.executeUpdate("insert into product(companyID, productname, category, sold, pricePerItem, description, noofads, noofpurchases) values('"+companyID+"', '"+productname+"', '"+category+"','"+sold+"', '"+pricePerItem+"', '"+description+"', '"+noofads+"', '"+noofpur+"')");
                   out.println("Successfully Registered!");
           	}
           }
           else
           {
                  out.println("Something went wrong!");
           }
        }
        else if(click2 != null){
            String companyID = request.getParameter("compID");
            String productID = request.getParameter("productID");
            String description = request.getParameter("description");
            String keywords = request.getParameter("keywords");
            String url2 = request.getParameter("url");
         	int views = 0;
            
          	 ResultSet rs = stmt.executeQuery("select companyID from company where companyID = '"+companyID+"'");
          	 ResultSet rs1 = stmt1.executeQuery("select productID from product where productID = '"+productID+"'");
           //ResultSet rs2 = stmt2.executeQuery("select url from ads where url = '"+urlName+"'");

					
            if(companyID.length()!=0 && productID.length()!=0){
             	if(rs.next() && rs1.next()){
           		int i = stmt.executeUpdate("insert into ads(companyID, productID, description, keywords, views, url)  values('"+companyID+"','"+productID+"','"+description+"','"+keywords+"', '"+views+"', '"+url2+"')");
                   out.println("Successfully Registered!");
             	}
            }
            else
            {
                   out.println("All Fields Are Required!");
            }
        }
        con.close();
		}
		 catch (Exception e) {    out.println("Error!: \t" + e);     } 
		
		%><h1></h1>
		<a href="sales.html">Sale page</a>
		<%
		
        String url = "jdbc:mysql://cs336-8.cs.rutgers.edu:3306/photo";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, "csuser", "csb52177");
        Statement stmt = con.createStatement();
        String urlName;
      	ResultSet rs = stmt.executeQuery("SELECT * FROM ads WHERE adID >= (SELECT FLOOR( MAX(adID) * RAND()) FROM ads ) ORDER BY adID LIMIT 1");
		if(rs.next()){
			urlName = rs.getString(9);
		%>
	        <a href = "purchasePage.html?productID=<%=rs.getString(3)%> "> <img align="right" height="450" width="250" src ="<%=urlName%>"/> </a>
	    <%            
		}
        %>
	</body>
</html>