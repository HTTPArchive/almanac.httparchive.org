const menu = document.querySelector('.menu');
const menuIcon = document.querySelector('.menu-icon');
const menuCloseIcon = document.querySelector('.menu-close-icon');

menuIcon.addEventListener('click', () => {
  menu.classList.toggle("hidden");
  menuIcon.classList.toggle("hidden");
  menuCloseIcon.classList.toggle("hidden");
});

menuCloseIcon.addEventListener('click', () => {
  menu.classList.toggle("hidden");
  menuIcon.classList.toggle("hidden");
  menuCloseIcon.classList.toggle("hidden");
});
