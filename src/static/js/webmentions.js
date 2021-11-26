// Code related to parsing and showing webmentions

// Gets the webmentions json data from current URL
async function getWebmentions(targetURL) {
  const apiURL = `https://webmention.io/api/mentions.jf2?perPage=500&target=${targetURL}&sort-dir=up`;
  let mentions = [];
  try {
    const response = await window.fetch(apiURL);
    if (response.status >= 200 && response.status < 300) {
      const json = await response.json();
      mentions = json.children;
    } else {
      console.error("Could not parse response", response.statusText);
      gtag('event', 'error', { 'event_category': 'webmentions.js', 'event_label': response.statusText, 'value': 1 });
    }
  } catch(error) {
    console.error("Request failed", error);
    gtag('event', 'error', { 'event_category': 'webmentions.js', 'event_label': error, 'value': 1 });
  }
  return mentions;
}

// Format published date into human readable form
function formatDate(dateString){
  const options = { year: "numeric", month: "long", day: "numeric" }
  return new Date(dateString).toLocaleTimeString(undefined, options)
}

// Parse webmentions for individual category
function parseMentions(webmentions, mentionType) {
  let filteredMentions = []
  webmentions.forEach(function(mention){
    if (mention["wm-property"] == mentionType) {
      filteredMentions.push(mention)
    }
  });
  return filteredMentions;
}

// Parse webmentions for individual category
function setReactionsLabel(length, reactionLabel) {

  // Slavic plurals
  if (reactionLabel.getAttribute("data-plural-alt") !== "") {

    // Ends in 1 except 11
    if (length.toString().endsWith("1") && length != 11) {
      reactionLabel.textContent = reactionLabel.getAttribute("data-singular");
      return;
    }

    // Ends in 2,3 or 4 (except 12, 13, 14)
    const final_digit = length.toString().slice(-1);
    if (["2","3","4"].includes(final_digit) && length != 12 && length != 13 && length != 14) {
      reactionLabel.textContent = reactionLabel.getAttribute("data-plural-alt");
        return;
    }

    // Everything else Sticks with the default plural
    return;
  }

  // Non-slavic are simpler
  if (length === 1) {
    reactionLabel.textContent = reactionLabel.getAttribute("data-singular");
  }
}

// Renders webmention into different sections, based on the type
function renderReactions(webmentions, reactionType, wmProperty) {
  // Process webmentions
  const reactions = parseMentions(webmentions, wmProperty);
  if (!reactions.length || !document.querySelector(`#${reactionType}-count`) || !document.querySelector(`#${reactionType}-label`)) {
    return;
  }

  // Add the count to the reaction tab
  document.querySelector(`#${reactionType}-count`).textContent = reactions.length;
  const reactionLabel = document.querySelector(`#${reactionType}-label`);

  if (reactions && reactions.length) {
    setReactionsLabel(reactions.length, reactionLabel);
  }

  // Render logic for the reaction types
  const webmentionReactionsList = document.createElement("ul");
  webmentionReactionsList.setAttribute("class", `webmention-${reactionType}`);
  reactions.forEach(function(reaction) {
    const reactionLi = document.createElement("li");
    reactionLi.setAttribute("class", `webmention-${reactionType}-item`);

    const reactionA = document.createElement("a");
    reactionA.setAttribute("class", "webmention-author");
    reactionA.setAttribute("href", reaction["url"]);
    reactionA.setAttribute("title", reaction["author"]["name"]);
    reactionA.setAttribute("aria-label", reaction["author"]["name"]);

    const reactionIMG = document.createElement("img");
    reactionIMG.setAttribute("class", "webmention-author-avatar");
    reactionIMG.setAttribute("src", reaction["author"]["photo"]);
    reactionIMG.setAttribute("alt", reaction["author"]["name"]);
    reactionIMG.setAttribute("loading", "lazy");
    reactionIMG.setAttribute("width", "60");
    reactionIMG.setAttribute("height", "60");

    reactionA.appendChild(reactionIMG);

    // Replies and mentions have some extra HTML
    const reactionDivContent = document.createElement("div");
    const reactionDivMeta = document.createElement("div");
    if (reactionType === "replies" || reactionType === "mentions") {
      const reactionSTRONG = document.createElement("strong");
      reactionSTRONG.setAttribute("class", "webmention-author-name");
      reactionSTRONG.textContent = reaction["author"]["name"];
      reactionA.appendChild(reactionSTRONG);

      reactionDivContent.setAttribute("class", "webmention-content");
      reactionDivContent.textContent = reaction["content"]["text"];

      reactionDivMeta.setAttribute("class", "webmention-meta");

      const reactionTime = document.createElement("time");
      reactionTime.setAttribute("class", "webmention-pub-date");
      reactionTime.setAttribute("datetime", reaction["published"]);
      reactionTime.textContent = formatDate(reaction["published"]);

      const reactionSpan = document.createElement("span");
      reactionSpan.setAttribute("class", "webmention-divider");
      reactionSpan.setAttribute("aria-hidden", "true");
      reactionSpan.textContent = " ⋅ ";

      const reactionASource = document.createElement("a");
      reactionASource.setAttribute("class", "webmention-source");
      reactionASource.setAttribute("href", reaction["url"]);
      reactionASource.textContent = document.querySelector(".reactions").getAttribute("data-source");

      reactionDivMeta.appendChild(reactionTime);
      reactionDivMeta.appendChild(reactionSpan);
      reactionDivMeta.appendChild(reactionASource);
    }

    reactionLi.appendChild(reactionA);
    if (reactionType === "replies" || reactionType === "mentions") {
      reactionLi.appendChild(reactionDivContent);
      reactionLi.appendChild(reactionDivMeta);
    }
    webmentionReactionsList.appendChild(reactionLi);
  });
  document.querySelector(`#${reactionType}-panel`).appendChild(webmentionReactionsList);
}

// Parses and renders mentions into likes, reposts, replies and mentions
function renderWebmentions(webmentions) {
  if (!webmentions.length) {
    return;
  }

  renderReactions(webmentions, "likes", "like-of");
  renderReactions(webmentions, "reposts", "repost-of");
  renderReactions(webmentions, "replies", "in-reply-to");
  renderReactions(webmentions, "mentions", "mention-of");
}

// Process webmention promise
function processWebmentions(targetURL) {
  getWebmentions(targetURL)
    .then(webmentions => renderWebmentions(webmentions))
    .catch(e => {
      console.error(e)
      gtag('event', 'error', { 'event_category': 'webmentions.js', 'event_label': e, 'value': 1 })
    })
}

// Change tabs for webmentions UI
function changeTabs(target) {
  const parent = target.parentNode;
  const grandparent = parent.parentNode;

  // Remove all current selected tabs
  parent
    .querySelectorAll('[aria-selected="true"]')
    .forEach(t => t.setAttribute("aria-selected", false));

  // Set this tab as selected
  target.setAttribute("aria-selected", true);

  // Hide all tab panels
  grandparent
    .querySelectorAll('[role="tabpanel"]')
    .forEach(p => p.setAttribute("hidden", true));

  // Show the selected panel
  grandparent.parentNode
    .querySelector(`#${target.getAttribute("aria-controls")}`)
    .removeAttribute("hidden");
}

function addTabListeners() {
  const tabs = document.querySelectorAll('.reactions [role="tab"]');
  const tabList = document.querySelector('.reactions [role="tablist"]');

  if (!tabs || !tabList) {
    return;
  }
  // Add a click event handler to each tab
  tabs.forEach(tab => {
    tab.addEventListener("click", function(e){changeTabs(e.target)});
  });

  // Enable arrow navigation between tabs in the tab list
  let tabFocus = 0;

  tabList.addEventListener("keydown", e => {
    if (e.key === "ArrowRight" || e.key === "ArrowLeft") {
      tabs[tabFocus].setAttribute("tabindex", -1);
      // Move right
      if (e.key === "ArrowRight") {
        tabFocus++;
        // If we're at the end, go to the start
        if (tabFocus >= tabs.length) {
          tabFocus = 0;
        }
        // Move left
      } else if (e.key === "ArrowLeft") {
        tabFocus--;
        // If we're at the start, move to the end
        if (tabFocus < 0) {
          tabFocus = tabs.length - 1;
        }
      }

      tabs[tabFocus].setAttribute("tabindex", 0);
      tabs[tabFocus].focus();
      changeTabs(tabs[tabFocus]);
    }
  });
}


addTabListeners();
const BASE_URL = "https://almanac.httparchive.org";
processWebmentions(BASE_URL + window.location.pathname);
