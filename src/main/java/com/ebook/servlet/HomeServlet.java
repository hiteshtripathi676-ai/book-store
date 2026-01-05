package com.ebook.servlet;

import com.ebook.dao.BookDAO;
import com.ebook.dao.CategoryDAO;
import com.ebook.dao.CartDAO;
import com.ebook.model.Book;
import com.ebook.model.Category;
import com.ebook.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Servlet for handling home page and book browsing
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"/home", "/index", "/books", "/book-details", "/search"})
public class HomeServlet extends HttpServlet {
    
    private BookDAO bookDAO;
    private CategoryDAO categoryDAO;
    private CartDAO cartDAO;
    
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
        categoryDAO = new CategoryDAO();
        cartDAO = new CartDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getServletPath();
        
        // Get cart count for logged in users
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("userId") != null) {
            int userId = (int) session.getAttribute("userId");
            int cartCount = cartDAO.getCartItemCount(userId);
            request.setAttribute("cartCount", cartCount);
        }
        
        // Get categories for navigation
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        
        switch (action) {
            case "/book-details":
                showBookDetails(request, response);
                break;
            case "/books":
                showBooks(request, response);
                break;
            case "/search":
                searchBooks(request, response);
                break;
            default:
                showHome(request, response);
        }
    }
    
    /**
     * Show home page with featured books
     */
    private void showHome(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get new books
        List<Book> newBooks = bookDAO.getBooksByType("NEW");
        request.setAttribute("newBooks", newBooks);
        
        // Get old books
        List<Book> oldBooks = bookDAO.getBooksByType("OLD");
        request.setAttribute("oldBooks", oldBooks);
        
        // Get featured books
        List<Book> featuredBooks = bookDAO.getFeaturedBooks(8);
        request.setAttribute("featuredBooks", featuredBooks);
        
        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
    
    /**
     * Show all books with optional filtering
     */
    private void showBooks(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String categoryId = request.getParameter("category");
        String bookType = request.getParameter("type");
        String searchQuery = request.getParameter("q");
        
        List<Book> books;
        
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            books = bookDAO.searchBooks(searchQuery.trim());
            request.setAttribute("searchQuery", searchQuery);
        } else if (categoryId != null && !categoryId.isEmpty()) {
            try {
                int catId = Integer.parseInt(categoryId);
                books = bookDAO.getBooksByCategory(catId);
                request.setAttribute("selectedCategory", catId);
            } catch (NumberFormatException e) {
                books = bookDAO.getAllBooks();
            }
        } else if (bookType != null && !bookType.isEmpty()) {
            books = bookDAO.getBooksByType(bookType.toUpperCase());
            request.setAttribute("selectedType", bookType);
        } else {
            books = bookDAO.getAllBooks();
        }
        
        // Get all categories for filter sidebar
        List<Category> allCategories = categoryDAO.getAllCategories();
        request.setAttribute("categories", allCategories);
        
        request.setAttribute("books", books);
        request.setAttribute("totalBooks", books.size());
        request.getRequestDispatcher("/WEB-INF/views/books.jsp").forward(request, response);
    }
    
    /**
     * Show book details page
     */
    private void showBookDetails(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String bookIdParam = request.getParameter("id");
        
        if (bookIdParam == null || bookIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        try {
            int bookId = Integer.parseInt(bookIdParam);
            Book book = bookDAO.getBookById(bookId);
            
            if (book != null) {
                request.setAttribute("book", book);
                
                // Get related books from same category
                List<Book> relatedBooks = bookDAO.getBooksByCategory(book.getCategoryId());
                relatedBooks.removeIf(b -> b.getBookId() == book.getBookId());
                if (relatedBooks.size() > 4) {
                    relatedBooks = relatedBooks.subList(0, 4);
                }
                request.setAttribute("relatedBooks", relatedBooks);
                
                // Check if book is in cart
                HttpSession session = request.getSession(false);
                if (session != null && session.getAttribute("userId") != null) {
                    int userId = (int) session.getAttribute("userId");
                    boolean inCart = cartDAO.isInCart(userId, bookId);
                    request.setAttribute("inCart", inCart);
                }
                
                request.getRequestDispatcher("/WEB-INF/views/book-details.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
    
    /**
     * Search books
     */
    private void searchBooks(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String query = request.getParameter("q");
        
        if (query == null || query.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/books");
            return;
        }
        
        List<Book> books = bookDAO.searchBooks(query.trim());
        request.setAttribute("books", books);
        request.setAttribute("searchQuery", query);
        
        request.getRequestDispatcher("/WEB-INF/views/books.jsp").forward(request, response);
    }
}
