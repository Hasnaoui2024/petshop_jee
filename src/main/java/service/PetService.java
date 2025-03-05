package service;

import dao.PetTabDAO;
import model.PetTab;

import java.sql.SQLException;
import java.util.List;

public class PetService {
    private PetTabDAO petTabDAO;

    // Constructeur
    public PetService() {
        this.petTabDAO = new PetTabDAO();
    }

    // Récupérer tous les animaux
    public List<PetTab> getAllPets() throws SQLException {
        return petTabDAO.getAllPets();
    }

    

    

    // Récupérer un animal par son ID
    public PetTab getPetById(int id) throws SQLException {
        if (id <= 0) {
            throw new IllegalArgumentException("L'ID de l'animal doit être un entier positif.");
        }
        return petTabDAO.getPetsById(id);
    }

    
}