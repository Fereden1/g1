<#ftl encoding="UTF-8">
<#assign pageTitle = "Личный кабинет">
<#assign pageCss = "auth.css">
<#include "header.ftl">

<div class="container">
    <h2>Личный кабинет</h2>
    <p><b>Email:</b> ${userEmail}</p>
    <p><b>Имя:</b> ${userName}</p>
    <p><b>Роль:</b> ${userRole?if_exists}</p>

    <a href="${contextPath!""}/profile/edit" class="btn btn-edit">Редактировать</a>
    <a href="${contextPath!""}/profile/delete" class="btn btn-delete" onclick="return confirm('Удалить аккаунт?')">Удалить</a>
    <a href="${contextPath!""}/logout" class="btn btn-logout">Выйти</a>
</div>

<#include "footer.ftl">
