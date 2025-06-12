/* global gtag */

// Code related to parsing and showing webmentions
// And Share button

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

  const lang = document.querySelector("html").getAttribute("lang");

  let plural_rules;
  try {
    plural_rules = new Intl.PluralRules(lang);
  } catch {
    return;
  }

  // Singular
  if (plural_rules.select(length) === "one") {
    reactionLabel.textContent = reactionLabel.dataset.singular;
    return;
  }

  // Few - alternative plural (Used by "ru" and "uk")
  if (reactionLabel.dataset.plural_alt !== "" && plural_rules.select(length) === "few") {
    reactionLabel.textContent = reactionLabel.dataset.plural_alt;
    return;
  }

  // If a plural exists use that.
  if (reactionLabel.dataset.plural) {
    reactionLabel.textContent = reactionLabel.dataset.plural;
    return;
  }

  // Everything else sticks with the default
  return;

}

// Renders webmention into different sections, based on the type
function renderReactions(webmentions, reactionType, wmProperty) {
  // Process webmentions
  const reactions = parseMentions(webmentions, wmProperty);

  if (!reactions || !reactions.length || !document.querySelector(`#${reactionType}-count`) || !document.querySelector(`#${reactionType}-label`)) {
    return;
  }

  // Add the count to the reaction tab and, if non-zero then unhide
  document.querySelector(`#${reactionType}-count`).textContent = reactions.length;
  if (reactions.length > 0) {
    document.querySelector(`#${reactionType}-tab`).classList.remove("no-reactions");
    document.querySelector('#reactions').classList.remove("no-reactions");
  }
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
    const authorName = reaction["author"]["name"] ? reaction["author"]["name"] : reactionA.hostname;
    reactionA.setAttribute("title", authorName);
    reactionA.setAttribute("aria-label", authorName);

    if (reaction["author"] && reaction["author"]["photo"]) {
      const reactionIMG = document.createElement("img");
      reactionIMG.setAttribute("class", "webmention-author-avatar");
      reactionIMG.setAttribute("src", reaction["author"]["photo"]);
      reactionIMG.setAttribute("alt", authorName);
      reactionIMG.setAttribute("loading", "lazy");
      reactionIMG.setAttribute("width", "60");
      reactionIMG.setAttribute("height", "60");
      reactionA.appendChild(reactionIMG);
    }

    // Replies and mentions have some extra HTML
    const reactionDivContent = document.createElement("div");
    const reactionDivMeta = document.createElement("div");
    if (reactionType === "replies" || reactionType === "mentions") {
      const reactionSTRONG = document.createElement("strong");
      reactionSTRONG.setAttribute("class", "webmention-author-name");
      reactionSTRONG.textContent = authorName;
      reactionA.appendChild(reactionSTRONG);

      reactionDivContent.setAttribute("class", "webmention-content");
      if (reaction["content"]) {

        const maxLength = 350;
        const lookBack = 100;

        let webMentionContent = reaction["content"]["text"];
        const length = webMentionContent.length;

        // If we've a really long webmention then want to only show a subset of it
        if (length > maxLength) {

          // Check to see if we can find a mention of us:
          const webMentionFirstMention = webMentionContent.search(/(web ?almanac|http ?archive)/i);

          // If there is a mention and it is not near the beginning
          // then start from just before that mention, else start at beginning
          const start = webMentionFirstMention > lookBack ? webMentionFirstMention - lookBack : 0;

          //  Calculate the end
          const stop = start + Math.min(maxLength, length - start);

          // Substring the webmention to the required length
          webMentionContent = webMentionContent.substring(start, stop);

          // Add elipses to start or end.
          if (start > 0) webMentionContent = "…" + webMentionContent;
          if (stop < length) webMentionContent = webMentionContent + "…";

        }

        reactionDivContent.textContent = webMentionContent;
      }

      reactionDivMeta.setAttribute("class", "webmention-meta");

      const reactionTime = document.createElement("time");
      reactionTime.setAttribute("class", "webmention-pub-date");
      const pubDate = reaction["published"] ? reaction["published"] : reaction["wm-received"];
      if (pubDate) {
        reactionTime.setAttribute("datetime", pubDate);
        reactionTime.textContent = formatDate(pubDate);
      }

      const reactionSpan = document.createElement("span");
      reactionSpan.setAttribute("class", "webmention-divider");
      reactionSpan.setAttribute("aria-hidden", "true");
      reactionSpan.textContent = " ⋅ ";

      const reactionASource = document.createElement("a");
      reactionASource.setAttribute("class", "webmention-source");
      reactionASource.setAttribute("href", reaction["url"]);
      reactionASource.textContent = document.querySelector(".reactions").dataset.source;

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

function setActiveTab() {

  // The default is likes so we have "likes" then all good:
  const likesTab = document.querySelector('#likes-tab');
  if (!likesTab || !likesTab.classList.contains('no-reactions')) {
    return;
  }

  // If no likes, then try each in turn and find the first one with reactions
  for (const tab of ["reposts-tab", "replies-tab", "mentions-tab"]) {
    const tabElement = document.querySelector(`#${tab}`);
    if (!tabElement.classList.contains('no-reactions')) {
      changeTabs(tabElement);
      return;
    }
  }

}

// Parses and renders mentions into likes, reposts, replies and mentions
function renderWebmentions(webmentions) {
  if (!document.querySelector('.webmentions-cta')) {
    return;
  }

  if (!webmentions.length) {
    document.querySelector('#cta-container').classList.remove('invisible');
    return;
  }

  renderReactions(webmentions, "likes", "like-of");
  renderReactions(webmentions, "reposts", "repost-of");
  renderReactions(webmentions, "replies", "in-reply-to");
  renderReactions(webmentions, "mentions", "mention-of");

  // Show count of reactions (except if 0)
  if (webmentions.length > 0) {
    document.querySelectorAll('.num-reactions').forEach(t => t.textContent = webmentions.length);
    document.querySelectorAll('.reactions-label').forEach(t => setReactionsLabel(webmentions.length, t));
    document.querySelector('.webmentions-cta').classList.remove('hidden');
  }
  document.querySelector('#cta-container').classList.remove('invisible');

  // Set the first active tab (in case no "likes" so that tab is hidden)
  setActiveTab();
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


// Change tabs for webmentions UI
function handleShareButton() {
    // DOM references
  const button = document.querySelector('.share-cta');
  const appleIcon = button.querySelector('.apple-icon');
  const androidIcon = button.querySelector('.android-icon');
  const canonical = document.querySelector('link[rel="canonical"]');

  // Feature detection to see if the Web Share API is supported.
  if (!('share' in navigator)) {
    return;
  }

  // Find out if the user is on a device made by Apple and, if so, switch the icon.
  if (/Mac|iPhone/.test(navigator.platform)) {
    appleIcon.classList.remove('hidden');
    androidIcon.classList.add('hidden');
  }

  button.addEventListener('click', async () => {
    // Title and text are identical, since the title may actually be ignored.
    const title = document.title;
    const text = document.title;
    // Use the canonical URL, if it exists, else, the current location.
    const url = canonical?.href || location.href;

    gtag('event', 'WebShare', {
      'event_category': 'clicks',
      'event_label': url,
      'transport_type': 'beacon',
      'value': 1
    })

    try {
      await navigator.share({
        url,
        text,
        title,
      });
      return;
    } catch (err) {
      // If the user cancels, an `AbortError` is thrown.
      if (err.name !== "AbortError") {
        console.error(err.name, err.message);
        gtag('event', 'error', {
          'event_category': 'WebShare',
          'event_label': err.message,
          'transport_type': 'beacon',
          'value': 1
        })
      }
    }
  });
  button.classList.remove('hidden');
}

if (!window.location.search.includes('nowebmentions')) {
  handleShareButton();
  addTabListeners();
  const BASE_URL = "https://almanac.httparchive.org";
  processWebmentions(BASE_URL + window.location.pathname);
}
