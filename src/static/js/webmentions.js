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
        <a class="webmention-author" href="${like["url"]}" aria-label="${like["author"]["name"]} liked this chapter">
          <img class="webmention-author-avatar" src="${like["author"]["photo"]}" />
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
        <a class="webmention-author" href="${repost["url"]}" aria-label="${repost["author"]["name"]} liked this chapter">
          <img class="webmention-author-avatar" src="${repost["author"]["photo"]}" />
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

}

// Parses and renders mentions into likes, reposts, replies and mentions
async function renderWebmentions(targetURL) {
  const webmentions = await getWebmentions(targetURL);
  if (!webmentions.length) {
    return;
  }

  const likes = parseMentions(webmentions, "like-of");
  const reposts = parseMentions(webmentions, "repost-of");
  const replies = parseMentions(webmentions, "in-reply-to");

  if (likes.length) {
    renderLikes(likes);
  }

  if (reposts.length) {
    renderReposts(reposts);
  }

  if (replies.length) {
    renderReplies(replies);
  }
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
  renderWebmentions("https://almanac.httparchive.org/ru/2020/css");
});
