<#ftl encoding="UTF-8">
<#assign pageTitle = "Редактирование профиля">
<#assign pageCss = "auth.css">
<#include "header.ftl">

<div class="container">
    <h2>Редактирование профиля</h2>
    <form method="post" action="${contextPath!""}/profile">
        <label>Email:</label>
        <input type="text" name="email" value="${user.email!}" readonly>

        <label>Имя:</label>
        <input type="text" name="name" value="${user.name!}" required>

        <label>Новый пароль (необязательно):</label>
        <input type="password" name="password" placeholder="Оставьте пустым, чтобы не менять">

        <button type="submit">Сохранить</button>
        <a href="${contextPath!""}/profile">Отмена</a>
    </form>
</div>

<#include "footer.ftl">
