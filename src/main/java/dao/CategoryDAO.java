package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import util.DBConnection;

public class CategoryDAO {

    // Récupérer toutes les catégories
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT id, name, image FROM categories"; // Ajout du champ image

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                category.setImage(rs.getString("image")); // Ajout du champ image
                categories.add(category);
            }
        } catch (SQLException e) {
            // Log l'erreur
            System.err.println("Erreur lors de la récupération des catégories : " + e.getMessage());
            e.printStackTrace();
        }
        return categories;
    }

    // Récupérer une catégorie par son ID
    public Category getCategoryById(int id) {
        String sql = "SELECT id, name, image FROM categories WHERE id = ?"; // Ajout du champ image
        Category category = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    category = new Category();
                    category.setId(rs.getInt("id"));
                    category.setName(rs.getString("name"));
                    category.setImage(rs.getString("image")); // Ajout du champ image
                }
            }
        } catch (SQLException e) {
            // Log l'erreur
            System.err.println("Erreur lors de la récupération de la catégorie par ID : " + e.getMessage());
            e.printStackTrace();
        }
        return category;
    }
}