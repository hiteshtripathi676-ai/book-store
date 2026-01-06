package com.ebook.util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.SQLException;
import java.sql.ResultSet;

/**
 * Automatically initializes database tables on application startup
 */
@WebListener
public class DatabaseInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("========================================");
        System.out.println("Starting Database Initialization...");
        System.out.println("========================================");
        
        try {
            initializeDatabase();
            System.out.println("Database initialization completed successfully!");
        } catch (Exception e) {
            System.err.println("Database initialization failed: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Application shutting down...");
    }

    private void initializeDatabase() {
        Connection conn = null;
        Statement stmt = null;
        
        try {
            conn = DBConnection.getNewConnection();
            if (conn == null) {
                throw new SQLException("Could not establish database connection");
            }
            
            stmt = conn.createStatement();
            
            // Check if tables exist
            if (!tableExists(conn, "users")) {
                System.out.println("Creating database tables...");
                createTables(stmt);
                insertDefaultData(stmt);
                System.out.println("Tables created and default data inserted!");
            } else {
                System.out.println("Database tables already exist.");
                // Check and add missing columns
                addMissingColumns(stmt);
            }
            
        } catch (SQLException e) {
            System.err.println("Error initializing database: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private boolean tableExists(Connection conn, String tableName) {
        try {
            ResultSet rs = conn.getMetaData().getTables(null, null, tableName, null);
            return rs.next();
        } catch (SQLException e) {
            return false;
        }
    }

    private void addMissingColumns(Statement stmt) {
        try {
            // Add cod_available column if not exists
            stmt.executeUpdate("ALTER TABLE books ADD COLUMN IF NOT EXISTS cod_available BOOLEAN DEFAULT TRUE");
            System.out.println("Checked/added missing columns.");
        } catch (SQLException e) {
            // Column might already exist or syntax not supported, try alternative
            try {
                stmt.executeUpdate("ALTER TABLE books ADD COLUMN cod_available BOOLEAN DEFAULT TRUE");
            } catch (SQLException ex) {
                // Column already exists, ignore
            }
        }
    }

    private void createTables(Statement stmt) throws SQLException {
        // Users table
        stmt.executeUpdate("""
            CREATE TABLE IF NOT EXISTS users (
                user_id INT PRIMARY KEY AUTO_INCREMENT,
                full_name VARCHAR(100) NOT NULL,
                email VARCHAR(100) UNIQUE NOT NULL,
                password VARCHAR(255) NOT NULL,
                phone VARCHAR(15),
                address TEXT,
                city VARCHAR(50),
                state VARCHAR(50),
                pincode VARCHAR(10),
                role ENUM('ADMIN', 'CUSTOMER') DEFAULT 'CUSTOMER',
                profile_image VARCHAR(255),
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                is_active BOOLEAN DEFAULT TRUE
            )
        """);

        // Categories table
        stmt.executeUpdate("""
            CREATE TABLE IF NOT EXISTS categories (
                category_id INT PRIMARY KEY AUTO_INCREMENT,
                category_name VARCHAR(50) NOT NULL UNIQUE,
                description TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        """);

        // Books table
        stmt.executeUpdate("""
            CREATE TABLE IF NOT EXISTS books (
                book_id INT PRIMARY KEY AUTO_INCREMENT,
                title VARCHAR(200) NOT NULL,
                author VARCHAR(100) NOT NULL,
                description TEXT,
                price DECIMAL(10, 2) NOT NULL,
                original_price DECIMAL(10, 2),
                category_id INT,
                book_type ENUM('NEW', 'OLD') DEFAULT 'NEW',
                cover_image VARCHAR(255),
                isbn VARCHAR(20),
                publisher VARCHAR(100),
                publication_year INT,
                pages INT,
                language VARCHAR(30) DEFAULT 'English',
                stock_quantity INT DEFAULT 0,
                low_stock_threshold INT DEFAULT 5,
                is_available BOOLEAN DEFAULT TRUE,
                cod_available BOOLEAN DEFAULT TRUE,
                seller_id INT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE SET NULL,
                FOREIGN KEY (seller_id) REFERENCES users(user_id) ON DELETE SET NULL
            )
        """);

        // Cart table
        stmt.executeUpdate("""
            CREATE TABLE IF NOT EXISTS cart (
                cart_id INT PRIMARY KEY AUTO_INCREMENT,
                user_id INT NOT NULL,
                book_id INT NOT NULL,
                quantity INT DEFAULT 1,
                added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
                FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
                UNIQUE KEY unique_cart_item (user_id, book_id)
            )
        """);

        // Orders table
        stmt.executeUpdate("""
            CREATE TABLE IF NOT EXISTS orders (
                order_id INT PRIMARY KEY AUTO_INCREMENT,
                user_id INT NOT NULL,
                order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                total_amount DECIMAL(10, 2) NOT NULL,
                shipping_address TEXT NOT NULL,
                shipping_city VARCHAR(50),
                shipping_state VARCHAR(50),
                shipping_pincode VARCHAR(10),
                payment_method ENUM('COD', 'ONLINE', 'UPI') DEFAULT 'COD',
                payment_status ENUM('PENDING', 'COMPLETED', 'FAILED', 'REFUNDED') DEFAULT 'PENDING',
                order_status ENUM('PLACED', 'CONFIRMED', 'SHIPPED', 'DELIVERED', 'CANCELLED') DEFAULT 'PLACED',
                tracking_number VARCHAR(50),
                notes TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
            )
        """);

        // Order items table
        stmt.executeUpdate("""
            CREATE TABLE IF NOT EXISTS order_items (
                item_id INT PRIMARY KEY AUTO_INCREMENT,
                order_id INT NOT NULL,
                book_id INT NOT NULL,
                quantity INT NOT NULL,
                price_at_purchase DECIMAL(10, 2) NOT NULL,
                FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
                FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE
            )
        """);

        // Sell requests table
        stmt.executeUpdate("""
            CREATE TABLE IF NOT EXISTS sell_requests (
                request_id INT PRIMARY KEY AUTO_INCREMENT,
                user_id INT NOT NULL,
                book_title VARCHAR(200) NOT NULL,
                book_author VARCHAR(100) NOT NULL,
                book_condition ENUM('LIKE_NEW', 'GOOD', 'FAIR', 'POOR') NOT NULL,
                expected_price DECIMAL(10, 2) NOT NULL,
                description TEXT,
                book_image VARCHAR(255),
                status ENUM('PENDING', 'APPROVED', 'REJECTED', 'SOLD') DEFAULT 'PENDING',
                admin_remarks TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
            )
        """);

        // Stock alerts table
        stmt.executeUpdate("""
            CREATE TABLE IF NOT EXISTS stock_alerts (
                alert_id INT PRIMARY KEY AUTO_INCREMENT,
                book_id INT NOT NULL,
                alert_message TEXT,
                is_read BOOLEAN DEFAULT FALSE,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE
            )
        """);

        System.out.println("All tables created successfully!");
    }

    private void insertDefaultData(Statement stmt) throws SQLException {
        // Insert default categories
        stmt.executeUpdate("""
            INSERT INTO categories (category_name, description) VALUES
            ('Fiction', 'Fictional stories and novels'),
            ('Non-Fiction', 'Educational and factual books'),
            ('Science', 'Science and technology books'),
            ('History', 'Historical books and biographies'),
            ('Literature', 'Classic and modern literature'),
            ('Self-Help', 'Personal development books'),
            ('Business', 'Business and finance books'),
            ('Children', 'Books for children'),
            ('Comics', 'Comic books and graphic novels'),
            ('Academic', 'Academic textbooks and references')
        """);

        // Insert default admin user (Password: admin123)
        stmt.executeUpdate("""
            INSERT INTO users (full_name, email, password, phone, role) VALUES
            ('System Admin', 'admin@ebook.com', 'admin123', '9999999999', 'ADMIN')
        """);

        // Insert sample books
        stmt.executeUpdate("""
            INSERT INTO books (title, author, description, price, original_price, category_id, book_type, stock_quantity, isbn, publisher, cod_available) VALUES
            ('The Great Adventure', 'John Smith', 'An exciting adventure novel.', 299.00, 399.00, 1, 'NEW', 50, '978-1234567890', 'Adventure Press', TRUE),
            ('Learn Java Programming', 'Jane Doe', 'Comprehensive guide to Java.', 499.00, 599.00, 3, 'NEW', 30, '978-0987654321', 'Tech Books', TRUE),
            ('World History Vol. 1', 'Robert Brown', 'Detailed account of world history.', 350.00, 450.00, 4, 'NEW', 25, '978-1122334455', 'History House', TRUE),
            ('Business Strategies', 'Sarah Wilson', 'Modern business strategies.', 275.00, 350.00, 7, 'OLD', 15, '978-5566778899', 'Business Weekly', TRUE),
            ('Children Stories', 'Emily Davis', 'Wonderful stories for children.', 199.00, 250.00, 8, 'NEW', 40, '978-9988776655', 'Kids Publications', TRUE)
        """);

        System.out.println("Default data inserted successfully!");
    }
}
