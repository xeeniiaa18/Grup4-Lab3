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

        user.setTitle(request.getParameter("title"));
        String[] prefs = request.getParameterValues("foodPreferences");
        user.setFoodPreferences(prefs != null ? String.join(",", prefs) : "");
        System.out.println("=== DEBUG ===");
        System.out.println("user.getId() = " + user.getId());
        System.out.println("user.getBio() = " + user.getBio());
        System.out.println("user.getTitle() = " + user.getTitle());
       
        // Save to DB
        userService.updateProfile(user);

        User refreshed = userService.getUserByUsername(user.getUsername());

        // Update session with new data
        session.setAttribute("user", refreshed);
        request.setAttribute("updateSuccess", true);

        request.getRequestDispatcher("Profile.jsp").forward(request, response);
    }
}