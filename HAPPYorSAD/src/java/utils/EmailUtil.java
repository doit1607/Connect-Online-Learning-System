package utils;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.activation.*;
import java.util.Properties;

public class EmailUtil {
    private static final String EMAIL_SENDER = "trandung182204@gmail.com";
    private static final String EMAIL_PASSWORD = "***REMOVED***";

    public static void sendVerificationEmail(String recipientEmail, String username, String verificationLink) {
        String subject = "Account Activation";
        String message = "Dear " + username + ",\n\n"
                + "Click the link below to activate your account:\n"
                + verificationLink + "\n\n"
                + "Best regards,\nYour Team";

        sendEmail(recipientEmail, subject, message);
    }
    public static void sendResetPassword(String recipientEmail, String username, String newPassword) {
        String subject = "ResetPassword";
       String message = "Hello " + username + ",\n\n"
                        + "Your password has been reset. Your new password is: " + newPassword + "\n\n"
                        + "For security reasons, please change your password after logging in.\n\n"
                        + "Best regards,\nSupport Team";

        sendEmail(recipientEmail, subject, message);
    }

    private static void sendEmail(String recipientEmail, String subject, String message) {
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_SENDER, EMAIL_PASSWORD);
            }
        });
        try {
            Message emailMessage = new MimeMessage(session);
            emailMessage.setFrom(new InternetAddress(EMAIL_SENDER));
            emailMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            emailMessage.setSubject(subject);
            emailMessage.setText(message);

            Transport.send(emailMessage);
        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("Error sending email"+e.getMessage());
        }
    }
}
