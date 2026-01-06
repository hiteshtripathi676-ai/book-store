package com.ebook.util;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

/**
 * Utility class for Cloudinary image upload
 * Cloudinary provides free cloud storage for images
 */
public class CloudinaryUtil {
    
    private static Cloudinary cloudinary;
    
    // Read from environment variables
    private static final String CLOUD_NAME = System.getenv("CLOUDINARY_CLOUD_NAME") != null 
            ? System.getenv("CLOUDINARY_CLOUD_NAME") : "your_cloud_name";
    private static final String API_KEY = System.getenv("CLOUDINARY_API_KEY") != null 
            ? System.getenv("CLOUDINARY_API_KEY") : "your_api_key";
    private static final String API_SECRET = System.getenv("CLOUDINARY_API_SECRET") != null 
            ? System.getenv("CLOUDINARY_API_SECRET") : "your_api_secret";
    
    static {
        cloudinary = new Cloudinary(ObjectUtils.asMap(
            "cloud_name", CLOUD_NAME,
            "api_key", API_KEY,
            "api_secret", API_SECRET,
            "secure", true
        ));
        System.out.println("Cloudinary initialized with cloud_name: " + CLOUD_NAME);
    }
    
    /**
     * Upload image to Cloudinary
     * @param inputStream The image input stream
     * @param fileName Original filename
     * @return The URL of the uploaded image, or null if upload fails
     */
    public static String uploadImage(InputStream inputStream, String fileName) {
        try {
            // Read input stream to bytes
            byte[] bytes = inputStream.readAllBytes();
            
            // Upload to Cloudinary
            Map<String, Object> uploadResult = cloudinary.uploader().upload(bytes, ObjectUtils.asMap(
                "folder", "ebook-store/books",
                "resource_type", "image"
            ));
            
            // Get the secure URL
            String imageUrl = (String) uploadResult.get("secure_url");
            System.out.println("Image uploaded successfully: " + imageUrl);
            
            return imageUrl;
            
        } catch (IOException e) {
            System.err.println("Failed to upload image to Cloudinary: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * Upload image from byte array
     * @param imageBytes The image bytes
     * @param fileName Original filename
     * @return The URL of the uploaded image
     */
    public static String uploadImage(byte[] imageBytes, String fileName) {
        try {
            Map<String, Object> uploadResult = cloudinary.uploader().upload(imageBytes, ObjectUtils.asMap(
                "folder", "ebook-store/books",
                "resource_type", "image"
            ));
            
            String imageUrl = (String) uploadResult.get("secure_url");
            System.out.println("Image uploaded successfully: " + imageUrl);
            
            return imageUrl;
            
        } catch (IOException e) {
            System.err.println("Failed to upload image to Cloudinary: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * Delete image from Cloudinary
     * @param publicId The public ID of the image
     * @return true if deletion was successful
     */
    public static boolean deleteImage(String publicId) {
        try {
            Map<String, Object> result = cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());
            return "ok".equals(result.get("result"));
        } catch (IOException e) {
            System.err.println("Failed to delete image from Cloudinary: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Check if Cloudinary is configured
     * @return true if environment variables are set
     */
    public static boolean isConfigured() {
        return CLOUD_NAME != null && !CLOUD_NAME.equals("your_cloud_name") 
            && API_KEY != null && !API_KEY.equals("your_api_key");
    }
}
