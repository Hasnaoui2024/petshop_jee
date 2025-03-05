package controller;

import dao.PetTabDAO;
import model.PetTab;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/pets")
public class PetServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String categoryIdParam = request.getParameter("categoryId");
        if (categoryIdParam == null || categoryIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Category ID is required.");
            return;
        }

        try {
            int categoryId = Integer.parseInt(categoryIdParam);
            PetTabDAO petDAO = new PetTabDAO();
            List<PetTab> pets = petDAO.getPetsByCategory(categoryId);

            // Transmettre la liste des produits à la page JSP
            request.setAttribute("pets", pets);
            request.getRequestDispatcher("list_pets_by_category.jsp").forward(request, response);
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database Error: " + e.getMessage());
        }
    }
}