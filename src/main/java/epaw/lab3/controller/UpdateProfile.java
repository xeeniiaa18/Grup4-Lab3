package epaw.lab3.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import epaw.lab3.model.User;
import epaw.lab3.service.UserService;

import java.io.IOException;

@WebServlet("/UpdateProfile")
public class UpdateProfile extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = UserService.getInstance();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login");
            return;
        }

        // Update optional fields
        user.setBio(request.getParameter("bio"));
        user.setPhone(request.getParameter("phone"));
        user.setAllergies(request.getParameter("allergies"));
        user.setPicture(request.getParameter("picture"));

        // Multiple checkboxes → join as comma-separated string
        String[] prefs = request.getParameterValues("foodPreferences");
        user.setFoodPreferences(prefs != null ? String.join(",", prefs) : "");

        // Save to DB
        userService.updateProfile(user);

        // Update session with new data
        session.setAttribute("user", user);

        request.getRequestDispatcher("Profile.jsp").forward(request, response);
    }
}