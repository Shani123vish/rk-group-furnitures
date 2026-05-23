package model;

/** Booking.java - Site visit / consultation booking */
public class Booking {
    private int    id;
    private String customerName;
    private String phone;
    private String email;
    private String address;
    private String visitDate;
    private String message;
    private String status;      // pending, approved, rejected, completed
    private String adminNotes;
    private String createdAt;

    public Booking() {}

    public int getId()                      { return id; }
    public void setId(int id)               { this.id = id; }
    public String getCustomerName()                     { return customerName; }
    public void setCustomerName(String customerName)    { this.customerName = customerName; }
    public String getPhone()                { return phone; }
    public void setPhone(String phone)      { this.phone = phone; }
    public String getEmail()                { return email; }
    public void setEmail(String email)      { this.email = email; }
    public String getAddress()                  { return address; }
    public void setAddress(String address)      { this.address = address; }
    public String getVisitDate()                { return visitDate; }
    public void setVisitDate(String visitDate)  { this.visitDate = visitDate; }
    public String getMessage()                  { return message; }
    public void setMessage(String message)      { this.message = message; }
    public String getStatus()               { return status; }
    public void setStatus(String status)    { this.status = status; }
    public String getAdminNotes()                   { return adminNotes; }
    public void setAdminNotes(String adminNotes)    { this.adminNotes = adminNotes; }
    public String getCreatedAt()                { return createdAt; }
    public void setCreatedAt(String createdAt)  { this.createdAt = createdAt; }
}