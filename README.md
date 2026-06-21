# 🪑 RK GROUP FURNITURES & INTERIOR
### Premium Furniture & Interior Design Management System

![Java](https://img.shields.io/badge/Java-17-orange?style=flat-square&logo=java)
![JSP](https://img.shields.io/badge/JSP-Servlet-blue?style=flat-square)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=flat-square&logo=mysql)
![Tomcat](https://img.shields.io/badge/Tomcat-10.1-yellow?style=flat-square)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3-purple?style=flat-square&logo=bootstrap)
![Cloudinary](https://img.shields.io/badge/Cloudinary-Image%20Upload-green?style=flat-square)

---

## 📌 About The Project

**RK GROUP FURNITURES & INTERIOR** is a complete full-stack web application built for a real furniture and interior design business based in **Bhopal, Madhya Pradesh**.

This system helps manage:
- 🖼️ Gallery & portfolio of completed projects
- 🛒 Product catalog with online inquiry
- 📅 Site visit bookings
- 💬 Customer inquiries & feedback
- 🏗️ Active work site management
- 👷 Worker/employee management
- 🔐 Secure admin panel

> **Owner:** Rahul Vishwakarma | **Phone:** 7772897077 | **Email:** rahulvishwakarma111999@gmail.com

---

## 🚀 Live Demo

🌐 **Live URL:** [Deployed on Railway.app](https://rk-group-furnitures.up.railway.app)

---

## 🛠️ Technology Stack

| Layer | Technology |
|---|---|
| **Backend** | Java 17, Servlet, JSP |
| **Database** | MySQL 8.0, JDBC |
| **Frontend** | HTML5, CSS3, Bootstrap 5.3, JavaScript |
| **Icons** | Bootstrap Icons |
| **Fonts** | Google Fonts (Poppins, Playfair Display) |
| **Image Upload** | Cloudinary API |
| **Server** | Apache Tomcat 10.1 |
| **Build Tool** | Maven |
| **Deployment** | Railway.app (Docker) |

---

## ✨ Features

### 🌐 Public Website
- ✅ **Home Page** — Hero section, services, why choose us, testimonials, contact form
- ✅ **About Us** — Company story, mission, vision, owner profile
- ✅ **Gallery** — Project portfolio with category filter (Interior, Kitchen, Furniture, etc.)
- ✅ **Products** — Product catalog with search, price, stock status
- ✅ **Contact** — Inquiry form with WhatsApp integration
- ✅ **Book Visit** — Free site visit booking form
- ✅ **Feedback** — Customer reviews with star rating system

### 🔐 Admin Panel
- ✅ **Secure Login** — Session-based authentication
- ✅ **Dashboard** — Summary cards (inquiries, products, sites, workers)
- ✅ **Gallery Management** — Upload images & videos via Cloudinary
- ✅ **Product Management** — Add, edit, delete products with images
- ✅ **Inquiry Management** — View, status update, WhatsApp/call reply
- ✅ **Booking Management** — Approve/reject bookings, notify customer
- ✅ **Feedback Management** — View and delete customer reviews
- ✅ **Work Site Management** — Track active/completed project sites
- ✅ **Worker Management** — Manage employees, skills, salary, site assignment

---

## 📁 Project Structure

```
RKGroupFurnitures/
├── database/
│   └── rk_group.sql              ← Run this in MySQL first
├── Dockerfile                     ← Docker deployment
├── docker-compose.yml             ← Local testing
├── pom.xml                        ← Maven dependencies
└── src/main/
    ├── java/
    │   ├── controller/            ← Servlets (URL handlers)
    │   │   ├── AdminServlet.java
    │   │   ├── ProductServlet.java
    │   │   ├── GalleryServlet.java
    │   │   ├── InquiryServlet.java
    │   │   ├── BookingServlet.java
    │   │   ├── FeedbackServlet.java
    │   │   ├── WorkerServlet.java
    │   │   └── SiteServlet.java
    │   ├── dao/                   ← Database queries (JDBC)
    │   │   ├── AdminDAO.java
    │   │   ├── ProductDAO.java
    │   │   ├── GalleryDAO.java
    │   │   ├── InquiryDAO.java
    │   │   ├── BookingDAO.java
    │   │   ├── FeedbackDAO.java
    │   │   ├── WorkerDAO.java
    │   │   └── SiteDAO.java
    │   ├── model/                 ← POJO / Entity classes
    │   │   ├── Admin.java
    │   │   ├── Product.java
    │   │   ├── Gallery.java
    │   │   ├── Inquiry.java
    │   │   ├── Booking.java
    │   │   ├── Feedback.java
    │   │   ├── Worker.java
    │   │   └── WorkSite.java
    │   └── util/
    │       ├── DBConnection.java  ← JDBC connection
    │       ├── FileUpload.java    ← Local file upload
    │       └── CloudinaryUpload.java ← Cloudinary integration
    └── webapp/
        ├── css/
        │   ├── style.css          ← Public website (Light Luxury theme)
        │   └── admin.css          ← Admin panel styles
        ├── js/
        │   ├── main.js            ← Public animations & interactions
        │   └── admin.js           ← Admin panel JS
        ├── uploads/               ← Local image uploads
        ├── WEB-INF/
        │   └── web.xml
        ├── index.jsp              ← Home page
        ├── about.jsp              ← About page
        └── jsp/
            ├── public/
            │   ├── gallery.jsp
            │   ├── products.jsp
            │   ├── contact.jsp
            │   ├── booking.jsp
            │   └── feedback.jsp
            └── admin/
                ├── login.jsp
                ├── dashboard.jsp
                ├── gallery.jsp
                ├── products.jsp
                ├── inquiries.jsp
                ├── bookings.jsp
                ├── feedback.jsp
                ├── workers.jsp
                └── sites.jsp
```

---

## 🗄️ Database Schema

```sql
admins       — Admin login credentials
categories   — Product & gallery categories
gallery      — Portfolio project images & videos
products     — Product catalog
inquiries    — Customer contact form submissions
bookings     — Site visit booking requests
feedback     — Customer reviews & ratings
work_sites   — Active/completed work sites
workers      — Employee management
```

---

## ⚙️ Local Setup Guide

### Prerequisites
- Java JDK 17+
- Apache Tomcat 10.1
- MySQL 8.0
- Eclipse IDE (Enterprise Edition)
- Maven

### Step 1 — Clone the Repository
```bash
git clone https://github.com/Shani123vish/rk-group-furnitures.git
cd rk-group-furnitures
```

### Step 2 — Setup Database
```bash
# Open MySQL Workbench or terminal
mysql -u root -p
source database/rk_group.sql
```

### Step 3 — Configure Database Connection
Edit `src/main/java/util/DBConnection.java`:
```java
private static final String DB_URL  = "jdbc:mysql://localhost:3306/rk_group_db";
private static final String DB_USER = "root";
private static final String DB_PASS = "your_password";  // ← Change this
```

### Step 4 — Import in Eclipse
```
File → Import → Maven → Existing Maven Projects → Select folder → Finish
```

### Step 5 — Add Tomcat Server
```
Window → Preferences → Server → Runtime Environments → Add → Apache Tomcat v10.1
```

### Step 6 — Run
```
Right click project → Run As → Run on Server → Select Tomcat → Finish
```

### Step 7 — Access
```
Website:  http://localhost:8080/RKGroupFurnituresInterior/
Admin:    http://localhost:8080/RKGroupFurnituresInterior/admin/login

Default Login:
  Username: admin
  Password: admin123
```

---

## 🐳 Docker Setup (Local Testing)

```bash
# Start everything with one command
docker-compose up --build

# Access at
http://localhost:8080
```

---

## ☁️ Deployment (Railway.app)

### Environment Variables Required:
```
DB_URL    = jdbc:mysql://HOST:PORT/railway?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Kolkata
DB_USER   = root
DB_PASS   = your_railway_mysql_password

CLOUDINARY_CLOUD_NAME = your_cloud_name
CLOUDINARY_API_KEY    = your_api_key
CLOUDINARY_API_SECRET = your_api_secret
```

### Deploy Steps:
```bash
# 1. Push to GitHub
git add .
git commit -m "Deploy"
git push

# 2. Railway auto-detects Dockerfile and deploys
# 3. Set environment variables in Railway dashboard
# 4. Railway generates live URL automatically
```

---

## 📸 Screenshots

| Page | Description |
|---|---|
| Home | Premium landing page with hero, services, testimonials |
| Gallery | Portfolio grid with category filter + video support |
| Products | Product catalog with search and inquiry modal |
| Admin Dashboard | Stats cards, quick actions |
| Admin Gallery | Image/video upload via Cloudinary |

---

## 🔗 URL Structure

| URL | Page |
|---|---|
| `/` | Home Page |
| `/about.jsp` | About Us |
| `/gallery` | Gallery |
| `/products` | Products |
| `/jsp/public/contact.jsp` | Contact |
| `/booking` | Book a Visit |
| `/feedback` | Customer Feedback |
| `/admin/login` | Admin Login |
| `/admin/dashboard` | Admin Dashboard |
| `/admin/gallery` | Manage Gallery |
| `/admin/products` | Manage Products |
| `/admin/inquiries` | View Inquiries |
| `/admin/bookings` | Manage Bookings |
| `/admin/feedback` | Manage Feedback |
| `/admin/sites` | Work Sites |
| `/admin/workers` | Workers |

---

## 👨‍💻 Developer

**Project built by:** Shani Vishwakarma

**Business Owner:** Rahul Vishwakarma
- 📞 Phone: 7772897077
- 📧 Email: rahulvishwakarma111999@gmail.com
- 📍 Location: Rewa, Madhya Pradesh
- 🗺️ [Google Maps](https://maps.app.goo.gl/g78BgUACNh3cK3iz8?g_st=aw)

---

## 📄 License

This project is built for **RK GROUP FURNITURES & INTERIOR** — a real business project.
All rights reserved © 2024 RK GROUP FURNITURES & INTERIOR.

---

<div align="center">
  <strong>Built with ❤️ using Java Servlet + JSP + JDBC + MySQL</strong>
</div>
