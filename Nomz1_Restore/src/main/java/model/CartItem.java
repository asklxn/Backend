package model;

public class CartItem {
    private int cartItemId;
    private int memberId;
    private int productId;
    private String name;
    private String imageUrl;
    private int price;
    private int count;

    // Getter & Setter
    public int getCartItemId() { return cartItemId; }
    public void setCartItemId(int cartItemId) { this.cartItemId = cartItemId; }

    public int getMemberId() { return memberId; }
    public void setMemberId(int memberId) { this.memberId = memberId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }

    public int getCount() { return count; }
    public void setCount(int count) { this.count = count; }
}
