const buttons = document.querySelectorAll('button');

const buttonStates = Object.create(null);
for (let button of buttons) {
  // Default state is selected
  button.classList.add("selected");

  // Tracks buttons' toggle state
  buttonStates[button.classList[0]] = true;

  button.addEventListener("click", () => {
    buttonStates[button.classList[0]] = !buttonStates[button.classList[0]];
    filterContributors(toggleClass(button));
  });
}

// Toggle select/deselect button class
function toggleClass(button) {
  if (button.classList.contains("selected")) {
    button.classList.remove("selected");
    button.classList.add("deselected");
    return "deselect";
  }

  button.classList.remove("deselected");
  button.classList.add("selected");
  return "select";
}

// Filter contributors depending on which button has been selected/deselected
function filterContributors(action) {
  const contributors = document.querySelectorAll(".contributors div");
  let stateFound = false;

  for (let contributor of contributors) {
    for (let i = 0; i < contributor.classList.length; i++) {
      const className = contributor.classList[i];

      // Contributor contains a class that has state "true", we display the contributor
      if (action === "select" && buttonStates[className]) {
        contributor.style.display = "block";
        stateFound = true;
        break;
      }

      /* Contributor contains a class that has state "true" already,
      we preserve their display state */
      if (action === "deselect" && buttonStates[className]) {
        stateFound = true;
        break;
      }
    }

    /* The corresponding team's button states are false after iterating
    through the contributor's classList, we hide the contributor */
    if (!stateFound) {
      contributor.style.display = "none";
    }
    stateFound = false;
  }
}
