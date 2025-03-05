package dao;

import model.User;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // Requêtes SQL
    private static final String SELECT_ALL_USERS = "SELECT * FROM users";
    private static final String INSERT_USER = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
    private static final String DELETE_USER = "DELETE FROM users WHERE id = ?";
    private static final String SELECT_USER_BY_ID = "SELECT * FROM users WHERE id = ?";
    private static final String UPDATE_USER = "UPDATE users SET name = ?, email = ?, password = ? WHERE id = ?";

    // Récupérer tous les utilisateurs
    public List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(SELECT_ALL_USERS);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                User user = new User(
                    resultSet.getInt("id"),
                    resultSet.getString("username"),
                    resultSet.getString("email"),
                    resultSet.getString("password")
                );
                users.add(user);
            }
        } catch (SQLException e) {
            // Log l'erreur et la relancer pour que l'appelant puisse la gérer
            System.err.println("Erreur lors de la récupération des utilisateurs : " + e.getMessage());
            throw e;
        }
        return users;
    }

    // Ajouter un utilisateur
    public boolean addUser(User user) throws SQLException {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(INSERT_USER)) {

            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPassword());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            // Log l'erreur et la relancer pour que l'appelant puisse la gérer
            System.err.println("Erreur lors de l'ajout de l'utilisateur : " + e.getMessage());
            throw e;
        }
    }

    // Supprimer un utilisateur par son ID
    public boolean deleteUser(int id) throws SQLException {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(DELETE_USER)) {

            statement.setInt(1, id);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            // Log l'erreur et la relancer pour que l'appelant puisse la gérer
            System.err.println("Erreur lors de la suppression de l'utilisateur : " + e.getMessage());
            throw e;
        }
    }

    // Récupérer un utilisateur par son ID
    public User getUserById(int id) throws SQLException {
        User user = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(SELECT_USER_BY_ID)) {

            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    user = new User(
                        resultSet.getInt("id"),
                        resultSet.getString("username"),
                        resultSet.getString("email"),
                        resultSet.getString("password")
                    );
                }
            }
        } catch (SQLException e) {
            // Log l'erreur et la relancer pour que l'appelant puisse la gérer
            System.err.println("Erreur lors de la récupération de l'utilisateur par ID : " + e.getMessage());
            throw e;
        }
        return user;
    }

    // Mettre à jour un utilisateur
    public boolean updateUser(User user) throws SQLException {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(UPDATE_USER)) {

            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPassword());
            statement.setInt(4, user.getId());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            // Log l'erreur et la relancer pour que l'appelant puisse la gérer
            System.err.println("Erreur lors de la mise à jour de l'utilisateur : " + e.getMessage());
            throw e;
        }
    }
}