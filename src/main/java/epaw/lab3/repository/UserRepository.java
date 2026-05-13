package epaw.lab3.repository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;

import epaw.lab3.model.User;

public class UserRepository extends BaseRepository {

    private static UserRepository instance;

    private UserRepository() {
        super();
    }

    public static synchronized UserRepository getInstance() {
        if (instance == null) {
            instance = new UserRepository();
        }
        return instance;
    }

    public boolean existsByUsername(String username) {
		String query = "SELECT COUNT(*) FROM users WHERE username = ?";
		try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setString(1, username);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
	}

    
	public boolean existsByEmail(String email) {
		String query = "SELECT COUNT(*) FROM users WHERE email = ?";
		try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setString(1, email);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
	}

    public boolean checkLogin(User user) {
        String query = "SELECT id, picture from users where username=? AND password=?";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setString(1, user.getUsername());
            statement.setString(2, user.getPassword());
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    user.setId(rs.getInt("id"));
                    user.setPicture(rs.getString("picture"));
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void save(User user) {
        String query = "INSERT INTO users ( username,  password,  picture,   email, phone,  firstName,  lastName,  dateOfBirth,   gender,  title,  allergies,   foodPreferences) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setString(1, user.getUsername());
            statement.setString(2, user.getPassword());
            statement.setString(3, user.getPicture());
            statement.setString(4, user.getEmail());
			statement.setString(5, user.getPhone());
			statement.setString(6, user.getFirstName());
			statement.setString(7, user.getLastName());
			statement.setString(8, user.getDateOfBirth());
			statement.setString(9, user.getGender());
			statement.setString(10, user.getTitle());
			statement.setString(11, user.getAllergies());
			statement.setString(12, user.getFoodPreferences());
			statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Optional<User> findByUsername(String username) {
        String query = "SELECT id, username, password, picture, email, phone,  firstName,  lastName,  dateOfBirth,   gender,  title,  allergies,   foodPreferences FROM users WHERE username = ?";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setString(1, username);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setPicture(rs.getString("picture"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setFirstName(rs.getString("firstName"));
                user.setLastName(rs.getString("lastName"));
                user.setDateOfBirth(rs.getString("dateOfBirth"));
                user.setGender(rs.getString("gender"));
                user.setTitle(rs.getString("title"));
                user.setAllergies(rs.getString("allergies"));
                user.setFoodPreferences(rs.getString("foodPreferences"));
                return Optional.of(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }
}
