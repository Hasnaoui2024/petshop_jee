package dao;

import model.Cart;
import model.CartItem;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    // Enregistrer tous les éléments du panier dans la base de données
	public void saveCartToDatabase(Cart cart) throws SQLException {
	    String query = "INSERT INTO cart (user_id, pet_id, quantity, price, petName, imageUrl) VALUES (?, ?, ?, ?, ?, ?)";
	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement statement = connection.prepareStatement(query)) {

	        for (CartItem item : cart.getItems()) {
	            statement.setInt(1, cart.getUserId());
	            statement.setInt(2, item.getPetId());
	            statement.setInt(3, item.getQuantity());
	            statement.setDouble(4, item.getPrice());
	            statement.setString(5, item.getPetName());
	            statement.setString(6, item.getImageUrl()); // Ajout de l'URL de l'image
	            statement.addBatch();
	        }

	        statement.executeBatch();
	    } catch (SQLException e) {
	        System.err.println("Erreur lors de l'enregistrement du panier : " + e.getMessage());
	        throw e;
	    }
	}

    // Récupérer le panier d'un utilisateur
	public Cart getCartByUserId(int userId) throws SQLException {
	    Cart cart = new Cart(userId);
	    String query = "SELECT pet_id, quantity, price, petName, imageUrl FROM cart WHERE user_id = ?";
	    
	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement statement = connection.prepareStatement(query)) {
	        statement.setInt(1, userId);
	        try (ResultSet resultSet = statement.executeQuery()) {
	            while (resultSet.next()) {
	                CartItem item = new CartItem(
	                    resultSet.getInt("pet_id"),
	                    resultSet.getInt("quantity"),
	                    resultSet.getDouble("price"),
	                    resultSet.getString("petName"),
	                    resultSet.getString("imageUrl") // Récupération de l'URL de l'image
	                );
	                cart.addItem(item);
	            }
	        }
	    } catch (SQLException e) {
	        System.err.println("Erreur lors de la récupération du panier : " + e.getMessage());
	        throw e;
	    }
	    return cart;
	}

    // Mettre à jour la quantité d'un article dans le panier
	public void updateCartItem(int userId, int petId, int newQuantity, String imageUrl) throws SQLException {
	    String query = "UPDATE cart SET quantity = ?, imageUrl = ? WHERE user_id = ? AND pet_id = ?";
	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement statement = connection.prepareStatement(query)) {
	        statement.setInt(1, newQuantity);
	        statement.setString(2, imageUrl); // Optionnel : mise à jour de l'URL de l'image
	        statement.setInt(3, userId);
	        statement.setInt(4, petId);
	        statement.executeUpdate();
	    } catch (SQLException e) {
	        System.err.println("Erreur lors de la mise à jour du panier : " + e.getMessage());
	        throw e;
	    }
	}

    // Supprimer un article du panier
    public void removeCartItem(int userId, int petId) throws SQLException {
        String query = "DELETE FROM cart WHERE user_id = ? AND pet_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            statement.setInt(2, petId);
            statement.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression de l'article du panier : " + e.getMessage());
            throw e;
        }
    }

    // Vider le panier d'un utilisateur
    public void clearCart(int userId) throws SQLException {
        String query = "DELETE FROM cart WHERE user_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            statement.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression du panier : " + e.getMessage());
            throw e;
        }
    }
}