package org.example.websiteenglish.servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.example.websiteenglish.service.UserService;
import org.example.websiteenglish.service.impl.UserServiceImpl;

import java.io.IOException;

@WebServlet(urlPatterns = "/check/email")
public class EmailCheckServlet extends HttpServlet {

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String email = req.getParameter("email");
        resp.setContentType("text/plain; charset=UTF-8");

        if (email == null || email.isEmpty()) {
            resp.getWriter().write(""); // пусто, если поле пустое
            return;
        }

        if (!userService.emailExists(email)) {
            resp.getWriter().write(""); // свободно
        } else {
            resp.getWriter().write("Этот email уже зарегистрирован!"); // занят
        }
    }
}
