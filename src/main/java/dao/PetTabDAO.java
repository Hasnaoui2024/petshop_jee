package dao;

import model.PetTab;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PetTabDAO {
    // Récupérer tous les animaux ou produits
	public List<PetTab> getAllPets() throws SQLException {
	    List<PetTab> pets = new ArrayList<>();
	    String query = "SELECT * FROM pets";
	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement statement = connection.prepareStatement(query);
	         ResultSet resultSet = statement.executeQuery()) {
	        while (resultSet.next()) {
	            PetTab pet = new PetTab(
	                resultSet.getInt("id"),
	                resultSet.getString("name"),
	                resultSet.getInt("category_id"),
	                resultSet.getString("description"),
	                resultSet.getDouble("price"),
	                resultSet.getString("imageUrl") 
	            );
	            pets.add(pet);
	        }
	    } catch (SQLException e) {
	        System.err.println("Erreur lors de la récupération des animaux : " + e.getMessage());
	        throw e;
	    }
	    return pets;
	}

    // Récupérer un animal ou produit par son ID
	public PetTab getPetsById(int id) throws SQLException {
	    String query = "SELECT * FROM pets WHERE id = ?";
	    PetTab pet = null;
	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement statement = connection.prepareStatement(query)) {
	        statement.setInt(1, id);
	        try (ResultSet resultSet = statement.executeQuery()) {
	            if (resultSet.next()) {
	                pet = new PetTab(
	                    resultSet.getInt("id"),
	                    resultSet.getString("name"),
	                    resultSet.getInt("category_id"),
	                    resultSet.getString("description"),
	                    resultSet.getDouble("price"),
	                    resultSet.getString("imageUrl") // Ajout de l'URL de l'image
	                );
	            }
	        }
	    } catch (SQLException e) {
	        System.err.println("Erreur lors de la récupération de l'animal par ID : " + e.getMessage());
	        throw e;
	    }
	    return pet;
	}
    
	public List<PetTab> getPetsByCategory(int categoryId) throws SQLException {
	    List<PetTab> pets = new ArrayList<>();
	    String query = "SELECT * FROM pets WHERE category_id = ?";
	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement statement = connection.prepareStatement(query)) {
	        statement.setInt(1, categoryId);
	        try (ResultSet resultSet = statement.executeQuery()) {
	            while (resultSet.next()) {
	                PetTab pet = new PetTab(
	                    resultSet.getInt("id"),
	                    resultSet.getString("name"),
	                    resultSet.getInt("category_id"),
	                    resultSet.getString("description"),
	                    resultSet.getDouble("price"),
	                    resultSet.getString("imageUrl") // Ajout de l'URL de l'image
	                );
	                pets.add(pet);
	            }
	        }
	    } catch (SQLException e) {
	        System.err.println("Erreur lors de la récupération des animaux par catégorie : " + e.getMessage());
	        throw e;
	    }
	    return pets;
	}
}