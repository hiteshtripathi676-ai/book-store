package com.ebook.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import java.io.IOException;

/**
 * Filter for setting character encoding to UTF-8 for all requests
 */
public class CharacterEncodingFilter implements Filter {
    
    private String encoding = "UTF-8";
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        String configuredEncoding = filterConfig.getInitParameter("encoding");
        if (configuredEncoding != null) {
            this.encoding = configuredEncoding;
        }
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        request.setCharacterEncoding(encoding);
        response.setCharacterEncoding(encoding);
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // Cleanup if needed
    }
}
