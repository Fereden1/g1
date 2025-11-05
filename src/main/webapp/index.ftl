<#-- index.ftl -->
<#ftl encoding="UTF-8">
<#assign pageTitle = "Home English School">
<#assign pageCss = "style.css">
<#-- установить contextPath в servlet перед рендером: model.put("contextPath", req.getContextPath()); -->
<#include "header.ftl">

<section id="top" class="hero">
    <div class="wrap center">
        <h1>Изучайте английский легко и с удовольствием!</h1>
        <p>Курсы для начинающих, продвинутых и даже для пилотов ✈️</p>
        <a href="#courses" class="bigbtn">Выбрать курс</a>
    </div>
</section>

<section id="courses" class="section">
    <div class="wrap center">
        <h2>Выберите курс</h2>
        <p>Нажмите на курс, чтобы отправить заявку</p>

        <div class="course-grid">
            <div class="course-card" data-course="conversational-basic" onclick="openApplicationModal('conversational-basic')">
                <div class="emoji">🗣️</div>
                <h3>Разговорный английский — Базовый</h3>
                <p>Подходит тем, кто только начинает изучение языка.</p>
            </div>

            <div class="course-card" data-course="conversational-advanced" onclick="openApplicationModal('conversational-advanced')">
                <div class="emoji">💬</div>
                <h3>Разговорный английский — Продвинутый</h3>
                <p>Для тех, кто хочет уверенно говорить на любые темы.</p>
            </div>

            <div class="course-card" data-course="aviation-pilots" onclick="openApplicationModal('aviation-pilots')">
                <div class="emoji">✈️</div>
                <h3>Авиационный английский для пилотов</h3>
                <p>Подготовка к международным стандартам ICAO.</p>
            </div>

            <div class="course-card" data-course="aviation-dispatchers" onclick="openApplicationModal('aviation-dispatchers')">
                <div class="emoji">🛫</div>
                <h3>Английский для диспетчеров</h3>
                <p>Коммуникация и терминология управления полетами.</p>
            </div>
        </div>
    </div>
</section>

<#-- Application modal (тот же HTML, что и у вас) -->
<div id="applicationModal" class="modal hidden">
    <div class="modal-inner">
        <span class="close" onclick="closeModal()">&times;</span>
        <h3 id="modalTitle">Оставить заявку</h3>

        <form id="applicationForm" method="post" action="${contextPath!""}/submitApplication">
            <input type="hidden" id="selectedCourseId" name="courseType">

            <div class="frow">
                <label for="userName">Ваше имя *</label>
                <input type="text" id="userName" name="studentName" required value="${userName!}">
            </div>

            <div class="frow">
                <label for="userEmail">Email *</label>
                <input type="email" id="userEmail" name="email" required value="${userEmail!}">
            </div>

            <div class="frow">
                <label for="userPhone">Телефон *</label>
                <input type="tel" id="userPhone" name="phone" required pattern="^\+?[0-9]{7,15}$" title="Введите телефон в формате +71234567890">
            </div>

            <div class="frow">
                <label for="userMessage">Ваши цели и пожелания</label>
                <textarea id="userMessage" name="message" rows="4"></textarea>
            </div>

            <button type="submit" class="sendbtn">Отправить заявку</button>
        </form>
    </div>
</div>

<script src="${contextPath!""}/static/js/site.js"></script>
<#include "footer.ftl">
