package model;

/** Inquiry.java - Customer contact form submission */
public class Inquiry {
    private int    id;
    private String name;
    private String phone;
    private String email;
    private String message;
    private int    productId;
    private String productName;  // from JOIN
    private String status;       // "new", "read", "replied"
    private String createdAt;

    public Inquiry() {}

    public int getId()                  { return id; }
    public void setId(int id)           { this.id = id; }
    public String getName()             { return name; }
    public void setName(String name)    { this.name = name; }
    public String getPhone()            { return phone; }
    public void setPhone(String phone)  { this.phone = phone; }
    public String getEmail()            { return email; }
    public void setEmail(String email)  { this.email = email; }
    public String getMessage()                  { return message; }
    public void setMessage(String message)      { this.message = message; }
    public int getProductId()                   { return productId; }
    public void setProductId(int productId)     { this.productId = productId; }
    public String getProductName()                  { return productName; }
    public void setProductName(String productName)  { this.productName = productName; }
    public String getStatus()               { return status; }
    public void setStatus(String status)    { this.status = status; }
    public String getCreatedAt()                { return createdAt; }
    public void setCreatedAt(String createdAt)  { this.createdAt = createdAt; }
}