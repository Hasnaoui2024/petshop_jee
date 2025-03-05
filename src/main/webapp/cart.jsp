<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.CartItem, java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Pet Shop</title>
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
            <div class="title"><span class="title_icon"><img src="images/bullet1.gif" alt="" title="" /></span>My cart</div>
        
            <div class="feat_prod_box_details">
    <table>
        <tr>
            <th>Item pic</th>
            <th>Pet name</th>
            <th>Unit price</th>
            <th>Qty</th>
            <th>Total</th>
            <th>Action</th>
        </tr>
        <%
            model.Cart cart = (model.Cart) session.getAttribute("cart");
            List<CartItem> cartItems = (cart != null) ? cart.getItems() : null;

            double totalAmount = 0.0;

            if (cartItems != null && !cartItems.isEmpty()) {
                for (CartItem item : cartItems) {
                    totalAmount += item.getTotal();
        %>
        <tr>
            <td>
                <img src="<%= item.getImageUrl() != null ? item.getImageUrl() : "images/default_pet_image.jpg" %>" 
                     alt="<%= item.getPetName() %>" 
                     title="<%= item.getPetName() %>" 
                     border="0" 
                     style="width: 200px; height: 200px;" />
            </td>
            <td><%= item.getPetName() %></td>
            <td>$<%= item.getPrice() %></td>
            <td><%= item.getQuantity() %></td>
            <td>$<%= item.getTotal() %></td>
            <td><a href="cart?action=remove&petId=<%= item.getPetId() %>">Supprimer</a></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="6">Votre panier est vide.</td>
        </tr>
        <%
            }
        %>
    </table>
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
    <div class="continue_button">
        <a href="index.jsp" class="continue">Continue</a>
    </div>
    <div class="checkout_button">
        <a href="cart?action=checkout" class="checkout">Checkout</a>
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