<#ftl encoding="UTF-8">
<!doctype html>
<html lang="ru">
<head>
    <meta charset="utf-8">
    <title>${pageTitle! "Home English School"}</title>
    <link rel="stylesheet" href="${contextPath!""}/static/css/style.css">
    <#-- Подключаем отдельные стили страницы, если заданы -->
    <#if pageCss??>
        <link rel="stylesheet" href="${contextPath!""}/static/css/${pageCss}">
    </#if>
    <#if extraHead??>
        ${extraHead}
    </#if>
</head>
<body>

<header class="hdr">
    <div class="wrap">
        <div class="logo"><a href="${contextPath!""}/index">Home English School</a></div>

        <nav class="menu">
            <a href="${contextPath!""}/index#courses">Курсы</a>
            <a href="${contextPath!""}/index#advantages">Преимущества</a>
            <a href="${contextPath!""}/index#process">Как учим</a>
            <a href="${contextPath!""}/chat">Отзывы</a>
        </nav>

        <div class="auth">
            <#-- Показываем имя если есть сессия -->
            <#if userName??>
                <span>Привет, <a href="${contextPath!""}/profile">${userName}</a></span>
                <button class="btnn quit" onclick="window.location.href='${contextPath!""}/logout'">Выйти</button>
            <#else>
                <button class="btnn" onclick="window.location.href='${contextPath!""}/register'">Регистрация</button>
                <button class="btnn" onclick="window.location.href='${contextPath!""}/login'">Войти</button>
            </#if>
        </div>
    </div>
</header>