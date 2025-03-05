<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.CartItem, service.CartService, java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Pet Shop - Checkout</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>
<div id="wrap">

    <div class="header">
        <div class="logo"><a href="index.jsp"><img src="images/logo.gif" alt="" title="" border="0" /></a></div>            
        <div id="menu">
            <ul>                                                                       
                <li><a href="index.jsp">home</a></li>
                <li><a href="about.jsp">about us</a></li>
                <li><a href="category.jsp">pets</a></li>
                <li><a href="specials.jsp">specials pets</a></li>
                <li><a href="myaccount.jsp">my account</a></li>
                <li><a href="register.jsp">register</a></li>
                <li><a href="details.jsp">prices</a></li>
                <li><a href="contact.jsp">contact</a></li>
            </ul>
        </div>     
    </div> 
       
    <div class="center_content">
        <div class="left_content">
            <div class="title"><span class="title_icon"><img src="images/bullet1.gif" alt="" title="" /></span>My Cart</div>
        
            <div class="feat_prod_box_details">
    <!-- Message de succès -->
    <p style="color: green; font-weight: bold; text-align: center;">Your purchase has been successfully completed!</p>

    <!-- Tableau des articles -->
    <table class="cart_table">
        <tr>
            <th>Item pic</th>
            <th>Book name</th>
            <th>Unit price</th>
            <th>Qty</th>
            <th>Total</th>
        </tr>
        <%
            List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
            double totalAmount = 0.0;
            if (cartItems != null && !cartItems.isEmpty()) {
                for (CartItem item : cartItems) {
                    totalAmount += item.getTotal();
        %>
        <tr>
            <td>
                <div class="prod_img">
                    <img src="<%= item.getImageUrl() != null ? item.getImageUrl() : "images/default_pet_image.jpg" %>" 
                         alt="<%= item.getPetName() %>" 
                         title="<%= item.getPetName() %>" 
                         border="0" 
                         style="width: 150px; height: 150px;" />
                </div>
            </td>
            <td><%= item.getPetName() != null ? item.getPetName() : "Books" %></td>
            <td>$<%= item.getPrice() %></td>
            <td><%= item.getQuantity() %></td>
            <td>$<%= item.getTotal() %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="5">Your cart is empty.</td>
        </tr>
        <%
            }
        %>
    </table>

    <!-- Section Totale -->
    <div class="total_section">
        <table>
            <tr>
                <td><strong>TOTAL SHIPPING:</strong></td>
                <td>$250</td>
            </tr>
            <tr>
                <td><strong>TOTAL:</strong></td>
                <td>$<%= totalAmount + 250 %></td>
            </tr>
        </table>
    </div>

    <!-- Bouton Continue Shopping -->
    <div class="checkout_button">
        <a href="index.jsp" class="checkout">Continue Shopping</a>
    </div>
</div>	
        </div><!--end of left content-->
        
        <div class="right_content">
            <!-- Right content remains the same as in the original HTML -->
        </div><!--end of right content-->
        
        <div class="clear"></div>
    </div><!--end of center content-->
       
    <div class="footer">
        <div class="left_footer"><img src="images/footer_logo.gif" alt="" title="" /><br /> <a href="http://csscreme.com/freecsstemplates/" title="free css templates"><img src="images/csscreme.gif" alt="free css templates" border="0" /></a></div>
        <div class="right_footer">
            <a href="#">home</a>
            <a href="#">about us</a>
            <a href="#">services</a>
            <a href="#">privacy policy</a>
            <a href="#">contact us</a>
        </div>
    </div>
</div>

</body>
</html>