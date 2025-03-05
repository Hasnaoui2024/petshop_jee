<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Category, service.CategoryService, java.util.List, model.PetTab, service.PetService, java.util.ArrayList, model.Cart, model.CartItem, jakarta.servlet.http.HttpSession" %>
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
                <li class="selected"><a href="category.jsp">pets</a></li>
                <li><a href="specials.jsp">specials pets</a></li>
                <li><a href="myaccount.jsp">my account</a></li>
                <li><a href="register.jsp">register</a></li>
                <li><a href="contact.jsp">contact</a></li>
            </ul>
        </div>     
    </div> 
       
    <div class="center_content">
        <div class="left_content">
            <div class="crumb_nav">
                <a href="index.jsp">home</a>
            </div>
            <div class="title"><span class="title_icon"><img src="images/bullet1.gif" alt="" title="" /></span>Product Categories</div>
           
           <div class="new_products">
           
                <%
                    CategoryService categoryService = new CategoryService();
                    List<Category> categories = categoryService.getAllCategories();
                    for (Category category : categories) {
                %>
                    <div class="new_prod_box">
                        <!-- Rediriger vers PetServlet avec l'ID de la catégorie -->
                        <a href="PetServlet?categoryId=<%= category.getId() %>"><%= category.getName() %></a>
                        <div class="new_prod_bg">
                            <a href="PetServlet?categoryId=<%= category.getId() %>">
                                <img src="<%= category.getImage() %>" alt="" title="" class="thumb" border="0" />
                            </a>
                        </div>           
                    </div>
                <% } %>
       
            </div> 
          
            <div class="pagination">
                <span class="disabled"><<</span><span class="current">1</span><a href="#?page=2">2</a><a href="#?page=3">3</a>…<a href="#?page=199">10</a><a href="#?page=200">11</a><a href="#?page=2">>></a>
            </div>  
            
        </div><!--end of left content-->
        
        <div class="right_content">
            <div class="languages_box">
                <span class="red">Languages:</span>
                <a href="#"><img src="images/gb.gif" alt="" title="" border="0" /></a>
                <a href="#"><img src="images/fr.gif" alt="" title="" border="0" /></a>
                <a href="#"><img src="images/de.gif" alt="" title="" border="0" /></a>
            </div>
            <div class="currency">
                <span class="red">Currency: </span>
                <a href="#">GBP</a>
                <a href="#">EUR</a>
                <a href="#"><strong>USD</strong></a>
            </div>
                
            <%
    // Récupérer le panier de la session
    // Pas besoin de déclarer 'session' car c'est un objet implicite JSP
    Cart cart = (Cart) session.getAttribute("cart");

    int totalItems = 0;
    double totalPrice = 0.0;

    if (cart != null) {
        // Calculer le nombre total d'articles et le prix total
        for (CartItem item : cart.getItems()) {
            totalItems += item.getQuantity();
            totalPrice += item.getTotal();
        }
    }
%>
            <div class="cart">
    <div class="title"><span class="title_icon"><img src="images/cart.gif" alt="" title="" /></span>My cart</div>
    <div class="home_cart_content">
        <%= totalItems %> x items | <span class="red">TOTAL: $<%= String.format("%.2f", totalPrice) %></span>
    </div>
    <a href="cart?action=view" class="view_cart">view cart</a>
</div>
                       
            <div class="title"><span class="title_icon"><img src="images/bullet3.gif" alt="" title="" /></span>About Our Shop</div> 
            <div class="about">
                <p>
                    <img src="images/about.gif" alt="" title="" class="right" />
Welcome to Pet Shop, your trusted store for all your pet needs. We offer a wide range of high-quality products for dogs, cats, fish, and more. Our items are carefully selected to ensure the health and well-being of your companions. Our passionate team is always ready to provide you with personalized advice. Thank you for choosing us as your trusted partner in caring for your pets.                </p>
            </div>
             
            <div class="right_box">
                <div class="title"><span class="title_icon"><img src="images/bullet4.gif" alt="" title="" /></span>Promotions</div> 
                <div class="new_prod_box">
                    <a href="details.jsp"></a>
                    <div class="new_prod_bg">
                        <span class="new_icon"><img src="images/promo_icon.gif" alt="" title="" /></span>
                        <a href="details.jsp"><img src="images/thumb1.gif" alt="" title="" class="thumb" border="0" /></a>
                    </div>           
                </div>
                
                <div class="new_prod_box">
                    <a href="details.jsp"></a>
                    <div class="new_prod_bg">
                        <span class="new_icon"><img src="images/promo_icon.gif" alt="" title="" /></span>
                        <a href="details.jsp"><img src="images/thumb2.gif" alt="" title="" class="thumb" border="0" /></a>
                    </div>           
                </div>                    
                
                <div class="new_prod_box">
                    <a href="details.jsp"></a>
                    <div class="new_prod_bg">
                        <span class="new_icon"><img src="images/promo_icon.gif" alt="" title="" /></span>
                        <a href="details.jsp"><img src="images/thumb3.gif" alt="" title="" class="thumb" border="0" /></a>
                    </div>           
                </div>              
            </div>
             
            <div class="right_box">
                <div class="title"><span class="title_icon"><img src="images/bullet5.gif" alt="" title="" /></span>Catégories</div> 
                <ul class="list">
                    <%
                        for (Category category : categories) {
                    %>
                    <li><a href="PetServlet?categoryId=<%= category.getId() %>"><%= category.getName() %></a></li>
                    <% } %>
                </ul>
                
                <div class="title"><span class="title_icon"><img src="images/bullet6.gif" alt="" title="" /></span>Partners</div> 
                <ul class="list">
                    <li><a href="#">Pet clothing brands</a></li>
                <li><a href="#">Toy designers</a></li>
                <li><a href="#">Accessory manufacturers</a></li>
                <li><a href="#">Food suppliers</a></li>                               
                </ul>      
            </div>         
        </div><!--end of right content-->
        
        <div class="clear"></div>
    </div><!--end of center content-->
       
    <div class="footer">
        <div class="left_footer"><img src="images/footer_logo.gif" alt="" title="" /><br /> <a href="http://csscreme.com/freecsstemplates/" title="free css templates"><img src="images/csscreme.gif" alt="free css templates" border="0" /></a></div>
        <div class="right_footer">
            <a href="#">accueil</a>
            <a href="#">à propos</a>
            <a href="#">services</a>
            <a href="#">politique de confidentialité</a>
            <a href="#">nous contacter</a>
        </div>
    </div>
</div>

</body>
</html>