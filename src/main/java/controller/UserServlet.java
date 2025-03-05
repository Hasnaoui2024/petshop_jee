package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.UserService;
import model.User;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
    private UserService userService;

    public UserServlet() {
        this.userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Récupérer la session sans en créer une nouvelle
        if (session != null && session.getAttribute("userId") == null) {
            request.setAttribute("error", "Your session has expired due to inactivity. Please log in again to continue.");
        }

        try {
            request.setAttribute("users", userService.getAllUsers());
            request.getRequestDispatcher("users.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database Error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            handleLogin(request, response);
        } else if ("register".equals(action)) {
            handleRegister(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action non reconnue");
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            List<User> users = userService.getAllUsers();
            User user = users.stream()
                    .filter(u -> u.getName().equals(username) && u.getPassword().equals(password))
                    .findFirst()
                    .orElse(null);

            if (user != null) {
                HttpSession session = request.getSession(true);
                session.setAttribute("userId", user.getId());
                response.sendRedirect("index.jsp");
            } else {
                request.setAttribute("error", "The account you entered does not exist. Please check your credentials or create a new account.");
                request.getRequestDispatcher("myaccount.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de la connexion");
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "L'email ne peut pas être vide.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        User newUser = new User(0, username, email, password);
        try {
            boolean isRegistered = userService.registerUser(newUser);

            if (isRegistered) {
                response.sendRedirect("myaccount.jsp");
            } else {
                request.setAttribute("error", "Erreur lors de l'inscription");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "The account you entered already exists. Please log in or use the password recovery option if needed.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de l'inscription");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur inconnue lors de l'inscription");
        }
    }
    
}