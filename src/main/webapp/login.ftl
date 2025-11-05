<#ftl encoding="UTF-8">
<#assign pageTitle = "Вход">
<#assign pageCss = "auth.css">
<#include "header.ftl">

<div class="container">
    <h2>Вход</h2>

    <#if error??>
        <div id="errorMsg">${error}</div>
    </#if>

    <form method="post" action="${contextPath!""}/login">
        <label>Email:</label>
        <input type="email" name="email" placeholder="Введите email" required>

        <label>Пароль:</label>
        <input type="password" name="password" placeholder="Введите пароль" required>

        <input type="submit" value="Войти">
    </form>

    <p>Нет аккаунта? <a href="${contextPath!""}/register">Регистрация</a></p>
</div>

<#include "footer.ftl">
