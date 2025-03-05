package service;

import dao.UserDAO;
import model.User;

import java.sql.SQLException;
import java.util.List;

public class UserService {
    private UserDAO userDAO;

    // Constructeur
    public UserService() {
        this.userDAO = new UserDAO();
    }

    // Récupérer un utilisateur par son ID
    public User getUserById(int id) throws SQLException {
        if (id <= 0) {
            throw new IllegalArgumentException("L'ID de l'utilisateur doit être un entier positif.");
        }

        User user = userDAO.getUserById(id);
        if (user == null) {
            throw new IllegalArgumentException("Aucun utilisateur trouvé avec cet ID.");
        }

        return user;
    }

    // Enregistrer un nouvel utilisateur
    public boolean registerUser(User user) throws SQLException {
        // Logique métier : vérifier si l'email est déjà utilisé
        if (user == null || user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            throw new IllegalArgumentException("L'email de l'utilisateur ne peut pas être vide.");
        }

        if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
            throw new IllegalArgumentException("Le mot de passe de l'utilisateur ne peut pas être vide.");
        }

        // Vérifier si l'email est déjà utilisé
        List<User> existingUsers = userDAO.getAllUsers();
        for (User existingUser : existingUsers) {
            if (existingUser.getEmail().equalsIgnoreCase(user.getEmail())) {
                throw new IllegalArgumentException("Un utilisateur avec cet email existe déjà.");
            }
        }

        return userDAO.addUser(user);
    }

    // Supprimer un utilisateur par son ID
    public boolean deleteUser(int id) throws SQLException {
        if (id <= 0) {
            throw new IllegalArgumentException("L'ID de l'utilisateur doit être un entier positif.");
        }

        // Vérifier si l'utilisateur existe avant de le supprimer
        User user = userDAO.getUserById(id);
        if (user == null) {
            throw new IllegalArgumentException("Aucun utilisateur trouvé avec cet ID.");
        }

        return userDAO.deleteUser(id);
    }

    // Récupérer tous les utilisateurs
    public List<User> getAllUsers() throws SQLException {
        return userDAO.getAllUsers();
    }

    // Mettre à jour un utilisateur
    public boolean updateUser(User user) throws SQLException {
        if (user == null || user.getId() <= 0 || user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            throw new IllegalArgumentException("Les données de l'utilisateur sont invalides.");
        }

        // Vérifier si l'utilisateur existe avant de le mettre à jour
        User existingUser = userDAO.getUserById(user.getId());
        if (existingUser == null) {
            throw new IllegalArgumentException("Aucun utilisateur trouvé avec cet ID.");
        }

        // Vérifier si le nouvel email est déjà utilisé par un autre utilisateur
        List<User> existingUsers = userDAO.getAllUsers();
        for (User u : existingUsers) {
            if (u.getEmail().equalsIgnoreCase(user.getEmail()) && u.getId() != user.getId()) {
                throw new IllegalArgumentException("Un utilisateur avec cet email existe déjà.");
            }
        }

        return userDAO.updateUser(user);
    }
}