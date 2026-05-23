package model;

/**
 * Worker.java
 * Model class representing a worker/employee.
 */
public class Worker {
    private int    id;
    private String name;
    private String phone;
    private String skill;
    private double dailySalary;
    private int    siteId;
    private String siteName;        // from JOIN with work_sites
    private String attendanceNote;
    private boolean active;
    private String joinedDate;
    private String createdAt;

    public Worker() {}

    public int getId()                      { return id; }
    public void setId(int id)               { this.id = id; }
    public String getName()                 { return name; }
    public void setName(String name)        { this.name = name; }
    public String getPhone()                { return phone; }
    public void setPhone(String phone)      { this.phone = phone; }
    public String getSkill()                { return skill; }
    public void setSkill(String skill)      { this.skill = skill; }
    public double getDailySalary()                      { return dailySalary; }
    public void setDailySalary(double dailySalary)      { this.dailySalary = dailySalary; }
    public int getSiteId()                  { return siteId; }
    public void setSiteId(int siteId)       { this.siteId = siteId; }
    public String getSiteName()                 { return siteName; }
    public void setSiteName(String siteName)    { this.siteName = siteName; }
    public String getAttendanceNote()                       { return attendanceNote; }
    public void setAttendanceNote(String attendanceNote)    { this.attendanceNote = attendanceNote; }
    public boolean isActive()               { return active; }
    public void setActive(boolean active)   { this.active = active; }
    public String getJoinedDate()                   { return joinedDate; }
    public void setJoinedDate(String joinedDate)    { this.joinedDate = joinedDate; }
    public String getCreatedAt()                { return createdAt; }
    public void setCreatedAt(String createdAt)  { this.createdAt = createdAt; }
}