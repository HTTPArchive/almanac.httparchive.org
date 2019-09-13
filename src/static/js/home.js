const menu = document.querySelector(".menu");
const menuIcon = document.querySelector(".menu-icon");
const menuCloseIcon = document.querySelector(".menu-close-icon");

menuIcon.addEventListener('click', () => {
  menu.style.display = "flex";
  menuIcon.style.display = "none";
  menuCloseIcon.style.display = "block";
});

menuCloseIcon.addEventListener('click', () => {
  menu.style.display = "none";
  menuIcon.style.display = "block";
  menuCloseIcon.style.display = "none";
});
