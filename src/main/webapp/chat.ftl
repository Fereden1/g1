<#ftl encoding="UTF-8">
<#assign pageTitle = "Отзывы студентов">
<#assign pageCss = "chat.css">
<#include "header.ftl">

<section class="section">
    <div class="wrap center">
        <h1>Отзывы студентов</h1>
        <p>Выберите курс, чтобы прочитать отзывы и оставить свой комментарий</p>

        <div class="course-grid">
            <div class="course-card" data-course="basic" onclick="openChat('BASIC')">
                <div class="emoji">🗣️</div>
                <h3>Разговорный — Базовый</h3>
                <p>Отзывы о базовом курсе</p>
            </div>

            <div class="course-card" data-course="advanced" onclick="openChat('ADVANCED')">
                <div class="emoji">💬</div>
                <h3>Разговорный — Продвинутый</h3>
                <p>Отзывы о продвинутом курсе</p>
            </div>

            <div class="course-card" data-course="pilots" onclick="openChat('PILOTS')">
                <div class="emoji">✈️</div>
                <h3>Английский для пилотов</h3>
                <p>Отзывы о курсе авиационного английского</p>
            </div>

            <div class="course-card" data-course="dispatchers" onclick="openChat('DISPATCHERS')">
                <div class="emoji">🛫</div>
                <h3>Английский для диспетчеров</h3>
                <p>Отзывы о курсе английского для диспетчеров</p>
            </div>
        </div>

        <div id="chat-section" class="hidden chat-box" aria-live="polite">
            <div class="chat-header">
                <h2 id="chat-title"></h2>
                <button class="close-chat" onclick="closeChatSection()">&times;</button>
            </div>

            <div id="messages" class="messages-box"></div>

            <form id="chatForm" class="chat-input" onsubmit="sendComment(event)">
                <textarea id="chatInput" name="text" placeholder="Напишите ваш отзыв о курсе..." required></textarea>
                <button type="submit">Отправить</button>
            </form>
        </div>
    </div>
</section>

<script>
    /* =========== простой JS для чата (можно вынести в static/js/chat.js) ============
       Здесь показана работа с вашими servlet'ами /chat/list и /chat/send
       Комментарии помогут понять — вы учитесь.
    */
    const context = "${contextPath!""}";

    function openChat(course) {
        document.getElementById('chat-section').classList.remove('hidden');
        document.getElementById('chat-title').textContent = 'Отзывы: ' + course;
        loadComments(course);
        // сохраняем текущий курс в form (чтобы ChatSendServlet знал)
        document.getElementById('chatForm').dataset.course = course;
    }

    function closeChatSection() {
        document.getElementById('chat-section').classList.add('hidden');
    }

    async function loadComments(course) {
        const resp = await fetch(`${context}/chat/list?course=${encodeURIComponent(course)}`);
        if (!resp.ok) {
            document.getElementById('messages').innerHTML = '<div class="error">Ошибка загрузки комментариев</div>';
            return;
        }
        const data = await resp.json();
        const box = document.getElementById('messages');
        box.innerHTML = '';
        if (data.length === 0) {
            box.innerHTML = '<div class="no-messages">Пока нет комментариев — будьте первым!</div>';
            return;
        }
        data.forEach(c => {
            const el = document.createElement('div');
            el.className = 'message';
            el.innerHTML = `<div class="message-header"><div class="author">${escapeHtml(c.name)}</div><div class="time">${escapeHtml(c.time)}</div></div>
                        <div class="text">${escapeHtml(c.text)}</div>`;
            box.appendChild(el);
        });
    }

    function escapeHtml(s){ return String(s||'').replace(/[&<>"]/g, (m)=> ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[m])); }

    async function sendComment(e) {
        e.preventDefault();
        const textarea = document.getElementById('chatInput');
        const course = e.target.dataset.course || 'BASIC';
        const body = new URLSearchParams();
        body.append('text', textarea.value);
        body.append('course', course);

        const resp = await fetch(`${context}/chat/send`, { method: 'POST', headers: {'Content-Type':'application/x-www-form-urlencoded; charset=UTF-8'}, body: body.toString() });
        if (resp.ok) {
            textarea.value = '';
            loadComments(course);
        } else {
            alert('Ошибка отправки: ' + resp.statusText);
        }
    }
</script>

<#include "footer.ftl">
