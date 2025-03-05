<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.PetTab, dao.PetTabDAO, java.util.List" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="util.DBConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pet Shop</title>
    <link rel="stylesheet" type="text/css" href="style.css" />
    <link rel="stylesheet" href="lightbox.css" type="text/css" media="screen" />
    <script src="js/prototype.js" type="text/javascript"></script>
    <script src="js/scriptaculous.js?load=effects" type="text/javascript"></script>
    <script src="js/lightbox.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/java.js"></script>
</head>
<body>
<div id="wrap">

    <div class="header">
        <div class="logo"><a href="index.jsp"><img src="images/logo.gif" alt="Pet Shop" title="Pet Shop" border="0" /></a></div>
        <div id="menu">
            <ul>
                <li class="selected"><a href="index.jsp">home</a></li>
                <li><a href="about.jsp">about us</a></li>
                <li><a href="category.jsp">pets</a></li>
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
                <a href="list_pets_by_category.jsp">return</a>
            </div>

            <%
                String petIdParam = request.getParameter("petId");
                PetTab pet = null;

                if (petIdParam != null && !petIdParam.isEmpty()) {
                    try {
                        int petId = Integer.parseInt(petIdParam);
                        PetTabDAO petDAO = new PetTabDAO();
                        pet = petDAO.getPetsById(petId);
                    } catch (NumberFormatException e) {
                        out.println("<p>ID de produit invalide.</p>");
                    } catch (Exception e) {
                        out.println("<p>Une erreur est survenue : " + e.getMessage() + "</p>");
                    }
                }

                if (pet == null) {
            %>
                    <p>Produit introuvable ou aucune information disponible.</p>
            <%
                } else {
            %>
                    <div class="title">
                        <span class="title_icon"><img src="images/bullet1.gif" alt="" title="" /></span>
                        <%= pet.getName() %>
                    </div>

                    <script>
                        <%
                            if (pet.getName() != null) {
                        %>
                            console.log("Pet Name in details.jsp: <%= pet.getName() %>");
                        <%
                            } else {
                        %>
                            console.error("Pet Name is null in details.jsp");
                        <%
                            }
                        %>
                    </script>

                    <div class="feat_prod_box_details">
    

    <div class="prod_container"> <!-- Ajout d'une classe "prod_container" pour envelopper les deux sections -->
    <div class="prod_img">
        <a href="details.jsp">
            <!-- Utilisation de l'URL de l'image du produit -->
            <img src="<%= pet.getImageUrl() != null ? pet.getImageUrl() : "images/default_pet_image.jpg" %>" 
                 alt="<%= pet.getName() %>" 
                 title="<%= pet.getName() %>" 
                 border="0" 
                 style="width: 150px; height: 150px;" />
        </a>
        <br /><br />
        <a href="<%= pet.getImageUrl() != null ? pet.getImageUrl() : "images/big_pic.jpg" %>" rel="lightbox">
            <img src="images/zoom.gif" alt="Zoom" title="Zoom" border="0" />
        </a>
    </div>
    <div class="prod_det_box">
        <div class="box_top"></div>
        <div class="box_center">
            <div class="prod_title">Details</div>
            <p class="details"><%= pet.getDescription() != null ? pet.getDescription() : "No description available." %></p>
            <div class="price"><strong>PRICE:</strong> <span class="red"><%= pet.getPrice() != 0.0 ? pet.getPrice() : "0" %> $</span></div>
            <form action="cart" method="post">
    <input type="hidden" name="action" value="add" />
    <input type="hidden" name="petId" value="<%= pet.getId() %>" />
    <input type="hidden" name="price" value="<%= pet.getPrice() %>" />
    <input type="hidden" name="petName" value="<%= pet.getName() %>" />
    <input type="hidden" name="imageUrl" value="<%= pet.getImageUrl() %>" /> <!-- Ajout de l'URL de l'image -->
    <div class="quantity">
        <label for="quantity"><strong>Quantity:</strong></label>
        <input type="number" id="quantity" name="quantity" value="1" min="1" required />
    </div>
    <button type="submit" class="more">
        <img src="images/order_now.gif" alt="Order Now" title="Order Now" border="0" />
    </button>
</form>
            <script type="text/javascript">
                document.querySelector('form').addEventListener('submit', function(event) {
                    console.log('Form submitted');
                });
            </script>
        </div>
        <div class="box_bottom"></div>
    </div>
</div>
    <div class="clear"></div>
</div>
            <%
                }
            %>
        </div><!--end of left content-->

        <div class="right_content">
            <!-- Content for the right column -->
        </div><!--end of right content-->

        <div class="clear"></div>
    </div><!--end of center content-->

    <div class="footer">
        <div class="left_footer">
            <img src="images/footer_logo.gif" alt="Pet Shop" title="Pet Shop" /><br />
            <a href="http://csscreme.com/freecsstemplates/" title="free css templates">
                <img src="images/csscreme.gif" alt="free css templates" border="0" />
            </a>
        </div>
        <div class="right_footer">
            <a href="#">home</a>
            <a href="#">about us</a>
            <a href="#">services</a>
            <a href="#">privacy policy</a>
            <a href="#">contact us</a>
        </div>
    </div>
</div>

<script type="text/javascript">
    var tabber1 = new Yetii({
        id: 'demo'
    });
</script>
</body>
</html>
