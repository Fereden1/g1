package org.example.websiteenglish.filter;

import freemarker.template.Configuration;
import freemarker.template.TemplateExceptionHandler;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.Locale;

@WebListener
public class FreemarkerConfigListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext ctx = sce.getServletContext();
        Configuration cfg = new Configuration(Configuration.VERSION_2_3_34);

        // Путь к шаблонам в WAR: /WEB-INF/templates
        cfg.setServletContextForTemplateLoading(ctx, "/WEB-INF");

        // Явно указываем кодировку чтения шаблонов
        cfg.setDefaultEncoding("UTF-8");

        // Рекомендации по обработке ошибок
        cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
        cfg.setLogTemplateExceptions(false);
        cfg.setWrapUncheckedExceptions(true);

        // Установим локаль по дефолту (опционально)
        cfg.setLocale(Locale.forLanguageTag("ru-RU"));

        // Кладём конфиг в атрибут контекста
        ctx.setAttribute("freemarkerConfig", cfg);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // ничего не нужно
    }
}
