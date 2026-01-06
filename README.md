# 📚 E-Book Management System

A comprehensive e-book management system built using Java (JSP & Servlets), MySQL, and Bootstrap with a modern, responsive design.

![Java](https://img.shields.io/badge/Java-11+-orange?style=for-the-badge&logo=java)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=for-the-badge&logo=mysql)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3-purple?style=for-the-badge&logo=bootstrap)
![Tomcat](https://img.shields.io/badge/Tomcat-10.x-yellow?style=for-the-badge&logo=apache-tomcat)

## 🌟 Features

### 👤 Customer Features
- **Browse Books**: View new and pre-owned books with filtering and search
- **Book Details**: Detailed view of each book with images and descriptions
- **Shopping Cart**: Add, update, and remove items from cart
- **Checkout**: Complete purchase with multiple payment options (COD, UPI, Card)
- **Order History**: View past orders and track status
- **Sell Books**: Submit old books for sale to the store
- **User Profile**: Manage account settings and password
- **Email Notifications**: Order confirmation emails

### 🔧 Admin Features
- **Dashboard**: Overview of sales, orders, and inventory
- **Book Management**: Add, edit, and delete books with cover images
- **Order Management**: View and update order status
- **Low Stock Alerts**: Monitor inventory levels
- **Sales Analytics**: Charts and reports for sales data
- **Sell Request Management**: Approve/reject customer sell requests

## 🛠️ Technology Stack

| Technology | Version |
|------------|---------|
| Java | 11+ |
| Jakarta EE | 9+ |
| MySQL | 8.0 |
| Bootstrap | 5.3 |
| Tomcat | 10.x |
| Maven | 3.9+ |

## 📁 Project Structure

```
src/
├── main/
│   ├── java/
│   │   └── com/
│   │       └── ebook/
│   │           ├── dao/           # Data Access Objects
│   │           ├── filter/        # Servlet Filters
│   │           ├── model/         # Model/Entity Classes
│   │           ├── service/       # Email Service
│   │           ├── servlet/       # Servlet Controllers
│   │           └── util/          # Utility Classes (DB Connection)
│   └── webapp/
│       ├── css/                   # Stylesheets
│       ├── js/                    # JavaScript files
│       ├── images/                # Image assets
│       │   └── books/             # Book cover images
│       └── WEB-INF/
│           ├── views/             # JSP files
│           │   ├── admin/         # Admin panel views
│           │   └── errors/        # Error pages
│           └── web.xml            # Deployment descriptor
│           │   ├── admin/         # Admin pages
│           │   └── errors/        # Error pages
│           └── web.xml            # Deployment descriptor
└── sql/
    └── database_schema.sql        # MySQL database schema
```

## 🚀 Quick Start

### Prerequisites
- **Java JDK 11+** 
- **MySQL 8.0** 
- **Maven 3.9+**

### Local Development Setup

```bash
# 1. Clone the repository
git clone https://github.com/hiteshtripathi676/Book-Store.git
cd Book-Store

# 2. Setup MySQL database
mysql -u root -p < sql/database_schema.sql

# 3. Update database credentials in src/main/java/com/ebook/util/DBConnection.java

# 4. Build and run
mvn clean package cargo:run

# 5. Open browser
# http://localhost:8080/ebook-store
```

### 🔐 Default Login Credentials

| Role | Email | Password |
|------|-------|----------|
| Admin | admin@ebook.com | admin123 |
| Customer | Register new account | - |

## ☁️ Railway Deployment

This project is configured for easy deployment on Railway:

1. **Deploy from GitHub** - Connect your repo
2. **Add MySQL** - Railway provisions MySQL automatically  
3. **Environment Variables** - Auto-configured:
   - `MYSQLHOST`, `MYSQLPORT`, `MYSQLDATABASE`
   - `MYSQLUSER`, `MYSQLPASSWORD`
4. **Import Schema** - Run `database_schema.sql` on Railway MySQL
5. **Generate Domain** - Get your public URL

## 📸 Screenshots

### Home Page
- Browse featured books
- Category-wise filtering
- Search functionality

### Admin Dashboard  
- Sales analytics
- Order management
- Inventory control

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License.

## 👥 Authors

- **Hitesh Tripathi** - *Development* - [hiteshtripathi676](https://github.com/hiteshtripathi676)

---

⭐ **Star this repo if you found it helpful!**
   - Verify multipart configuration

## License

This project is created for educational purposes as a college project.

## Author

Created for Arpita's College Project

---

For any issues or questions, please contact the project maintainer.
