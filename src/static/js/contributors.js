const style = document.querySelector('style');
const buttons = document.querySelectorAll('.filter-container button');
const contributors = document.querySelector('.contributors');

for (let button of buttons) {
  const buttonClassName = button.className;

  // Dynamically generate CSS that reacts to contributors' view state and buttons' toggle state
  style.textContent += `
  .contributors.${buttonClassName} .contributor.${buttonClassName} {
    display: block;
  }

  .contributors.${buttonClassName} button.${buttonClassName} {
    background: #0053ba;
    color: white;
  }
  `;

  button.addEventListener('click', e => {
    const teamId = e.target.className;
    contributors.classList.toggle(teamId);
  });
}
