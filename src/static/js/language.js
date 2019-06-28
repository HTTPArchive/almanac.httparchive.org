const languageSelect = document.querySelector('.language-switcher');
languageSelect.addEventListener('change', (e) => {
  if (e.target.value) {
    window.location = e.target.value;
  }
});

const languageOptions = document.querySelectorAll('.language-switcher option');
for (i = 0; i < languageOptions.length; i++) {
  languageOptions[i].innerHTML = generateOptionText(languageOptions[i].lang);
}

function generateOptionText(language) {
  switch(language) {
    case 'en':
      return '🇺🇸 English';
    case 'ja':
      return '🇯🇵 日本語';
  }
}
