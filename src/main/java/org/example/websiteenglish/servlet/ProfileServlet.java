package org.example.websiteenglish.servlet;

import org.example.websiteenglish.entity.User;
import org.example.websiteenglish.service.UserService;
import org.example.websiteenglish.service.impl.UserServiceImpl;
import org.example.websiteenglish.utils.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import java.io.IOException;

@WebServlet(name = "profileServlet", urlPatterns = {"/profile", "/profile/edit", "/profile/delete"})
public class ProfileServlet extends HttpServlet {

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            resp.sendRedirect("login.ftl");
            return;
        }

        String email = (String) session.getAttribute("userEmail");
        User user = userService.getByEmail(email);

        String path = req.getServletPath();
        switch (path) {
            case "/profile":
                req.setAttribute("user", user);
                req.getRequestDispatcher("profile.ftl").forward(req, resp);
                break;
            case "/profile/edit":
                req.setAttribute("user", user);
                req.getRequestDispatcher("/editProfile.ftl").forward(req, resp);
                break;

            case "/profile/delete":
                userService.deleteUser(user.getId());
                session.invalidate();
                resp.sendRedirect("index.ftl");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            resp.sendRedirect("login.ftl");
            return;
        }

        String email = (String) session.getAttribute("userEmail");

        User user = userService.getByEmail(email);

        req.setAttribute("user", user);
        req.getRequestDispatcher("/profile.ftl").forward(req, resp);

        User currentUser = userService.getByEmail(email);

        String name = req.getParameter("name");
        String password = req.getParameter("password");

        currentUser.setName(name);
        if (password != null && !password.isEmpty()) {
            currentUser.setPassword(PasswordUtil.encrypt(password)); // хешируем пароль
        }

        userService.updateUser(currentUser);

        session.setAttribute("userEmail", currentUser.getEmail());

        // вместо редиректа — forward на профиль
        req.setAttribute("user", currentUser);
        req.getRequestDispatcher("/profile.ftl").forward(req, resp);
    }


}
