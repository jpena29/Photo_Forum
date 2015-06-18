<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%> 
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Admin</title>
</head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Admin</title>
<body>
		<a href="home.html">Home page</a><br>
		<a href="profile.jsp">Profile page</a>
		<h1></h1>

		<%
        try {    
                 String url = "jdbc:mysql://cs336-8.cs.rutgers.edu:3306/photo";
                 Class.forName("com.mysql.jdbc.Driver");
                 Connection con = DriverManager.getConnection(url, "csuser", "csb52177");
                 Statement stmt, stmt1, stmt2, stmt3, stmt4, stmt5 = con.createStatement();
                 stmt = stmt1 = stmt2 = stmt3 = stmt4 = stmt5;
                 Object userid = request.getSession().getAttribute("userid");
                 String adminName = request.getParameter("adminName");
                 String salesName = request.getParameter("salesName");
               	 ResultSet rs = stmt.executeQuery("select username from userAccounts where username = '"+adminName+"'");
				 boolean istrue = false;
				 
          	 	if(rs.next()){
                    if(adminName.length()!=0)
                    {
              		 	int i = stmt.executeUpdate("insert into adminmoderator values ('"+adminName+"', 1)");
                         out.println("Successfully made " + adminName + " an administrator");
                         istrue = true;
                    }
        		}
                ResultSet rs1 = stmt1.executeQuery("select * from userAccounts where username = '"+salesName+"'");
            	if(rs1.next()){	
                	if(salesName.length()!=0)
                 	 {
        				int i = stmt1.executeUpdate("insert into salesPerson (userAccounts_username) values ('"+salesName+"')");
                   		out.println("Successfully made " + salesName + " a salesperson");
                   		istrue = true;
               		 }	
            	}	
	        	String title = request.getParameter("topicTitle");		
				String tags = request.getParameter("topicTags");
				
				if(title.length() != 0 && tags.length() != 0) {
					int i = stmt2.executeUpdate("insert into topic (adminmoderator_username, title, tags) values ('"+userid+"', '"+title+"', '"+tags+"')");
				 	out.println("Topic successfully created!");
				 	istrue = true;
                }
				
	        	String oldTitle = request.getParameter("oldTopicTitle");		
				String newTitle = request.getParameter("newTopicTitle");
				
				if(oldTitle.length() != 0 && newTitle.length() != 0) {
					int i = stmt3.executeUpdate("UPDATE topic SET title= '"+newTitle+"' WHERE title= '"+oldTitle+"'");
					int a = stmt4.executeUpdate("UPDATE topic SET adminmoderator_username = '"+userid+"' WHERE title= '"+newTitle+"'");
				 	out.println("Topic successfully edited!");
				 	istrue = true;
                }
				
	        	String threadID = request.getParameter("threadID");		
				String newTopicID = request.getParameter("newTopicID");
				
				if(threadID.length() != 0 && newTopicID.length() != 0) {
					int i = stmt5.executeUpdate("UPDATE thread SET topicID= '"+newTopicID+"' WHERE threadID = '"+threadID+"'");
				 	out.println("Thread successfully moved!");
				 	istrue = true;
                }
				
                if(!istrue)
                {
                        out.println("Either you didn't enter anything or the thing you entered was wrong. Try again.");
                }
                 con.close();

        
         } catch (Exception e) {    out.println("Error!: \t" + e);     }       
%>
	<h1></h1>
	<a href="admin.html">Admin Page</a>

</body>
</html>