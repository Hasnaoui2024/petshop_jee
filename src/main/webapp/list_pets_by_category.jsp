<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Category, service.CategoryService, java.util.List, model.PetTab, service.PetService, java.util.ArrayList, model.Cart, model.CartItem, jakarta.servlet.http.HttpSession" %>
<%@ page import="model.PetTab" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Pet Shop</title>
    <link rel="stylesheet" type="text/css" href="style.css" />
    <style>
        .pet-item {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            border-bottom: 1px solid #ccc;
            padding-bottom: 10px;
        }
        .pet-image {
            width: 4cm;
            height: 4cm;
            margin-right: 20px;
            object-fit: cover; /* Pour conserver les proportions de l'image */
        }
        .pet-info {
            flex: 1;
        }
        .pet-info h3 {
            margin: 0;
            font-size: 18px;
        }
        .pet-info p {
            margin: 5px 0;
        }
        .pet-info .price {
            font-weight: bold;
            color: #d9534f;
        }
    </style>
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
                <li><a href="details.jsp">prices</a></li>
                <li><a href="contact.jsp">contact</a></li>
            </ul>
        </div>     
    </div> 
       
    <div class="center_content">
        <div class="left_content">
            <div class="crumb_nav">
            <a href="category.jsp">return</a> 
    <%
        // Récupérer l'ID de la catégorie depuis la requête
        String categoryId = request.getParameter("categoryId");
        
        // Récupérer le nom de la catégorie
        String categoryName = "Unknown Category"; // Valeur par défaut
        if (categoryId != null && !categoryId.isEmpty()) {
            try {
                int id = Integer.parseInt(categoryId);
                CategoryService categoryService = new CategoryService();
                Category category = categoryService.getCategoryById(id);
                if (category != null) {
                    categoryName = category.getName();
                }
            } catch (NumberFormatException e) {
                // Gérer l'erreur si categoryId n'est pas un nombre valide
                e.printStackTrace();
            } catch (Exception e) {
                // Gérer d'autres exceptions
                e.printStackTrace();
            }
        }
    %>    
</div>
                         <div class="title"><span class="title_icon"><img src="images/bullet1.gif" alt="" title="" /></span><%= categoryName %></div>
                
            
           
            <div class="new_products">
                <%
                    List<PetTab> pets = (List<PetTab>) request.getAttribute("pets");
                    if (pets == null || pets.isEmpty()) {
                        out.println("<p>Aucun produit trouvé dans cette catégorie.</p>");
                    } else {
                        for (PetTab pet : pets) {
                %>
                            <div class="pet-item">
                                <!-- Image du produit -->
                                <img src="<%= pet.getImageUrl() != null ? pet.getImageUrl() : "images/default_pet_image.jpg" %>" 
                                     alt="<%= pet.getName() %>" 
                                     class="pet-image" />
                                
                                <!-- Informations du produit -->
                                <div class="pet-info">
                                    <h3><a href="details.jsp?petId=<%= pet.getId() %>"><%= pet.getName() %></a></h3>
                                    <p><%= pet.getDescription() %></p>
                                    <p class="price">$<%= pet.getPrice() %></p>
                                </div>
                            </div>
                <%
                        }
                    }
                %>
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
            
          
                <a href="cart.jsp" class="view_cart">View cart</a>
            </div>
                       
            <div class="title"><span class="title_icon"><img src="images/bullet3.gif" alt="" title="" /></span>À propos de notre magasin</div> 
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
  
            <h1></h1>
    
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