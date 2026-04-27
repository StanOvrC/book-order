# Online Bookstore

A Spring Boot web application for an online bookstore. 
It includes a user-facing storefront for browsing and purchasing books, and an admin dashboard for managing inventory and orders.

## Tech Stack
**Backend:** 
* Java 17
* Spring Boot (Web, Data JPA, Security)
* Maven

**Database:**
* PostgreSQL

**Frontend:**
* JSP
* Bootstrap 5

## Features
**Users:** 
* Register/login
* Browse the catalog
* Search by title/author
* Filter by genre
* Manage shopping cart
* Place orders
  
**Admins:** 
* Add/edit/delete books with cover images
* Manage user orders
* Update order statuses

## Quick Start

1. **Database Setup:** Create a PostgreSQL database named `book-order`. Run the SQL scripts in the `sql/` folder (`create.sql` then `data.sql`) to initialize tables and sample data.
   
2. **Configuration:** Verify your database credentials in `src/main/resources/application.properties`. Defaults are user `postgres` and password `root`.

3. **Run the App:**
   ```bash
   ./mvnw clean install
   ./mvnw spring-boot:run
   ```

The application will start at http://localhost:8080.

## Screenshots
**Catalog:**
<img width="2846" height="1526" alt="image" src="https://github.com/user-attachments/assets/b4acb36a-1969-4c7c-9dee-56eafb4c60a6" />

**Book page:**
<img width="2879" height="1519" alt="image" src="https://github.com/user-attachments/assets/20094fba-95ea-43db-a190-4de8c721f56c" />

