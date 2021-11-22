// Code related to parsing and showing webmentions

// Gets the webmentions json data from current URL
async function getWebmentions(targetURL) {
  const apiURL = `https://webmention.io/api/mentions.jf2?perPage=500&target=${targetURL}`;
  let mentions = []
  try {
    const response = await window.fetch(apiURL);
    if (response.status >= 200 && response.status < 300) {
      json = await response.json();
      mentions = json.children;
    } else {
      console.error("Could not parse response", response.statusText);
    }
  } catch(error) {
    console.error("Request failed", error);
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

// Renders webmention likes
function renderLikes(likes) {
  // Add the likes count to the likes-tab
  document.querySelector('#likes-count').innerHTML = likes.length;
  let likeHtmlElements = [];
  likes.forEach(function(like) {
    const likeHtml = `
      <li class="webmention-likes-item">
        <a
          class="webmention-author"
          href="${like["url"]}"
          title="${like["author"]["name"]}"
          aria-label="${like["author"]["name"]} liked this chapter"
        >
          <img
            class="webmention-author-avatar"
            src="${like["author"]["photo"]}"
            loading="lazy" width="60" height="60"/>
        </a>
      </li>
    `;
    likeHtmlElements.push(likeHtml);
  })
  document.querySelector("#likes-panel").innerHTML = `
    <ul class="webmention-likes">
      ${likeHtmlElements.join("\n")}
    </ul>
  `;
}

// Renders webmention reposts
function renderReposts(reposts) {
  // Add the reposts count to the reposts-tab
  document.querySelector('#reposts-count').innerHTML = reposts.length;
  let repostHtmlElements = [];
  reposts.forEach(function(repost) {
    const repostHtml = `
      <li class="webmention-repost-item">
        <a
          class="webmention-author"
          href="${repost["url"]}"
          title="${repost["author"]["name"]}"
          aria-label="${repost["author"]["name"]} reposted this chapter"
        >
          <img
            class="webmention-author-avatar"
            src="${repost["author"]["photo"]}"
            loading="lazy" width="60" height="60"/>
        </a>
      </li>
    `;
    repostHtmlElements.push(repostHtml);
  })
  document.querySelector("#reposts-panel").innerHTML = `
    <ul class="webmention-reposts">
      ${repostHtmlElements.join("\n")}
    </ul>
  `;
}

// Renders webmention replies
function renderReplies(replies) {
  // Add the replies count to the replies-tab
  document.querySelector('#replies-count').innerHTML = replies.length;
  let repliesHtmlElements = [];
  replies.forEach(function(reply) {
    const replyHtml = `
      <li class="webmention-reply-item">
        <a class="webmention-author" href="${reply["author"]["url"]}">
          <img
            class="webmention-author-avatar"
            src="${reply["author"]["photo"]}"
            loading="lazy" width="60" height="60"/>
          <strong class="webmention-author-name">${reply["author"]["name"]}</strong>
        </a>
        <div class="webmention-content">
          ${reply["content"]["html"]}
        </div>
        <div class="webmention-meta">
          <time
            class="webmention-pub-date"
            datetime="${reply["published"]}"
          >
            ${formatDate(reply["published"])}
          </time>
          <span class="webmention-divider" aria-hidden="true">⋅</span>
          <a
            class="webmention-source"
            href="${reply["url"]}"
            aria-label="View source of reply by ${reply["author"]["name"]}"
          >View Source</a>
        </div>
      </li>
    `;
    repliesHtmlElements.push(replyHtml);
  })
  document.querySelector("#replies-panel").innerHTML = `
    <ul class="webmention-replies">
      ${repliesHtmlElements.join("\n")}
    </ul>
  `;
}

// Renders webmention mentions
function renderMentions(mentions) {
  // Add the replies count to the replies-tab
  document.querySelector('#mentions-count').innerHTML = mentions.length;
  let mentionsHtmlElements = [];
  mentions.forEach(function(mention) {
    const mentionContent = mention["content"] ? mention["content"]["html"] : (
      `Source: <a href="${mention["wm-source"]}">${mention["wm-source"]}</a>`
    );
    const mentionHtml = `
      <li class="webmention-mention-item">
        <a class="webmention-author" href="${mention["author"]["url"]}">
          <img
            class="webmention-author-avatar"
            src="${mention["author"]["photo"]}"
            loading="lazy" width="60" height="60"/>
          <strong class="webmention-author-name">${mention["author"]["name"]}</strong>
        </a>
        <div class="webmention-content">
          ${mentionContent}
        </div>
        <div class="webmention-meta">
          <time
            class="webmention-pub-date"
            datetime="${mention["published"]}"
          >
            ${formatDate(mention["published"])}
          </time>
          <span class="webmention-divider" aria-hidden="true">⋅</span>
          <a
            class="webmention-source"
            href="${mention["url"]}"
            aria-label="View source of mention by ${mention["author"]["name"]}"
          >View Source</a>
        </div>
      </li>
    `;
    mentionsHtmlElements.push(mentionHtml);
  })
  document.querySelector("#mentions-panel").innerHTML = `
    <ul class="webmention-mentions">
      ${mentionsHtmlElements.join("\n")}
    </ul>
  `;
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
    renderLikes(likes);
  }

  if (reposts.length) {
    renderReposts(reposts);
  }

  if (replies.length) {
    renderReplies(replies);
  }

  if (mentions.length) {
    renderMentions(mentions);
  }
}

// Process webmention promise
function processWebmentions(targetURL) {
  getWebmentions(targetURL)
    .then(webmentions => renderWebmentions(webmentions))
    .catch(e => console.error(e))
}

// Change tabs for webmentions UI
function changeTabs(e) {
  const target = e.target;
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
    tab.addEventListener("click", changeTabs);
  });

  // Enable arrow navigation between tabs in the tab list
  let tabFocus = 0;

  tabList.addEventListener("keydown", e => {
    if (e.keyCode === 39 || e.keyCode === 37) {
      tabs[tabFocus].setAttribute("tabindex", -1);
      // Move right
      if (e.keyCode === 39) {
        tabFocus++;
        // If we're at the end, go to the start
        if (tabFocus >= tabs.length) {
          tabFocus = 0;
        }
        // Move left
      } else if (e.keyCode === 37) {
        tabFocus--;
        // If we're at the start, move to the end
        if (tabFocus < 0) {
          tabFocus = tabs.length - 1;
        }
      }

      tabs[tabFocus].setAttribute("tabindex", 0);
      tabs[tabFocus].focus();
    }
  });
}

window.addEventListener("DOMContentLoaded", () => {
  addTabListeners();
  const BASE_URL = "https://almanac.httparchive.org"
  processWebmentions(BASE_URL + window.location.pathname);
});
