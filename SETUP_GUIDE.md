# E-Book Management System - Setup Guide

## Required Software Installation

### 1. Install Apache Maven
Maven is required to build the project.

**Option A: Download and Install**
1. Download from: https://maven.apache.org/download.cgi
2. Download the "Binary zip archive"
3. Extract to `C:\Program Files\Apache\maven`
4. Add to PATH:
   - Open System Properties → Environment Variables
   - Add to PATH: `C:\Program Files\Apache\maven\bin`
5. Restart terminal and verify: `mvn --version`

**Option B: Using Chocolatey (if installed)**
```powershell
choco install maven
```

**Option C: Using winget**
```powershell
winget install Apache.Maven
```

### 2. Install MySQL
1. Download MySQL Community Server from: https://dev.mysql.com/downloads/mysql/
2. Run the installer and follow the setup wizard
3. Remember your root password!

### 3. Install Apache Tomcat
1. Download Tomcat 10.x from: https://tomcat.apache.org/download-10.cgi
2. Download the "64-bit Windows zip"
3. Extract to `C:\Program Files\Apache\tomcat10`

---

## Database Setup

After installing MySQL, run these commands:

```sql
-- Connect to MySQL
mysql -u root -p

-- Create database
CREATE DATABASE ebook_store;
USE ebook_store;

-- Run the schema file (copy path to your sql folder)
SOURCE C:/Users/ay882/OneDrive/Desktop/Arpita-project/sql/database_schema.sql;
```

---

## Build and Deploy

### Step 1: Build the Project
```powershell
cd "C:\Users\ay882\OneDrive\Desktop\Arpita-project"
mvn clean package
```

### Step 2: Deploy to Tomcat
Copy the WAR file to Tomcat:
```powershell
Copy-Item "target\ebook-store.war" "C:\Program Files\Apache\tomcat10\webapps\"
```

### Step 3: Start Tomcat
```powershell
cd "C:\Program Files\Apache\tomcat10\bin"
.\startup.bat
```

### Step 4: Access the Application
Open browser: http://localhost:8080/ebook-store

---

## Quick Alternative: Run in IDE

If you have **Eclipse** or **IntelliJ IDEA**:

### Eclipse
1. File → Import → Maven → Existing Maven Projects
2. Select the project folder
3. Right-click project → Run As → Run on Server
4. Select Tomcat server

### IntelliJ IDEA
1. File → Open → Select project folder
2. Wait for Maven to import dependencies
3. Add Tomcat configuration (Run → Edit Configurations)
4. Run the Tomcat configuration

---

## Default Login

- **Admin:** admin@ebook.com / admin123
- **Customer:** Register on signup page

---

## Troubleshooting

### Database Connection Error
Update credentials in: `src/main/java/com/ebook/util/DBConnection.java`
```java
private static final String USER = "your_username";
private static final String PASSWORD = "your_password";
```

### Port Already in Use
Change Tomcat port in: `conf/server.xml`
