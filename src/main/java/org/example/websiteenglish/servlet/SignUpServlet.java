package org.example.websiteenglish.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.example.websiteenglish.service.UserService;
import org.example.websiteenglish.service.impl.UserServiceImpl;

import java.io.IOException;

@WebServlet(name = "register", urlPatterns = "/register")
public class SignUpServlet extends HttpServlet {

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Показываем страницу регистрации
        req.getRequestDispatcher("/register.ftl").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Получаем данные из формы
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        // Устанавливаем кодировку
        resp.setContentType("text/html; charset=UTF-8");

        // Проверяем, существует ли пользователь с таким email
        if (userService.emailExists(email)) {
            req.setAttribute("error", "Пользователь с таким email уже существует");
            req.getRequestDispatcher("/register.ftl").forward(req, resp);
        } else {
            userService.signUp(name, email, password);
            // ✅ после успешной регистрации — на логин
            resp.sendRedirect("login");
        }

    }
}