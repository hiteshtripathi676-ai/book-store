# E-Book Management System

A comprehensive e-book management system built using Java (JSP & Servlets), MySQL, and Bootstrap with a clean blue and white theme.

## Features

### Customer Features
- **Browse Books**: View new and pre-owned books with filtering and search
- **Book Details**: Detailed view of each book with images and descriptions
- **Shopping Cart**: Add, update, and remove items from cart
- **Checkout**: Complete purchase with multiple payment options
- **Order History**: View past orders and track status
- **Sell Books**: Submit old books for sale to the store
- **User Profile**: Manage account settings and password

### Admin Features
- **Dashboard**: Overview of sales, orders, and inventory
- **Book Management**: Add, edit, and delete books
- **Order Management**: View and update order status
- **Low Stock Alerts**: Monitor inventory levels
- **Sales Analytics**: Charts and reports for sales data

## Technology Stack

- **Backend**: Java Servlets, JSP, JDBC
- **Frontend**: Bootstrap 5.3, Font Awesome 6.4, HTML5, CSS3, JavaScript
- **Database**: MySQL 8.0
- **Server**: Apache Tomcat 10.x (or compatible)
- **Build Tool**: Maven

## Project Structure

```
src/
├── main/
│   ├── java/
│   │   └── com/
│   │       └── ebook/
│   │           ├── dao/           # Data Access Objects
│   │           ├── filter/        # Servlet Filters
│   │           ├── model/         # Model/Entity Classes
│   │           ├── servlet/       # Servlet Controllers
│   │           └── util/          # Utility Classes
│   └── webapp/
│       ├── css/                   # Stylesheets
│       ├── js/                    # JavaScript files
│       ├── images/                # Image assets
│       │   └── books/             # Book cover images
│       └── WEB-INF/
│           ├── views/             # JSP files
│           │   ├── admin/         # Admin pages
│           │   └── errors/        # Error pages
│           └── web.xml            # Deployment descriptor
└── sql/
    └── database_schema.sql        # MySQL database schema
```

## Setup Instructions

### Prerequisites
1. **Java JDK 11+** installed
2. **Apache Tomcat 10.x** installed
3. **MySQL 8.0** installed and running
4. **Maven** installed (optional, for building)

### Database Setup

1. Open MySQL command line or MySQL Workbench
2. Create the database:
   ```sql
   CREATE DATABASE ebook_store;
   ```
3. Run the database schema file:
   ```sql
   SOURCE path/to/sql/database_schema.sql;
   ```
   Or copy and paste the contents of `sql/database_schema.sql` into MySQL

### Application Configuration

1. Update database connection settings in `src/main/java/com/ebook/util/DBConnection.java`:
   ```java
   private static final String URL = "jdbc:mysql://localhost:3306/ebook_store";
   private static final String USER = "your_mysql_username";
   private static final String PASSWORD = "your_mysql_password";
   ```

### Deployment

#### Option 1: Using Maven (Recommended)
```bash
# Navigate to project directory
cd Arpita-project

# Build the project
mvn clean package

# The WAR file will be created in target/ebook-store.war
# Deploy it to Tomcat's webapps folder
```

#### Option 2: Manual Deployment
1. Copy the entire project to Tomcat's webapps folder
2. Rename the folder to `ebook-store`
3. Start Tomcat

### Running the Application

1. Start Apache Tomcat
2. Open browser and navigate to: `http://localhost:8080/ebook-store`

### Default Login Credentials

**Admin Account:**
- Email: admin@ebook.com
- Password: admin123

**Sample Customer Account:**
- You can register a new customer account through the registration page

## Images Folder

Create a folder for book images:
- Create directory: `src/main/webapp/images/books/`
- Add book cover images to this folder
- Upload images through the admin panel when adding books

## API Endpoints

### Public Routes
- `GET /home` - Home page
- `GET /books` - Browse all books
- `GET /book-details?id={id}` - Book details
- `GET /search?q={query}` - Search books
- `GET /login` - Login page
- `POST /login` - Process login
- `GET /register` - Registration page
- `POST /register` - Process registration

### Customer Routes (Require Login)
- `GET /cart` - View cart
- `POST /cart/add` - Add to cart
- `POST /cart/update` - Update cart quantity
- `POST /cart/remove` - Remove from cart
- `GET /checkout` - Checkout page
- `POST /checkout` - Process checkout
- `GET /profile` - User profile
- `POST /profile/update` - Update profile
- `GET /my-orders` - Order history
- `GET /sell-book` - Sell book page
- `POST /sell-book` - Submit book for sale

### Admin Routes (Require Admin Login)
- `GET /admin/dashboard` - Admin dashboard
- `GET /admin/books` - Manage books
- `GET /admin/add-book` - Add book page
- `POST /admin/add-book` - Create book
- `GET /admin/edit-book?id={id}` - Edit book page
- `POST /admin/edit-book` - Update book
- `POST /admin/delete-book` - Delete book
- `GET /admin/orders` - Manage orders
- `POST /admin/orders/update-status` - Update order status
- `GET /admin/analytics` - Sales analytics
- `GET /admin/low-stock` - Low stock alerts

## Customization

### Changing the Theme Color
Edit `src/main/webapp/css/style.css` and modify the CSS variables:
```css
:root {
    --primary-color: #0d6efd;  /* Change this to your preferred color */
    --primary-dark: #0a58ca;
    --primary-light: #cfe2ff;
}
```

### Adding New Categories
Run the following SQL:
```sql
INSERT INTO categories (name, description) VALUES ('Category Name', 'Description');
```

## Troubleshooting

### Common Issues

1. **Database Connection Error**
   - Verify MySQL is running
   - Check connection credentials in DBConnection.java
   - Ensure MySQL Connector JAR is in the classpath

2. **404 Page Not Found**
   - Check if the application is deployed correctly
   - Verify the context path in the URL

3. **JSP Errors**
   - Ensure JSTL library is included
   - Check Tomcat version compatibility

4. **Image Upload Issues**
   - Create the images/books directory
   - Check file permissions
   - Verify multipart configuration

## License

This project is created for educational purposes as a college project.

## Author

Created for Arpita's College Project

---

For any issues or questions, please contact the project maintainer.
