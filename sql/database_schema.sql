-- =====================================================
-- E-BOOK MANAGEMENT SYSTEM - DATABASE SCHEMA
-- Created for College Project
-- =====================================================

-- Create Database (use 'railway' for Railway deployment)
-- For Railway: The database 'railway' already exists, just use it
-- CREATE DATABASE IF NOT EXISTS railway;
-- USE railway;

-- For local development, you can use:
-- CREATE DATABASE IF NOT EXISTS ebook_management;
-- USE ebook_management;

-- =====================================================
-- USERS TABLE (For both Admin and Customers)
-- =====================================================
CREATE TABLE users (
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
);

-- =====================================================
-- CATEGORIES TABLE
-- =====================================================
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- BOOKS TABLE
-- =====================================================
CREATE TABLE books (
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
);

-- =====================================================
-- CART TABLE
-- =====================================================
CREATE TABLE cart (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT DEFAULT 1,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    UNIQUE KEY unique_cart_item (user_id, book_id)
);

-- =====================================================
-- ORDERS TABLE
-- =====================================================
CREATE TABLE orders (
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
);

-- =====================================================
-- ORDER ITEMS TABLE
-- =====================================================
CREATE TABLE order_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE
);

-- =====================================================
-- SELL OLD BOOKS REQUESTS TABLE
-- =====================================================
CREATE TABLE sell_requests (
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
);

-- =====================================================
-- LOW STOCK ALERTS TABLE
-- =====================================================
CREATE TABLE stock_alerts (
    alert_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    alert_message TEXT,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE
);

-- =====================================================
-- SALES ANALYTICS VIEW
-- =====================================================
CREATE VIEW monthly_sales_view AS
SELECT 
    YEAR(o.order_date) as sale_year,
    MONTH(o.order_date) as sale_month,
    MONTHNAME(o.order_date) as month_name,
    COUNT(DISTINCT o.order_id) as total_orders,
    SUM(oi.quantity) as books_sold,
    SUM(o.total_amount) as total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status != 'CANCELLED'
GROUP BY YEAR(o.order_date), MONTH(o.order_date), MONTHNAME(o.order_date)
ORDER BY sale_year DESC, sale_month DESC;

-- =====================================================
-- POPULAR AUTHORS VIEW
-- =====================================================
CREATE VIEW popular_authors_view AS
SELECT 
    b.author,
    COUNT(oi.item_id) as times_ordered,
    SUM(oi.quantity) as total_books_sold,
    SUM(oi.quantity * oi.price_at_purchase) as total_revenue
FROM books b
JOIN order_items oi ON b.book_id = oi.book_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status != 'CANCELLED'
GROUP BY b.author
ORDER BY total_books_sold DESC;

-- =====================================================
-- INSERT DEFAULT DATA
-- =====================================================

-- Insert Default Categories
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
('Academic', 'Academic textbooks and references');

-- Insert Default Admin User (Password: admin123)
INSERT INTO users (full_name, email, password, phone, role) VALUES
('System Admin', 'admin@ebook.com', 'admin123', '9999999999', 'ADMIN');

-- Insert Sample Books
INSERT INTO books (title, author, description, price, original_price, category_id, book_type, stock_quantity, isbn, publisher) VALUES
('The Great Adventure', 'John Smith', 'An exciting adventure novel that takes you through mysterious lands.', 299.00, 399.00, 1, 'NEW', 50, '978-1234567890', 'Adventure Press'),
('Learn Java Programming', 'Jane Doe', 'Comprehensive guide to Java programming for beginners.', 499.00, 599.00, 3, 'NEW', 30, '978-0987654321', 'Tech Books'),
('World History Vol. 1', 'Robert Brown', 'Detailed account of world history from ancient times.', 350.00, 450.00, 4, 'NEW', 25, '978-1122334455', 'History House'),
('Business Strategies', 'Sarah Wilson', 'Modern business strategies for success.', 275.00, 350.00, 7, 'OLD', 15, '978-5566778899', 'Business Weekly'),
('Children Stories', 'Emily Davis', 'Collection of wonderful stories for children.', 199.00, 250.00, 8, 'NEW', 40, '978-9988776655', 'Kids Publications');

-- =====================================================
-- TRIGGERS FOR LOW STOCK ALERTS
-- =====================================================
DELIMITER //

CREATE TRIGGER check_low_stock_after_order
AFTER UPDATE ON books
FOR EACH ROW
BEGIN
    IF NEW.stock_quantity <= NEW.low_stock_threshold AND NEW.stock_quantity > 0 THEN
        INSERT INTO stock_alerts (book_id, alert_message)
        VALUES (NEW.book_id, CONCAT('Low stock alert: "', NEW.title, '" has only ', NEW.stock_quantity, ' copies left.'));
    ELSEIF NEW.stock_quantity = 0 THEN
        INSERT INTO stock_alerts (book_id, alert_message)
        VALUES (NEW.book_id, CONCAT('Out of stock: "', NEW.title, '" is now out of stock!'));
    END IF;
END//

DELIMITER ;

-- =====================================================
-- STORED PROCEDURE FOR CHECKOUT
-- =====================================================
DELIMITER //

CREATE PROCEDURE process_checkout(
    IN p_user_id INT,
    IN p_shipping_address TEXT,
    IN p_shipping_city VARCHAR(50),
    IN p_shipping_state VARCHAR(50),
    IN p_shipping_pincode VARCHAR(10),
    IN p_payment_method VARCHAR(20)
)
BEGIN
    DECLARE v_order_id INT;
    DECLARE v_total DECIMAL(10,2);
    
    -- Calculate total from cart
    SELECT SUM(b.price * c.quantity) INTO v_total
    FROM cart c
    JOIN books b ON c.book_id = b.book_id
    WHERE c.user_id = p_user_id;
    
    -- Create order
    INSERT INTO orders (user_id, total_amount, shipping_address, shipping_city, shipping_state, shipping_pincode, payment_method)
    VALUES (p_user_id, v_total, p_shipping_address, p_shipping_city, p_shipping_state, p_shipping_pincode, p_payment_method);
    
    SET v_order_id = LAST_INSERT_ID();
    
    -- Move cart items to order items
    INSERT INTO order_items (order_id, book_id, quantity, price_at_purchase)
    SELECT v_order_id, c.book_id, c.quantity, b.price
    FROM cart c
    JOIN books b ON c.book_id = b.book_id
    WHERE c.user_id = p_user_id;
    
    -- Update book stock
    UPDATE books b
    JOIN cart c ON b.book_id = c.book_id
    SET b.stock_quantity = b.stock_quantity - c.quantity
    WHERE c.user_id = p_user_id;
    
    -- Clear cart
    DELETE FROM cart WHERE user_id = p_user_id;
    
    -- Return order ID
    SELECT v_order_id as order_id, v_total as total_amount;
END//

DELIMITER ;
