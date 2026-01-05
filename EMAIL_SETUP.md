# Email Configuration Guide

## Setup Instructions

To enable email notifications for orders, you need to configure SMTP settings in the EmailService.java file.

### For Gmail (Recommended for Testing)

1. **Open** [EmailService.java](src/main/java/com/ebook/service/EmailService.java)

2. **Update these constants** (lines 16-21):

```java
private static final String SMTP_HOST = "smtp.gmail.com";
private static final String SMTP_PORT = "587";
private static final String FROM_EMAIL = "sonymatiyadav@gmail.com"; // Your Gmail address
private static final String FROM_PASSWORD = "bxbpnmhxqseuropa"; // Gmail App Password (NOT your regular password)
private static final String ADMIN_EMAIL = "sonymatiyadav@gmail.com"; // Admin email to receive order notifications
```

3. **Generate Gmail App Password**:
   - Go to your Google Account settings: https://myaccount.google.com/
   - Navigate to Security → 2-Step Verification (enable if not already)
   - Scroll down to "App passwords"
   - Select app: "Mail"
   - Select device: "Other (Custom name)" → Enter "E-Book Store"
   - Click "Generate"
   - Copy the 16-character password (without spaces)
   - Paste it in `FROM_PASSWORD` field

### For Other Email Providers

**Outlook/Hotmail:**
```java
private static final String SMTP_HOST = "smtp-mail.outlook.com";
private static final String SMTP_PORT = "587";
```

**Yahoo Mail:**
```java
private static final String SMTP_HOST = "smtp.mail.yahoo.com";
private static final String SMTP_PORT = "587";
```

**Custom SMTP Server:**
```java
private static final String SMTP_HOST = "your-smtp-host.com";
private static final String SMTP_PORT = "587"; // or 465 for SSL
private static final String FROM_EMAIL = "your-email@domain.com";
private static final String FROM_PASSWORD = "your-password";
```

## What Happens After Order Placement

1. **Customer receives** a confirmation email with:
   - Order number and date
   - Complete order details (items, quantities, prices)
   - Shipping address
   - Payment method
   - Total amount

2. **Admin receives** a notification email with:
   - Order number and date
   - Customer information (name, email)
   - Shipping address
   - Order items and quantities
   - Total amount
   - Special alert for COD orders

## Email Features

- ✅ Beautiful HTML email templates
- ✅ Mobile-responsive design
- ✅ Professional branding with gradients
- ✅ Sends emails in background threads (doesn't slow down order placement)
- ✅ Automatic error handling (orders will still be placed even if email fails)

## Testing

1. Configure SMTP settings as described above
2. Rebuild and redeploy the application:
   ```powershell
   mvn package -DskipTests
   ```
3. Place a test order
4. Check both customer and admin email inboxes
5. Check Tomcat logs for email status:
   ```
   logs/catalina.out (or stdout)
   ```

## Troubleshooting

**Email not sending?**
- Check SMTP credentials are correct
- Verify 2-Step Verification is enabled (for Gmail)
- Check spam/junk folders
- Review Tomcat logs for error messages
- Ensure firewall allows outbound SMTP connections

**Gmail "Less secure app" error?**
- Don't use your regular Gmail password
- Use App Password instead (see setup instructions above)

## Security Note

⚠️ **IMPORTANT**: Never commit email credentials to version control!

For production, use environment variables or secure configuration management:
```java
private static final String FROM_EMAIL = System.getenv("SMTP_EMAIL");
private static final String FROM_PASSWORD = System.getenv("SMTP_PASSWORD");
```

## Need Help?

If emails aren't working:
1. Check the Tomcat console logs for error messages
2. Verify SMTP settings are correct
3. Test with a simple Gmail account first
4. Ensure your email provider allows SMTP access
