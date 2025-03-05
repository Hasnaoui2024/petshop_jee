package model;

public class PetTab {
    private int id;
    private String name;
    private int categoryId;
    private String description;
    private double price;
    private String imageUrl;

    public PetTab(int id, String name, int categoryId, String description, double price, String imageUrl) {
        this.id = id;
        this.name = name;
        this.categoryId = categoryId;
        this.description = description;
        this.price = price;
        this.imageUrl=imageUrl;
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    
    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}