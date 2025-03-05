package service;

import dao.CategoryDAO;
import model.Category;

import java.sql.SQLException;
import java.util.List;

public class CategoryService {
    private CategoryDAO categoryDAO;

    // Constructeur
    public CategoryService() {
        this.categoryDAO = new CategoryDAO();
    }

    // Récupérer toutes les catégories
    public List<Category> getAllCategories() throws SQLException {
        return categoryDAO.getAllCategories();
    }

    

    // Récupérer une catégorie par son ID
    public Category getCategoryById(int id) throws SQLException {
        if (id <= 0) {
            throw new IllegalArgumentException("L'ID de la catégorie doit être un entier positif.");
        }

        Category category = categoryDAO.getCategoryById(id);
        if (category == null) {
            throw new IllegalArgumentException("Aucune catégorie trouvée avec cet ID.");
        }

        return category;
    }

    
}