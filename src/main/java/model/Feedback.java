package model;

/**
 * Feedback.java
 * Customer feedback/review model.
 */
public class Feedback {
    private int    id;
    private String name;
    private String phone;
    private String location;
    private int    rating;      // 1 to 5
    private String message;
    private boolean active;
    private String createdAt;

    public Feedback() {}

    public int getId()                      { return id; }
    public void setId(int id)               { this.id = id; }
    public String getName()                 { return name; }
    public void setName(String name)        { this.name = name; }
    public String getPhone()                { return phone; }
    public void setPhone(String phone)      { this.phone = phone; }
    public String getLocation()                 { return location; }
    public void setLocation(String location)    { this.location = location; }
    public int getRating()                  { return rating; }
    public void setRating(int rating)       { this.rating = rating; }
    public String getMessage()                  { return message; }
    public void setMessage(String message)      { this.message = message; }
    public boolean isActive()               { return active; }
    public void setActive(boolean active)   { this.active = active; }
    public String getCreatedAt()                { return createdAt; }
    public void setCreatedAt(String createdAt)  { this.createdAt = createdAt; }
}
