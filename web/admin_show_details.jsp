<%-- 
    Document   : user_show_details
    Created on : 19 Nov, 2018, 9:14:42 PM
    Author     : anoop
--%>

<%@page import="bean.UserDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            
            if(UserDetails.admin_id <= 0 )
            {
                String redirectURL = "index.jsp";
                response.sendRedirect(redirectURL);
            }
            
            
            %>
        
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
                    
                    <h2>Admin Panel</h2>
                </td>
                
            </tr>
            
        </table>
        <table align="center" border="0">
            <tr>
                <td>
                    <form action="add_food_admin.jsp">
                        <input type="submit" value="Add Food Details">
                    </form> 
                </td>
                <td>
                    <form action="view_food_admin.jsp">
                        <input type="submit" value="View Food Details">
                    </form> 
                </td>
                <td>
                    <form action="view_order_admin.jsp">
                        <input type="submit" value="View Order">
                    </form>
                </td>
                <td>
                    <form action="view_user_admin.jsp">
                        <input type="submit" value="View Users Details">
                    </form>
                </td>
                <td>
                    <form action="logout.jsp">
                        <input type="submit" value="Logout">
                    </form>
                </td>
            </tr>    
                    
        </table>
    </body>
</html>
