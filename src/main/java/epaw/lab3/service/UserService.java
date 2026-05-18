package epaw.lab3.service;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import epaw.lab3.model.User;
import epaw.lab3.repository.UserRepository;
import jakarta.servlet.http.Part;

import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeParseException;

public class UserService {

    private static UserService instance;
    private UserRepository userRepository;

    private UserService() {
        this.userRepository = UserRepository.getInstance();
    }

    public static synchronized UserService getInstance() {
        if (instance == null) {
            instance = new UserService();
        }
        return instance;
    }

    private static final String PASSWORD_REGEX = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*]).{8,}$";
    
    private static final String EMAIL_REGEX = 
    "^[A-Za-z0-9+_.-]+@([A-Za-z0-9.-]+\\.[A-Za-z]{2,})$";

    private static final String PHONE_REGEX = 
    "^\\+?[1-9]\\d{7,14}$"; // E.164 format, allowing international phone numbers (change it from sem1)


    public Map<String, String> validate(User user) {
        Map<String, String> errors = new HashMap<>();

        String firstName = user.getFirstName();
        if (firstName == null || firstName.trim().isEmpty()) {
            errors.put("firstName", "First name cannot be empty.");
        }
        else if (firstName.length() < 2 || firstName.length() > 50) {
            errors.put("firstName", "First name must be between 2 and 50 characters.");
        }

        String lastName = user.getLastName();
        if (lastName == null || lastName.trim().isEmpty()) {
            errors.put("lastName", "Last name cannot be empty.");
        }else if (lastName.length() < 2 || lastName.length() > 50) {
            errors.put("lastName", "Last name must be between 2 and 50 characters.");
        }

        String username = user.getUsername();
        if (username == null || username.trim().isEmpty()) {
            errors.put("username", "Username cannot be empty.");
        } else if (username.length() < 5 || username.length() > 20) {
            errors.put("username", "Username must be between 5 and 20 characters.");
        } else if (userRepository.existsByUsername(username)) {
            errors.put("username", "Username already exists.");
        }

        String password = user.getPassword();
        if (password == null || !password.matches(PASSWORD_REGEX)) {
            errors.put("password",
                    "Minimum 8 characters, including uppercase, numbers, and a special character (@#$%^&*).");
        }

         String email = user.getEmail();
        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "Email cannot be empty.");
        } else if (userRepository.existsByEmail(email)) {
            errors.put("email", "Email already exists.");
        } else if (!email.matches(EMAIL_REGEX)) {
            errors.put("email", "Invalid email format.");
        }
        
        String phone = user.getPhone();
        if (phone != null && !phone.trim().isEmpty() && !phone.matches(PHONE_REGEX)) {
            errors.put("phone", "Invalid phone number format.");
        }

        String dateOfBirth = user.getDateOfBirth();
        if (dateOfBirth == null || dateOfBirth.trim().isEmpty()) {
            errors.put("dateOfBirth", "Date of birth cannot be empty.");
        } else{
            try{
                LocalDate dob = LocalDate.parse(dateOfBirth);
                int age= Period.between(dob, LocalDate.now()).getYears();
                if(age < 16){
                    errors.put("dateOfBirth", "User must be at least 16 years old.");
                }
            } catch (DateTimeParseException e) {
                errors.put("dateOfBirth", "Invalid date format. Please use YYYY-MM-DD.");
            }
        }

        String gender = user.getGender();
        if (gender != null && !gender.trim().isEmpty()) {
            Set<String> validGenders = Set.of("he/him", "she/her", "they/them", "other", "prefer not to say");
            if (!validGenders.contains(gender.trim())) {
                errors.put("gender", "Invalid gender selection.");
            }
        }

        String allergies = user.getAllergies();
        if (allergies.length() > 200) {
            errors.put("allergies", "Allergies must not exceed 200 characters.");
        }


        return errors;
    }

    public Map<String, String> register(User user) {
        Map<String, String> errors = validate(user);
        if (errors.isEmpty()) {
            userRepository.save(user);
        }
        return errors;
    }

    public Map<String, String> login(User user) {
        Map<String, String> errors = new HashMap<>();
        if (!userRepository.checkLogin(user)) {
            errors.put("password", "The combination of username and password does not match in our dataabase");
        }
        return errors;
    }

    public User getUserByUsername(String username) {
        return userRepository.findByUsername(username).orElse(null);
    }

    public void updateProfile(User user) {
        userRepository.update(user);
    }

    public String saveProfilePicture(Part filePart, String username) {
        if (filePart == null || filePart.getSize() <= 0) {
            return null;
        }

        try {
            String fileName = filePart.getSubmittedFileName();
            String extension = fileName.substring(fileName.lastIndexOf("."));
            String newFileName = username + extension;

            String resourcesDir = "EXTERNAL_RESOURCES";
            Files.createDirectories(Paths.get(resourcesDir));

            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, Paths.get(resourcesDir, newFileName), StandardCopyOption.REPLACE_EXISTING);
            }
            return newFileName;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}