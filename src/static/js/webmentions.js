// Code related to parsing and showing webmentions

// Gets the webmentions json data from current URL
async function getWebmentions(targetURL) {
  const apiURL = `https://webmention.io/api/mentions.jf2?perPage=500&target=${targetURL}`;
  let mentions = []
  try {
    const response = await window.fetch(apiURL);
    if (response.status >= 200 && response.status < 300) {
      const json = await response.json();
      mentions = json.children;
    } else {
      gtag('event', 'error', { 'event_category': 'webmentions.js', 'event_label': response.statusText, 'value': 1 });
    }
  } catch(error) {
    gtag('event', 'error', { 'event_category': 'webmentions.js', 'event_label': error, 'value': 1 });
  }
  return mentions;
}

// Format published date into human readable form
function formatDate(dateString){
  const options = { year: "numeric", month: "long", day: "numeric" }
  return new Date(dateString).toLocaleDateString(undefined, options)
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

// Renders webmention into different sections, based on the type
function renderReactions(reactions, reactionType) {
  // Add the count to the reaction tab
  document.querySelector(`#${reactionType}-count`).textContent = reactions.length;
  const reactionLabel = document.querySelector(`#${reactionType}-label`);
  if (reactions && reactions.length ===1) {
    reactionLabel.textContent = reactionLabel.getAttribute("data-singular");
  }

  // Render logic for the reaction types
  const webmentionReactionsList = document.createElement("ul");
  webmentionReactionsList.setAttribute("class", `webmention-${reactionType}`);
  reactions.forEach(function(reaction) {
    const reactionLI = document.createElement("li");
    reactionLI.setAttribute("class", `webmention-${reactionType}-item`);

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
    const reactionDIVContent = document.createElement("div");
    const reactionDIVMeta = document.createElement("div");
    if (reactionType === "replies" || reactionType === "mentions") {
      const reactionSTRONG = document.createElement("strong");
      reactionSTRONG.setAttribute("class", "webmention-author-name");
      reactionSTRONG.textContent = reaction["author"]["name"];
      reactionA.appendChild(reactionSTRONG);

      reactionDIVContent.setAttribute("class", "webmention-content");
      reactionDIVContent.textContent = reaction["content"]["text"];

      reactionDIVMeta.setAttribute("class", "webmention-meta");

      const reactionTIME = document.createElement("time");
      reactionTIME.setAttribute("class", "webmention-pub-date");
      reactionTIME.setAttribute("datetime", reaction["published"]);
      reactionTIME.textContent = formatDate(reaction["published"]);

      const reactionSPAN = document.createElement("span");
      reactionSPAN.setAttribute("class", "webmention-divider");
      reactionSPAN.setAttribute("aria-hidden", "true");
      reactionSPAN.textContent = " ⋅ ";

      const reactionASource = document.createElement("a");
      reactionASource.setAttribute("class", "webmention-source");
      reactionASource.setAttribute("href", reaction["url"]);
      reactionASource.textContent = document.querySelector(".reactions").getAttribute("data-source");

      reactionDIVMeta.appendChild(reactionTIME);
      reactionDIVMeta.appendChild(reactionSPAN);
      reactionDIVMeta.appendChild(reactionASource);
    }

    reactionLI.appendChild(reactionA);
    if (reactionType === "replies" || reactionType === "mentions") {
      reactionLI.appendChild(reactionDIVContent);
      reactionLI.appendChild(reactionDIVMeta);
    }
    webmentionReactionsList.appendChild(reactionLI);
  });
  document.querySelector(`#${reactionType}-panel`).appendChild(webmentionReactionsList);
}

// Parses and renders mentions into likes, reposts, replies and mentions
function renderWebmentions(webmentions) {
  if (!webmentions.length) {
    return;
  }

  const likes = parseMentions(webmentions, "like-of");
  const reposts = parseMentions(webmentions, "repost-of");
  const replies = parseMentions(webmentions, "in-reply-to");
  const mentions = parseMentions(webmentions, "mention-of");

  if (likes.length) {
    renderReactions(likes, "likes");
  }

  if (reposts.length) {
    renderReactions(reposts, "reposts");
  }

  if (replies.length) {
    renderReactions(replies, "replies");
  }

  if (mentions.length) {
    renderReactions(mentions, "mentions");
  }
}

// Process webmention promise
function processWebmentions(targetURL) {
  getWebmentions(targetURL)
    .then(webmentions => renderWebmentions(webmentions))
    .catch(e => gtag('event', 'error', { 'event_category': 'webmentions.js', 'event_label': e, 'value': 1 }))
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
