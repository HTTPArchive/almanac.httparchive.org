const languageSwitchers = document.querySelectorAll('.language-switcher');

for (let i = 0; i < languageSwitchers.length; i++) {
  languageSwitchers[i].addEventListener('change', (e) => {
    if (e.target.value) {
      window.location = e.target.value;
    }
  });
}
