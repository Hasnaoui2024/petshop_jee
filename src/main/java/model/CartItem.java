package model;
public class CartItem {
    private int petId;
    private int quantity;
    private double price;
    private String petName;
    private String imageUrl;

    public CartItem(int petId, int quantity, double price, String petName, String imageUrl) {
        this.petId = petId;
        this.quantity = quantity;
        this.price = price;
        this.petName = petName;
        this.imageUrl = imageUrl;
    }

    public int getPetId() {
        return petId;
    }

    public int getQuantity() {
        return quantity;
    }

    public double getPrice() {
        return price;
    }

    public String getPetName() {
        return petName;
    }
    public double getTotal() {
        return this.quantity * this.price;
    }

	public void setQuantity(int newQuantity) {
		this.quantity=newQuantity;
		
	}
	
	public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
}