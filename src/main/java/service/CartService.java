package service;

import dao.CartDAO;
import model.Cart;
import model.CartItem;
import java.sql.SQLException;

public class CartService {

    private CartDAO cartDAO;

    // Constructeur
    public CartService() {
        this.cartDAO = new CartDAO();
    }

    // Ajouter un article au panier
 // Ajouter un article au panier
    public void addToCart(int userId, int petId, int quantity, double price, String petName, String imageUrl) throws SQLException {
        if (userId <= 0 || petId <= 0 || quantity <= 0 || price < 0 || imageUrl == null || imageUrl.isEmpty()) {
            throw new IllegalArgumentException("Les données du panier sont invalides.");
        }
        Cart cart = cartDAO.getCartByUserId(userId);
        cart.addItem(new CartItem(petId, quantity, price, petName, imageUrl)); // Ajout de l'URL de l'image
        cartDAO.saveCartToDatabase(cart);
    }

    // Récupérer le panier d'un utilisateur
    public Cart getCartByUserId(int userId) throws SQLException {
        if (userId <= 0) {
            throw new IllegalArgumentException("L'ID de l'utilisateur doit être un entier positif.");
        }
        return cartDAO.getCartByUserId(userId);
    }

    // Mettre à jour la quantité d'un article dans le panier
 // Mettre à jour la quantité d'un article dans le panier (et éventuellement l'URL de l'image)
    public void updateCartItem(int userId, int petId, int newQuantity, String imageUrl) throws SQLException {
        if (userId <= 0 || petId <= 0 || newQuantity <= 0 || imageUrl == null || imageUrl.isEmpty()) {
            throw new IllegalArgumentException("L'ID utilisateur, l'ID du produit, la quantité et l'URL de l'image doivent être valides.");
        }
        cartDAO.updateCartItem(userId, petId, newQuantity, imageUrl); // Ajout de l'URL de l'image
    }

    // Supprimer un article du panier
    public void removeCartItem(int userId, int petId) throws SQLException {
        if (userId <= 0 || petId <= 0) {
            throw new IllegalArgumentException("L'ID utilisateur et l'ID du produit doivent être valides.");
        }
        cartDAO.removeCartItem(userId, petId);
    }

    // Vider le panier d'un utilisateur
    public void clearCart(int userId) throws SQLException {
        if (userId <= 0) {
            throw new IllegalArgumentException("L'ID utilisateur doit être valide.");
        }
        cartDAO.clearCart(userId);
    }
}