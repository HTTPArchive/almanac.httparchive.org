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
  document.querySelector('#likes-count').textContent = likes.length;
  if (likes.length === 1) {
    document.querySelectorAll('.like-singular').forEach(el => {
      el.removeAttribute('data-translation');
    });
  } else {
    document.querySelectorAll('.like-plural').forEach(el => {
      el.removeAttribute('data-translation');
    });
  }

  const likePanel = document.querySelector("#likes-panel");
  const likeAriaText = likePanel.getAttribute("data-like-text");
  const webmentionLikesList = document.createElement("ul");
  webmentionLikesList.setAttribute("class", "webmention-likes");
  likes.forEach(function(like) {
    const likeHtml = `
      <li class="webmention-likes-item">
        <a
          class="webmention-author"
          href="${like["url"]}"
          title="${like["author"]["name"]}"
          aria-label="${like["author"]["name"]} ${likeAriaText}"
        >
          <img
            class="webmention-author-avatar"
            src="${like["author"]["photo"]}"
            loading="lazy" width="60" height="60"/>
        </a>
      </li>
    `;
    const parser = new DOMParser();
	  const likeHtmlObject = parser.parseFromString(likeHtml, 'text/html');
    webmentionLikesList.appendChild(likeHtmlObject.body.childNodes[0]);
  });
  likePanel.appendChild(webmentionLikesList);
}

// Renders webmention reposts
function renderReposts(reposts) {
  // Add the reposts count to the reposts-tab
  document.querySelector('#reposts-count').textContent = reposts.length;
  if (reposts.length === 1) {
    document.querySelectorAll('.repost-singular').forEach(el => {
      el.removeAttribute('data-translation');
    });
  } else {
    document.querySelectorAll('.repost-plural').forEach(el => {
      el.removeAttribute('data-translation');
    });
  }

  const repostPanel = document.querySelector("#reposts-panel");
  const repostAriaText = repostPanel.getAttribute("data-repost-text");
  const webmentionRepostsList = document.createElement("ul");
  webmentionRepostsList.setAttribute("class", "webmention-reposts");
  reposts.forEach(function(repost) {
    const repostHtml = `
      <li class="webmention-repost-item">
        <a
          class="webmention-author"
          href="${repost["url"]}"
          title="${repost["author"]["name"]}"
          aria-label="${repost["author"]["name"]} ${repostAriaText}"
        >
          <img
            class="webmention-author-avatar"
            src="${repost["author"]["photo"]}"
            loading="lazy" width="60" height="60"/>
        </a>
      </li>
    `;
    const parser = new DOMParser();
	  const repostHtmlObject = parser.parseFromString(repostHtml, 'text/html');
    webmentionRepostsList.appendChild(repostHtmlObject.body.childNodes[0]);
  });
  repostPanel.appendChild(webmentionRepostsList);
}

// Renders webmention replies
function renderReplies(replies) {
  // Add the replies count to the replies-tab
  document.querySelector('#replies-count').textContent = replies.length;
  if (replies.length === 1) {
    document.querySelectorAll('.reply-singular').forEach(el => {
      el.removeAttribute('data-translation');
    });
  } else {
    document.querySelectorAll('.reply-plural').forEach(el => {
      el.removeAttribute('data-translation');
    });
  }

  const replyPanel = document.querySelector("#replies-panel");
  const replyAriaText = replyPanel.getAttribute("data-reply-text");
  const webmentionRepliesList = document.createElement("ul");
  webmentionRepliesList.setAttribute("class", "webmention-replies");
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
            aria-label="${replyAriaText} ${reply["author"]["name"]}"
          >View Source</a>
        </div>
      </li>
    `;
    const parser = new DOMParser();
	  const replyHtmlObject = parser.parseFromString(replyHtml, 'text/html');
    webmentionRepliesList.appendChild(replyHtmlObject.body.childNodes[0]);
  });
  replyPanel.appendChild(webmentionRepliesList);
}

// Renders webmention mentions
function renderMentions(mentions) {
  // Add the mentions count to the mentions-tab
  document.querySelector('#mentions-count').textContent = mentions.length;
  if (mentions.length === 1) {
    document.querySelectorAll('.mention-singular').forEach(el => {
      el.removeAttribute('data-translation');
    });
  } else {
    document.querySelectorAll('.mention-plural').forEach(el => {
      el.removeAttribute('data-translation');
    });
  }

  const mentionPanel = document.querySelector("#mentions-panel");
  const mentionAriaText = mentionPanel.getAttribute("data-mention-text");
  const webmentionMentionsList = document.createElement("ul");
  webmentionMentionsList.setAttribute("class", "webmention-mentions");
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
            aria-label="${mentionAriaText} ${mention["author"]["name"]}"
          >View Source</a>
        </div>
      </li>
    `;
    const parser = new DOMParser();
	  const mentionHtmlObject = parser.parseFromString(mentionHtml, 'text/html');
    webmentionMentionsList.appendChild(mentionHtmlObject.body.childNodes[0]);
  });
  mentionPanel.appendChild(webmentionMentionsList);
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
    }
  });
}


addTabListeners();
const BASE_URL = "https://almanac.httparchive.org";
processWebmentions(BASE_URL + window.location.pathname);
