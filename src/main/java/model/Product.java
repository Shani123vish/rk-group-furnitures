package model;

/**
 * Product.java
 * --------------------------------------------------
 * Model class representing a row in the 'products' table.
 * A "model" class just holds data - no database logic here.
 * It uses getters and setters to access the data.
 * --------------------------------------------------
 */
public class Product {

    private int    id;
    private String name;
    private String description;
    private double price;
    private int    categoryId;
    private String categoryName;    // loaded with JOIN from categories table
    private String imageFilename;
    private String stockStatus;     // "in_stock", "out_of_stock", "on_order"
    private boolean active;
    private String createdAt;

    // Default constructor (required for creating empty objects)
    public Product() {}

    // ---- Getters and Setters ----
    // Getters: read the value   | Setters: change the value

    public int getId()                    { return id; }
    public void setId(int id)             { this.id = id; }

    public String getName()               { return name; }
    public void setName(String name)      { this.name = name; }

    public String getDescription()                    { return description; }
    public void setDescription(String description)    { this.description = description; }

    public double getPrice()              { return price; }
    public void setPrice(double price)    { this.price = price; }

    public int getCategoryId()                { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public String getCategoryName()                       { return categoryName; }
    public void setCategoryName(String categoryName)      { this.categoryName = categoryName; }

    public String getImageFilename()                          { return imageFilename; }
    public void setImageFilename(String imageFilename)        { this.imageFilename = imageFilename; }

    public String getStockStatus()                    { return stockStatus; }
    public void setStockStatus(String stockStatus)    { this.stockStatus = stockStatus; }

    public boolean isActive()                 { return active; }
    public void setActive(boolean active)     { this.active = active; }

    public String getCreatedAt()              { return createdAt; }
    public void setCreatedAt(String createdAt){ this.createdAt = createdAt; }
}