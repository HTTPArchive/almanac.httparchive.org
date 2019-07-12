const languageSelect = document.querySelector('.language-switcher');
languageSelect.addEventListener('change', (e) => {
  if (e.target.value) {
    window.location = e.target.value;
  }
});
