<#ftl encoding="UTF-8">
<#assign pageTitle = "Регистрация">
<#assign pageCss = "auth.css">
<#include "header.ftl">

<div class="container">
    <h2>Регистрация</h2>

    <#if error??>
        <div id="errorMsg">${error}</div>
    </#if>

    <form action="${contextPath!""}/register" method="post">
        <label>Имя:</label>
        <input type="text" name="name" required>

        <label>Email:</label>
        <input type="email" name="email" required>

        <label>Пароль:</label>
        <input type="password" name="password" required>

        <input type="submit" value="Зарегистрироваться">
    </form>

    <p>Уже есть аккаунт? <a href="${contextPath!""}/login">Войти</a></p>
</div>

<#include "footer.ftl">
