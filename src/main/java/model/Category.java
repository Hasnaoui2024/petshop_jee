package model;

public class Category {
    private int id;
    private String name;
    private String image; // Nouveau champ pour l'image

    // Constructeur par défaut
    public Category() {
    }

    // Constructeur avec tous les champs
    public Category(int id, String name, String image) {
        this.id = id;
        this.name = name;
        this.image = image;
    }

    // Constructeur sans image (si l'image est optionnelle)
    public Category(int id, String name) {
        this.id = id;
        this.name = name;
    }

    // Getter et Setter pour l'id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Getter et Setter pour le nom
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    // Getter et Setter pour l'image
    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    // Méthode toString mise à jour pour inclure l'image
    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", image='" + image + '\'' +
                '}';
    }
}