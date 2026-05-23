package model;

/**
 * Gallery.java
 * Model class for gallery/portfolio project entries.
 */
public class Gallery {

    private int    id;
    private String title;
    private String description;
    private String location;
    private int    categoryId;
    private String categoryName;   // from JOIN
    private String imageFilename;
    private String completionDate;
    private boolean active;
    private String createdAt;

    public Gallery() {}

    public int getId()                  { return id; }
    public void setId(int id)           { this.id = id; }

    public String getTitle()            { return title; }
    public void setTitle(String title)  { this.title = title; }

    public String getDescription()                  { return description; }
    public void setDescription(String description)  { this.description = description; }

    public String getLocation()                 { return location; }
    public void setLocation(String location)    { this.location = location; }

    public int getCategoryId()                      { return categoryId; }
    public void setCategoryId(int categoryId)       { this.categoryId = categoryId; }

    public String getCategoryName()                     { return categoryName; }
    public void setCategoryName(String categoryName)    { this.categoryName = categoryName; }

    public String getImageFilename()                        { return imageFilename; }
    public void setImageFilename(String imageFilename)      { this.imageFilename = imageFilename; }

    public String getCompletionDate()                       { return completionDate; }
    public void setCompletionDate(String completionDate)    { this.completionDate = completionDate; }

    public boolean isActive()               { return active; }
    public void setActive(boolean active)   { this.active = active; }

    public String getCreatedAt()                { return createdAt; }
    public void setCreatedAt(String createdAt)  { this.createdAt = createdAt; }
}