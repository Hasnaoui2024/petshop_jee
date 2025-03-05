<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Category, service.CategoryService, java.util.List, model.PetTab, service.PetService, java.util.ArrayList, model.Cart, model.CartItem, jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Pet Shop</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<style>
    .feat_prod_box {
        display: flex;
        align-items: center; /* Align items at the start vertically */
    }

    .prod_img {
        margin-right:1px; /* Space between image and info box */
    }

    .prod_img img.featured-img {
        width: 4cm; /* 4cm width */
        height: 4cm; /* 4cm height */
    }

    .prod_det_box {
        flex: 1; /* Allow the info box to take remaining space */
        overflow: hidden; /* Ensure text doesn't overflow */
    }

    .new_prod_box img {
        width: 100%; /* Adjust to fit the container */
        height: auto;
    }
</style>
</head>
<body>
<div id="wrap">
    <div class="header">
        <div class="logo"><a href="index.jsp"><img src="images/logo.gif" alt="" title="" border="0" /></a></div>
        <div id="menu">
            <ul>
                <li class="selected"><a href="index.jsp">home</a></li>
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
            <div class="title"><span class="title_icon"><img src="images/bullet1.gif" alt="" title="" /></span>Featured pets</div>

            <%
                PetService petService = new PetService();
                List<PetTab> featuredPets = petService.getAllPets(); // Récupérer tous les produits
                int featuredCount = 0; // Compteur pour limiter à 2 produits
                for (PetTab pet : featuredPets) {
                    if (featuredCount >= 2) break; // Limiter à 2 produits
            %>
            <div class="feat_prod_box">
                <div class="prod_img">
                    <a href="details.jsp?petId=<%= pet.getId() %>">
                        <img src="<%= pet.getImageUrl() %>" alt="<%= pet.getName() %>" class="featured-img" />
                    </a>
                </div>
                <div class="prod_det_box">
                    <div class="box_top"></div>
                    <div class="box_center">
                        <div class="prod_title"><%= pet.getName() %></div>
                        <p class="details"><%= pet.getDescription() %></p>
                        <a href="details.jsp?petId=<%= pet.getId() %>" class="more">- more details -</a>
                        <div class="clear"></div>
                    </div>
                    <div class="box_bottom"></div>
                </div>
                <div class="clear"></div>
            </div>
            <%
                featuredCount++;
                }
            %>

            <div class="title"><span class="title_icon"><img src="images/bullet2.gif" alt="" title="" /></span>New pets</div>

            <div class="new_products">
                <%
                    int newCount = 0; // Compteur pour limiter à 3 produits
                    for (PetTab pet : featuredPets) {
                        if (newCount >= 3) break; // Limiter à 3 produits
                %>
                <div class="new_prod_box">
                    <a href="details.jsp?petId=<%= pet.getId() %>"><%= pet.getName() %></a>
                    <div class="new_prod_bg">
                        <span class="new_icon"><img src="images/new_icon.gif" alt="" title="" /></span>
                        <a href="details.jsp?petId=<%= pet.getId() %>">
                            <img src="<%= pet.getImageUrl() %>" alt="<%= pet.getName() %>" title="<%= pet.getName() %>" class="thumb" border="0" />
                        </a>
                    </div>
                </div>
                <%
                    newCount++;
                    }
                %>
            </div>

            <div class="clear"></div>
        </div><!--end of left content-->

        <div class="right_content">
            <div class="languages_box">
                <span class="red">Languages:</span>
                <a href="#" class="selected"><img src="images/gb.gif" alt="" title="" border="0" /></a>
                <a href="#"><img src="images/fr.gif" alt="" title="" border="0" /></a>
                <a href="#"><img src="images/de.gif" alt="" title="" border="0" /></a>
            </div>
            <div class="currency">
                <span class="red">Currency: </span>
                <a href="#">GBP</a>
                <a href="#">EUR</a>
                <a href="#" class="selected">USD</a>
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
Welcome to Pet Shop, your trusted store for all your pet needs. We offer a wide range of high-quality products for dogs, cats, fish, and more. Our items are carefully selected to ensure the health and well-being of your companions. Our passionate team is always ready to provide you with personalized advice. Thank you for choosing us as your trusted partner in caring for your pets.
                </p>
            </div>

            <div class="right_box">
                <div class="title"><span class="title_icon"><img src="images/bullet4.gif" alt="" title="" /></span>Promotions</div>
                <div class="new_prod_box">
                    <a href="details.jsp"><br/></a>
                    <div class="new_prod_bg">
                        <span class="new_icon"><img src="images/promo_icon.gif" alt="" title="" /></span>
                        <a href="details.jsp"><img src="images/thumb1.gif" alt="" title="" class="thumb" border="0" /></a>
                    </div>
                </div>
                <div class="new_prod_box">
                    <a href="details.jsp"><br/></a>
                    <div class="new_prod_bg">
                        <span class="new_icon"><img src="images/promo_icon.gif" alt="" title="" /></span>
                        <a href="details.jsp"><img src="images/thumb2.gif" alt="" title="" class="thumb" border="0" /></a>
                    </div>
                </div>
                <div class="new_prod_box">
                    <a href="details.jsp"><br/></a>
                    <div class="new_prod_bg">
                        <span class="new_icon"><img src="images/promo_icon.gif" alt="" title="" /></span>
                        <a href="details.jsp"><img src="images/thumb3.gif" alt="" title="" class="thumb" border="0" /></a>
                    </div>
                </div>
            </div>

            <div class="right_box">
                <div class="title"><span class="title_icon"><img src="images/bullet5.gif" alt="" title="" /></span>Categories</div>
                <ul class="list">
                    <%
                        CategoryService categoryService = new CategoryService();
                        List<Category> categories = categoryService.getAllCategories();
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