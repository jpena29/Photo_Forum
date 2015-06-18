<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%> 
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Profile</title>
</head>
<body>
			<a href="home.html">Home</a><br>
			<a href="forum.jsp">Back to Forum</a><br><br>
		<% 
		
try {      
        String url = "jdbc:mysql://cs336-8.cs.rutgers.edu:3306/photo";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, "csuser", "csb52177");
        Statement stmt = con.createStatement();
        Statement stm = con.createStatement();
       	String productID = (String)request.getSession().getAttribute("productID");
       	String quantity = request.getParameter ("quantity");
       	String pricePerItem = request.getParameter ("pricePerItem");
       	String userid = (String)request.getSession().getAttribute("userid");
       	String email = (String)request.getSession().getAttribute("email");
		
   //    	session.setAttribute("companyID", companyID);
       	String tid;

          	ResultSet rs = stmt.executeQuery("select * from product where product.productID= '"+productID+"'");
  //        	ResultSet rs1 = stm.executeQuery("select topic.title from topic where topic.topicID= '"+topicID+"'");
  //        	rs1.next();
			if(rs.next()){
				int b = Integer.parseInt(rs.getString(6));
				int c =Integer.parseInt(quantity);
				int d = b*c;
				String cost= Integer.toString (d);
        		int i = stmt.executeUpdate("insert into purchase(productID, userAccounts_username, userAccounts_email, purchase_quantity, cost) values ('"+productID+"', '"+userid+"', '"+email+"', '"+quantity+"', '"+cost+"')");
                out.println("Successfully Boughten Products!");
			}
			else
				out.println("Error!");
    	%>	
			<br></br>
				<a href="purchasePage.html">Back to Purchase Page</a>
			
		<%    con.close();

	} catch (Exception e) { out.println("Error!:" + e); }
		%>

</body>
</html>