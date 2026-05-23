package model;

/**
 * WorkSite.java
 * Model class representing an active/completed work site.
 */
public class WorkSite {
    private int    id;
    private String siteName;
    private String clientName;
    private String clientPhone;
    private String address;
    private String startDate;
    private String expectedEndDate;
    private String actualEndDate;
    private String status;          // active, completed, on_hold, pending
    private double budget;
    private String notes;
    private String createdAt;

    public WorkSite() {}

    public int getId()                      { return id; }
    public void setId(int id)               { this.id = id; }
    public String getSiteName()                 { return siteName; }
    public void setSiteName(String siteName)    { this.siteName = siteName; }
    public String getClientName()                   { return clientName; }
    public void setClientName(String clientName)    { this.clientName = clientName; }
    public String getClientPhone()                      { return clientPhone; }
    public void setClientPhone(String clientPhone)      { this.clientPhone = clientPhone; }
    public String getAddress()                  { return address; }
    public void setAddress(String address)      { this.address = address; }
    public String getStartDate()                { return startDate; }
    public void setStartDate(String startDate)  { this.startDate = startDate; }
    public String getExpectedEndDate()                      { return expectedEndDate; }
    public void setExpectedEndDate(String expectedEndDate)  { this.expectedEndDate = expectedEndDate; }
    public String getActualEndDate()                    { return actualEndDate; }
    public void setActualEndDate(String actualEndDate)  { this.actualEndDate = actualEndDate; }
    public String getStatus()               { return status; }
    public void setStatus(String status)    { this.status = status; }
    public double getBudget()               { return budget; }
    public void setBudget(double budget)    { this.budget = budget; }
    public String getNotes()                { return notes; }
    public void setNotes(String notes)      { this.notes = notes; }
    public String getCreatedAt()                { return createdAt; }
    public void setCreatedAt(String createdAt)  { this.createdAt = createdAt; }
}