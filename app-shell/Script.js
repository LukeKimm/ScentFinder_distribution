// 설치용 앱 화면. Xcode 템플릿의 ViewController.swift 가 show(platform, enabled, useSettings) 를 부르고,
// "open-preferences" 메시지를 받으면 Safari 확장 설정을 엽니다. (그 약속은 그대로 유지)

const lang = (navigator.language || 'en').toLowerCase().startsWith('ko') ? 'ko' : 'en';
document.documentElement.lang = lang;
document.querySelectorAll('[data-ko]').forEach(el => {
    el.textContent = el.getAttribute(`data-${lang}`) || el.getAttribute('data-en');
});

function show(platform, enabled, useSettingsInsteadOfPreferences) {
    document.body.classList.add(`platform-${platform}`);
    if (typeof enabled === 'boolean') {
        document.body.classList.toggle('state-on', enabled);
        document.body.classList.toggle('state-off', !enabled);
    } else {
        document.body.classList.remove('state-on');
        document.body.classList.remove('state-off');
    }
}

function openPreferences() {
    webkit.messageHandlers.controller.postMessage('open-preferences');
}

const btn = document.querySelector('button.open-preferences');
if (btn) btn.addEventListener('click', openPreferences);
