<%-- 
    Document   : view_products
    Created on : 19 Nov, 2018, 9:20:32 PM
    Author     : anoop
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="bean.UserDetails"%>  
<jsp:useBean id="obj" class="bean.UserDetails"/>  
      
<jsp:setProperty property="*" name="obj"/> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <table align="center" border="0">
            
            <tr>
                <td>
                    <h1>Hotel Annapoorna Veg and Non-Veg</h1>
                    
                </td>
                
            </tr>
            
        </table>
        <table align="center" border="0">
            
            <tr>
                <td>
                    
                     <h2>View Foods</h2>
                    
                </td>
                
            </tr>
            
        </table>
        <table align="center" border="0">
            <tr>
                <td>
                    <form action="user_show_details.jsp">
                        <input type="submit" value="Home">
                    </form>
                </td>
                <td>
                    <form action="view_order.jsp">
                        <input type="submit" value="View Order">
                    </form>
                </td>
                <td>
                    <form action="logout.jsp">
                        <input type="submit" value="Logout">
                    </form>
                </td>
            </tr>    
                    
        </table>
        
<%@ page import ="java.sql.*" %>
<%
    
    
    
    
    
    try{
        String username = request.getParameter("username");   
        String password = request.getParameter("password");
        String redirectURL;
        Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
        Connection conn1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb","root","123456");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb?" + "user=root&password=123456");    
        PreparedStatement pst = conn.prepareStatement("Select * from foods");
        ResultSet rs = pst.executeQuery();
        %>
        <form name="something" action="view_food.jsp" method="post">
        <table border="1" align="center" cellpadding="5" cellspacing="2">
            <tr>
                <th>Sl No</th>
                <th>Food Name</th>
                <th>Price</th>
                <th>Quantity Left</th>
                
                <th>Count</th>
                <th>Order Item</th>
            </tr>
        <%
            int count=1;
        while(rs.next())
        {
        %>
        
        
            
            <tr>
                <td><%=count %></td>
                <td><%=rs.getString("food_name") %></td>
                <td><%=rs.getInt("price") %></td>
                <td><%=rs.getInt("count") %></td>
                
                <td><input type="number" name="qnty" value="0" ></td>
                <td><input type="checkbox" name="item" value="<%=rs.getInt("id") %>"></td>
            </tr>
            
        
        
        <%
         count++;          
        }
        %>
        <tr>  <td></td> <td>             
        <input type="submit" name="submit" value="Order Items"></td>
                
            </tr>
        </table>
        </form>
      <%
    }   
   catch(Exception e){ 
       //out.println(e);
       out.println("Something went wrong !! Please try again");       
   }      
%>   
    </body>
</html>

<%
    try{
        /*String username = request.getParameter("username");   
        String password = request.getParameter("password");
        String redirectURL;*/
        if (request.getParameter("submit") != null) {
            String item[]= request.getParameterValues("item");
            String qnty[]= request.getParameterValues("qnty");
            PreparedStatement pst;
            Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
            Connection conn1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb","root","123456");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb?" + "user=root&password=123456");    
            int totalprice =0;
            int final_quantity=0;
            int initial_quantity=0;
            int j=0;
            for(int i=0;i<item.length;i++)
            {
                    pst = conn.prepareStatement("Select * from foods where id=?");
                    pst.setString(1, item[i]);
                    ResultSet rs = pst.executeQuery();
                    rs.next();
                    pst = conn.prepareStatement("insert into orders(user_id,food_name,quantity,price) values(?,?,?,?)");
                    pst.setString(1, String.valueOf(UserDetails.user_id));
                    pst.setString(2, rs.getString("food_name"));
                                      
                    while(true){
                        int quantity1 = Integer.parseInt(qnty[j]);
                        
                        if(quantity1 >0)
                        {
                            break;
                        }
                        else{
                             j++;
                        }
                        
                    }
                    
                    pst.setString(3, qnty[j]);
                    int quantity = Integer.parseInt(qnty[j]);
                    initial_quantity = rs.getInt("count");
                    final_quantity = initial_quantity- quantity;
                    totalprice = rs.getInt("price")*quantity;
                    pst.setString(4, String.valueOf(totalprice));
                    
                    int status = pst.executeUpdate();
                    
                    if(status > 0)
                    {
                        pst = conn.prepareStatement("UPDATE foods SET count=? WHERE id=?");
                        pst.setString(1,String.valueOf(final_quantity) );
                        pst.setString(2, rs.getString("id") );
                        int u = pst.executeUpdate();
                    }
                
                
                    j++;
                

            }
            out.println("<h4 align=center>Food Ordered Successfully For More details goto View Orders</h4>");
        
            
        }
        
                   
        
        /*PreparedStatement pst = conn.prepareStatement("Select user_name,password from medicine_user where user_name=? and password=?");
        pst.setString(1, username);
        pst.setString(2, password);
        ResultSet rs = pst.executeQuery();                        
        if(rs.next())  {         
           //out.println("Valid login credentials"); 
           redirectURL = "user_show_details.jsp";
           response.sendRedirect(redirectURL);
        }       
        else
           out.println("Invalid login credentials"); */           
   }
   catch(Exception e){ 
       out.println(e);
       out.println("Something went wrong !! Please try again");       
   }      
%>


