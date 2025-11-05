package org.example.websiteenglish.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter("/*")
public class LoginFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        String uri = req.getRequestURI();

        // Разрешаем доступ к страницам логина, регистрации и статическим ресурсам
        if (uri.endsWith("login") || uri.endsWith("login.ftl") || uri.endsWith("register.ftl")
                || uri.matches(".*\\.(css|js|png|jpg|jpeg|gif|svg|woff|woff2|ttf|eot)$")) {
            chain.doFilter(request, response);
            return;
        }


        // Если пользователь не вошел, перенаправляем на логин
        boolean loggedIn = session != null && session.getAttribute("userId") != null;
        if (!loggedIn) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Если вошел — пропускаем дальше
        chain.doFilter(request, response);
    }
}
