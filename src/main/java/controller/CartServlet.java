package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cart;
import model.CartItem;
import model.PetTab;
import service.PetService;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private CartDAO cartDAO;

    @Override
    public void init() {
        cartDAO = new CartDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("myaccount.jsp?error=login_required");
            return;
        }

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "view":
                    Cart cart = (Cart) session.getAttribute("cart");
                    if (cart == null) {
                        cart = cartDAO.getCartByUserId(userId);
                        session.setAttribute("cart", cart);
                    }
                    request.setAttribute("cartItems", cart.getItems());
                    request.getRequestDispatcher("cart.jsp").forward(request, response);
                    break;

                case "remove":
                    int petId = Integer.parseInt(request.getParameter("petId"));
                    Cart sessionCart1 = (Cart) session.getAttribute("cart");

                    if (sessionCart1 != null) {
                        // Trouver l'article dans le panier
                        CartItem itemToRemove = null;
                        for (CartItem item : sessionCart1.getItems()) {
                            if (item.getPetId() == petId) {
                                itemToRemove = item;
                                break;
                            }
                        }

                        if (itemToRemove != null) {
                            // Réduire la quantité de l'article
                            int newQuantity = itemToRemove.getQuantity() - 1;
                            if (newQuantity > 0) {
                                // Mettre à jour la quantité de l'article dans le panier
                                itemToRemove.setQuantity(newQuantity);
                            } else {
                                // Supprimer l'article du panier si la quantité atteint 0
                                sessionCart1.getItems().remove(itemToRemove);
                            }
                        }
                    }

                    // Rediriger vers la page du panier pour afficher les modifications
                    response.sendRedirect("cart?action=view");
                    break;

                case "checkout":
                    Cart sessionCart = (Cart) session.getAttribute("cart");
                    if (sessionCart != null && !sessionCart.getItems().isEmpty()) {
                        cartDAO.saveCartToDatabase(sessionCart);
                        session.removeAttribute("cart"); // Supprimer le panier de la session
                        request.getRequestDispatcher("checkout.jsp").forward(request, response);
                    } else {
                        request.setAttribute("message", "Votre panier est vide.");
                        request.getRequestDispatcher("cart.jsp").forward(request, response);
                    }
                    break;

                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action invalide.");
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Pour le debug
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur de base de données : " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Récupérer les paramètres de la requête
            int petId = Integer.parseInt(request.getParameter("petId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String petName = request.getParameter("petName");
            String imageUrl = request.getParameter("imageUrl"); // Récupérer l'URL de l'image

            // Log pour vérifier les informations reçues
            System.out.println("CartServlet - Informations reçues depuis details.jsp :");
            System.out.println("Pet ID: " + petId);
            System.out.println("Quantity: " + quantity);
            System.out.println("Pet Name: " + petName);
            System.out.println("Image URL: " + imageUrl); // Log de l'URL de l'image

            HttpSession session = request.getSession(false);
            Integer userId = (Integer) session.getAttribute("userId");

            if (userId == null) {
                response.sendRedirect("myaccount.jsp?error=login_required");
                return;
            }

            // Récupérer les informations du produit depuis le service
            PetService petService = new PetService();
            PetTab pet = null;
            try {
                pet = petService.getPetById(petId);
                // Log pour vérifier les informations du produit récupérées
                System.out.println("CartServlet - Informations du produit récupérées :");
                System.out.println("Pet ID: " + pet.getId());
                System.out.println("Pet Name: " + pet.getName());
                System.out.println("Pet Price: " + pet.getPrice());
                System.out.println("Pet Image URL: " + pet.getImageUrl()); // Log de l'URL de l'image du produit
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de la récupération du produit.");
                return;
            }

            // Récupérer ou créer le panier
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart(userId);
                session.setAttribute("cart", cart);
                System.out.println("CartServlet - Nouveau panier créé pour l'utilisateur ID: " + userId);
            }

            // Ajouter l'article au panier avec l'URL de l'image
            cart.addItem(new CartItem(petId, quantity, pet.getPrice(), petName, imageUrl)); // Ajout de l'URL de l'image
            session.setAttribute("cart", cart);
            System.out.println("CartServlet - Article ajouté au panier :");
            System.out.println("Pet ID: " + petId);
            System.out.println("Quantity: " + quantity);
            System.out.println("Pet Name: " + petName);
            System.out.println("Price: " + pet.getPrice());
            System.out.println("Image URL: " + imageUrl); // Log de l'URL de l'image

            // Rediriger vers la page du panier
            response.sendRedirect("cart?action=view");

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Paramètres invalides.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Une erreur est survenue.");
        }
    }
}