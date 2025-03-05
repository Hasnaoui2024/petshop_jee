package model;

import java.util.ArrayList;
import java.util.List;

public class Cart {
    private int userId;
    private List<CartItem> items;

    public Cart(int userId) {
        this.userId = userId;
        this.items = new ArrayList<>();
    }

    public void addItem(CartItem item) {
        this.items.add(item);
    }

    public List<CartItem> getItems() {
        return items;
    }

    public int getUserId() {
        return userId;
    }
}
