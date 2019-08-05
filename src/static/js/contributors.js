const buttons = document.querySelectorAll('.filter-container button');
const contributors = document.querySelector('.contributors');

for (let button of buttons) {
  button.addEventListener('click', e => {
    const teamId = e.target.className;
    contributors.classList.toggle(teamId);
  });
}
