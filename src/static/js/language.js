const supportedLang = ['en', 'ja'];

const langSwitcher = document.querySelector('.language-switcher');

langSwitcher.addEventListener('change', (e) => {
  if (e.target.value) {
    window.location.href =
      updatePath(window.location.pathname, e.target.value);
  }
});

function updatePath(path, value) {
  // Current path has no lang prefix
  if (path.length === 1) {
    return path + value;
  }

  const langPrefix = path.substring(1,3);
  if (supportedLang.includes(langPrefix) && path[3] === '/') {
    return path.replace(langPrefix, value);
  }
}

const defaultOption = document.querySelector('.default-language');
const alternateOptions = document.querySelectorAll('.alternate-language');

// Generate default language option
defaultOption.innerHTML = generateOptionText(defaultOption.value);

// Generate alternate languages' options
for (i = 0; i < alternateOptions.length; i++) {
  alternateOptions[i].innerHTML = generateOptionText(alternateOptions[i].value);
}

function generateOptionText(language) {
  switch(language) {
    case 'en':
      return '🇬🇧 English';
    case 'ja':
      return '🇯🇵 Japanese';
  }
}
