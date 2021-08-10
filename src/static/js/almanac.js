// These are the core menu options

// Language, Year and ToC select switcher (mobile)
function handleSelectSwitchers() {
  var languageYearSwitchers = document.querySelectorAll('.language-switcher select, .year-switcher select, .table-of-contents-switcher select');
  for (var i = 0; i < languageYearSwitchers.length; i++) {
    languageYearSwitchers[i].addEventListener('change', function (e) {

      var selectedOption = this.options[this.selectedIndex];

      if (e.target.dataset.label && selectedOption.dataset.event) {
        gtag('event', selectedOption.dataset.event, {
          'event_category': 'clicks',
          'event_label': e.target.dataset.label,
          'transport_type': 'beacon',
          'value': 1
        })
      }

      //Reset the selector back in case user uses Back button
      var selectedValue = e.target.value;
      if (selectedValue && selectedValue !== window.location.pathname) {
        e.target.value = window.location.pathname;
        window.location = selectedValue;
      }
    });
  }
}

// Search, Language, Year and ToC menus (desktop)
function handleNavMenu() {

  function closeAnyOtherOpenDropdown(e) {

    // If the click was in a menu that's already open then ignore as just been opened.
    if (e.target.classList.contains('dropdown-open')) {
      return
    };

    // If the click was in search nav, then ignore as don't want to close search menu.
    var searchNavs = document.querySelectorAll('.search-nav ul:not(hidden)');
    for (var i = 0; i < searchNavs.length; i++) {
      if (searchNavs[i].contains(e.target)) {
          return
      }
    }

    // Else a click elsewhere so close all the menus
    var openDropdownBtn = document.querySelector('.nav-dropdown-btn.dropdown-open');
    openDropdownBtn && openDropdownBtn.click();
  }

  function trapFocusInList(e) {
    var list = e.currentTarget;
    var isInFooter = list.classList.contains('footer-list');
    if (e.key === "ArrowDown") {
      var siblingElem = isInFooter ? e.target.parentElement.previousElementSibling : e.target.parentElement.nextElementSibling;
      var focusableElem = siblingElem ? siblingElem.querySelector('a') : (isInFooter ? lastFocusableElementInList : firstFocusableElementInList);
      e.preventDefault();
      focusableElem.focus();
    } else if (e.key === "ArrowUp") {
      var siblingElem = isInFooter ? e.target.parentElement.nextElementSibling : e.target.parentElement.previousElementSibling;
      var focusableElem = siblingElem ? siblingElem.querySelector('a') : (isInFooter ? firstFocusableElementInList : lastFocusableElementInList);
      e.preventDefault();
      focusableElem.focus();
    } else if (e.key === "Escape") {
      var navDropDown = e.currentTarget.closest('.nav-dropdown');
      var navDropDownBtn = navDropDown.querySelector('.nav-dropdown-btn');
      navDropDownBtn.click();
      navDropDownBtn.focus();
    }
  }

  var firstFocusableElementInList, lastFocusableElementInList;
  function toggleDropdownVisibility(e) {
    var dropdownBtn = e.currentTarget;
    var dropdown = dropdownBtn.closest('.nav-dropdown');
    var list = dropdown.querySelector('.nav-dropdown-list');
    var isListVisible = !list.classList.toggle('hidden');
    var dropdownOpen = dropdownBtn.classList.toggle('dropdown-open');
    dropdownBtn.setAttribute('aria-expanded', dropdownOpen);

    if (isListVisible) {
      var btnBoundingRect = dropdownBtn.getBoundingClientRect();
      var listBoundingRect = list.getBoundingClientRect();
      if (listBoundingRect.width <= btnBoundingRect.width) {
        list.classList.add("align-center");
      } else if (btnBoundingRect.left + listBoundingRect.width > window.innerWidth) {
        list.classList.add("align-right");
      }
      document.body.addEventListener('click', closeAnyOtherOpenDropdown, true);
      var navItems = list.querySelectorAll('a');
      firstFocusableElementInList = navItems[0];
      lastFocusableElementInList = navItems[navItems.length - 1];
      list.addEventListener('keydown', trapFocusInList);
    } else {
      list.removeEventListener('keydown', trapFocusInList);
      document.body.removeEventListener('click', closeAnyOtherOpenDropdown, true);
    }
  }

  // Might need to change menu hanging direction on window resize to avoid overflow
  function checkNavDropdown() {
    var list = window.document.querySelector('.dropdown-open ~ .nav-dropdown-list');
    var dropdownBtn = window.document.querySelector('button.dropdown-open');
    // If no open menu, then we're done
    if (!list || !dropdownBtn) {
      return;
    }
    var btnBoundingRect = dropdownBtn.getBoundingClientRect();
    var listBoundingRect = list.getBoundingClientRect();
    if (listBoundingRect.width <= btnBoundingRect.width) {
      list.classList.remove("align-right");
      list.classList.add("align-center");
    } else if (btnBoundingRect.left + listBoundingRect.width > window.innerWidth) {
      list.classList.remove("align-center");
      list.classList.add("align-right");
    } else {
      list.classList.remove("align-center");
      list.classList.remove("align-right");
    }
  }
  window.onresize = checkNavDropdown;

  function navBtnKeyDownHandler(e) {
    var dropdownList = e.currentTarget.nextElementSibling;
    var isDropdownOpen = e.currentTarget.classList.contains('dropdown-open');
    var isInFooter = dropdownList.classList.contains('footer-list');
    if (e.key === "Escape") {
      e.currentTarget.click();
    } else if (e.key === "ArrowDown") {
      e.preventDefault();
      !isDropdownOpen && e.currentTarget.click();
      (isInFooter ? dropdownList.lastElementChild : dropdownList.firstElementChild).querySelector('a').focus();
    } else if (isInFooter && e.key === "ArrowUp") {
      e.preventDefault();
      !isDropdownOpen && e.currentTarget.click();
      dropdownList.firstElementChild.querySelector('a').focus();
    }
  }

  var navDropdownButtons = document.querySelectorAll('.nav-dropdown-btn');
  for (var i = 0; i < navDropdownButtons.length; i++) {
    navDropdownButtons[i].addEventListener('click', toggleDropdownVisibility);
    navDropdownButtons[i].addEventListener('keydown', navBtnKeyDownHandler);
  }
}

// The main mobile hamburger menu
function handleMobileMenu() {
  var menuBtn = document.querySelector('.menu-btn');
  var menuNav = document.querySelector('#menu');

  function toggleNavMenu() {
    var menuOpen = document.body.classList.toggle('menu-open');
    menuBtn.classList.toggle("menu-btn--active");
    menuBtn.setAttribute('aria-expanded', menuOpen);
    var ariaLabel = menuOpen ? menuBtn.getAttribute('data-close-text') : menuBtn.getAttribute('data-open-text');
    menuBtn.setAttribute('aria-label', ariaLabel);

    /* When you open the menu, add an event listener to close it when clicking outside the menu area */
    /* Remove it on closing the menu */
    if (menuBtn.getAttribute('aria-expanded') === 'true') {
      document.body.addEventListener('click', toggleNavMenu, false);
    } else {
      document.body.removeEventListener('click', toggleNavMenu, false);
    }
  }

  menuBtn.addEventListener('click', function (event) {
    toggleNavMenu();
    event.stopPropagation();
  });

  /* Add a click listener to menu so when it's open it swallows click to avoid above click closing it */
  menuNav.addEventListener('click', function (event) {
    event.stopPropagation();
  });

  menuNav.addEventListener('keydown', function (event) {
    if (event.key === 'Escape') {
      if (menuBtn.getAttribute('aria-expanded') === 'true') {
        toggleNavMenu();
        menuBtn.focus();
      }
    }
  });
}

// We can add click events to elements (e.g. ebook) and get event label from data-event attribute
function handleDataEvents() {
  document.querySelectorAll('[data-event]').forEach(trackableElement => {
    trackableElement.addEventListener('click', function (event) {
      gtag('event', event.target.dataset.event, {
        'event_category': 'clicks',
        'event_label': event.target.dataset.label,
        'transport_type': 'beacon',
        'value': 1
      })
    });
  });
}

// Now we're all set up, activate all the elements that depend on JavaScript.
// We do this in inline JS in the page after header loads to get those items displaying
// correctly and avoid the initial CLS (even before above runs which is a bit cheeky to be honest!)
// but need to do it again as other JS-elements will now have loaded further down the page
function activateJavaScriptElements() {
  document.querySelectorAll('.js-hide').forEach(element => {
    // Don't just hide it - delete it completely to avoid any specifity issues
    element.parentNode.removeChild(element);
  });
  document.querySelectorAll('.js-enable').forEach(element => {
    element.classList.remove('js-enable');
    element.classList.remove('hidden');
    element.disabled = false;
    element.hidden = false;
  });
}

//This function removes the lazy-loading attributes from all img and iframe tags
//Useful for print view for example (https://bugs.chromium.org/p/chromium/issues/detail?id=875403)
function removeLazyLoading() {

  //If no Array.from then pretty sure there will be no native lazy-loading support to remove!
  if (Array.from) {
    console.log("Removing lazy loading...");

    Array.from(document.querySelectorAll('img[loading], iframe[loading]')).forEach(function (element) {
      element.removeAttribute('loading');
    });
  }
}

//Add an event handler to remove LazyLoading when entering print mode
function removeLazyLoadingOnPrint() {
  if ("onbeforeprint" in window) {
    window.onbeforeprint = removeLazyLoading;
  }

}

//Check if in print mode so we can remove lazy loading and block interactive visuals
function isInPrintMode() {
  var printMode = false;

  if (window.URL && window.URLSearchParams) {
    var url = new URL(window.location);
    printMode = url.searchParams.has('print');
  }
  if (printMode) {
    console.log("Print Mode");
    removeLazyLoading();
  }
  gtag('event', 'print-mode', { 'event_category': 'user', 'event_label': '' + printMode, 'value': +printMode })
  return printMode;

}

//Check if the screen meets minimum size requirements for Interactive figures
//At the moment we base it on 600px break point matching CSS but it does not need to be the same
function bigEnoughForInteractiveFigures() {
  if (!(window.matchMedia('(max-width: 600px)').matches)) {
    gtag('event', 'min-sheets-width', { 'event_category': 'user', 'event_label': 'true', 'value': 1 });
    return true;
  }
  gtag('event', 'min-sheets-width', { 'event_category': 'user', 'event_label': 'false', 'value': 0 });
  console.log('Screen too small for interactive visuals');
  return false;
}

//Data Save can be set to on, so let's check it
function dataSaverEnabled() {
  var dataSaver = false;
  if ('connection' in navigator) {
    dataSaver = navigator.connection.saveData;
    if (dataSaver) {
      console.log('DataSaver is enabled');
      gtag('event', 'data-saver', { 'event_category': 'user', 'event_label': 'enabled', 'value': 1 });
    } else {
      gtag('event', 'data-saver', { 'event_category': 'user', 'event_label': 'not-enabled', 'value': 0 });
    }
  } else {
    gtag('event', 'data-saver', { 'event_category': 'user', 'event_label': 'not-reported', 'value': 0 });
  }

  return dataSaver;
}

//Check if network API states this is a high bandwidth connection
//Assume it is for those browsers who do not support this (e.g. Safari and IE)
function highBandwidthConnection() {
  var highBandwidth = true;
  if ('connection' in navigator) {
    const effectiveType = navigator.connection.effectiveType;
    if (effectiveType == 'slow-2g' || effectiveType == '2g' || effectiveType == '3g') {
      highBandwidth = false;
      console.log('effectiveType ' + effectiveType + ' is low BandWidth');
      gtag('event', 'connection-type', { 'event_category': 'user', 'event_label': effectiveType, 'value': 0 });
    } else {
      gtag('event', 'connection-type', { 'event_category': 'user', 'event_label': effectiveType, 'value': 1 });
    }
  } else {
    gtag('event', 'connection-type', { 'event_category': 'user', 'event_label': 'not-reported', 'value': 1 });
  }

  return highBandwidth;
}

//iOS causes Google Sheets to create a 6000 by 3700 canvas, which annoyingly isn't supported by iOS!
//Let's check if we have large Canvas support (annoyingly no API for this!)
function highResolutionCanvasSupported() {

  var largeCanvasSupported = false;

  try {
    // Set large sized canvas dimensions and draw test rectangle
    var cvs = document ? document.createElement('canvas') : null;
    var ctx = cvs && cvs.getContext ? cvs.getContext('2d') : null;
    var scale = window.devicePixelRatio || 1;
    if (scale > 1) {
      cvs.width = 6000;
      cvs.height = 3700;
      ctx.fillRect(5999, 3699, 1, 1);
      largeCanvasSupported = Boolean(ctx.getImageData(5999, 3699, 1, 1).data[3]) == 1;
    } else {
      cvs.width = 1200;
      cvs.height = 742;
      ctx.fillRect(1199, 741, 1, 1);
      largeCanvasSupported = Boolean(ctx.getImageData(1199, 741, 1, 1).data[3]) == 1;
    }
  }
  catch (e) {
    largeCanvasSupported = false;
  }

  if (largeCanvasSupported) {
    gtag('event', 'hi-res-canvas', { 'event_category': 'user', 'event_label': 'supported', 'value': 1 });
  } else {
    console.log('High resolution canvas images are not supported');
    gtag('event', 'hi-res-canvas', { 'event_category': 'user', 'event_label': 'not-supported', 'value': 0 });
  }

  return largeCanvasSupported;

};

//If google sheets test pixel works, then can assume interactive sheets work and can remove it
function googleSheetsPixelLoaded() {
  this.parentElement.removeChild(this);
  gtag('event', 'sheets-access', { 'event_category': 'user', 'event_label': 'successful', 'value': 1 });
  gtag('event', 'interactive-figures', { 'event_category': 'user', 'event_label': 'enabled', 'value': 1 });
}

//If google sheets test pixel doesn't work, then revert back to static images
function googleSheetsPixelNotLoaded() {
  console.error('Google Sheets cannot be loaded');

  this.parentElement.removeChild(this);

  var all_fig_imgs = document.querySelectorAll('figure .fig-mobile');
  for (var index = 0; index < all_fig_imgs.length; ++index) {
    var fig_img = all_fig_imgs[index];
    fig_img.classList.remove("fig-mobile");
  }

  var all_fig_iframes = document.querySelectorAll('figure .fig-iframe');
  for (var index = 0; index < all_fig_iframes.length; ++index) {
    var fig_iframe = all_fig_iframes[index];
    fig_iframe.parentElement.removeChild(fig_iframe);
  }
  gtag('event', 'sheets-access', { 'event_category': 'user', 'event_label': 'blocked', 'value': 0 });
  gtag('event', 'interactive-figures', { 'event_category': 'user', 'event_label': 'not-enabled', 'value': 0 });

}

//We use Google Sheets for detailed visualisations
//Check for support and switch out images if supported
function upgradeInteractiveFigures() {

  try {
    if (!isInPrintMode() && bigEnoughForInteractiveFigures() && !dataSaverEnabled() && highBandwidthConnection() && highResolutionCanvasSupported()) {

      //Find each image and create the iframe
      var all_fig_imgs = document.querySelectorAll('figure img[data-iframe]');

      //If no figures with a data-iframe, then we're done
      if (all_fig_imgs.length == 0) {
        return;
      }

      console.log('Upgrading to interactive figures');

      for (var index = 0; index < all_fig_imgs.length; ++index) {
        var fig_img = all_fig_imgs[index];

        if (fig_img.getAttribute('data-iframe')) {

          var iframe = document.createElement('iframe');

          //Set up some default attributes
          iframe.setAttribute('title', fig_img.getAttribute('alt'));
          iframe.setAttribute('class', 'fig-iframe');
          iframe.setAttribute('tabindex', '-1'); // Google embeds are currently not keyboard interactive so disable tabindex
          if (fig_img.getAttribute('aria-labelledby')) {
            iframe.setAttribute('aria-labelledby', fig_img.getAttribute('aria-labelledby'));
          }
          if (fig_img.getAttribute('aria-describedby')) {
            iframe.setAttribute('aria-describedby', fig_img.getAttribute('aria-describedby'));
          }
          iframe.setAttribute('width', fig_img.dataset.width || "600");
          iframe.setAttribute('height', fig_img.dataset.height || '371');
          iframe.setAttribute('seamless', fig_img.dataset.seamless || '');
          iframe.setAttribute('frameborder', fig_img.dataset.frameborder || '0');
          iframe.setAttribute('scrolling', fig_img.dataset.scrolling || 'no');
          iframe.setAttribute('loading', fig_img.dataset.loading || 'lazy');
          iframe.setAttribute('src', fig_img.dataset.iframe);

          //The figure should have a link
          var parentLink = fig_img.parentNode;
          if (parentLink.nodeName == "A") {

            //Insert the iframe before the link.
            parentLink.parentNode.insertBefore(iframe, parentLink);

            //Add the fig-mobile class to hide the img in desktop view
            parentLink.classList.add("fig-mobile");
          }

        }
      };

      //Add a test image to check we can actually access Google Sheets
      //as it's sometimes blocked by corporate proxies and the like
      //have a fallback function to revert if this is the case
      var google_sheets_pixel = document.createElement('img');
      google_sheets_pixel.setAttribute('src', 'https://docs.google.com/favicon.ico');
      google_sheets_pixel.setAttribute('height', '1');
      google_sheets_pixel.setAttribute('width', '1');
      google_sheets_pixel.addEventListener('load', googleSheetsPixelLoaded);
      google_sheets_pixel.addEventListener('error', googleSheetsPixelNotLoaded);
      window.document.body.appendChild(google_sheets_pixel);

    } else {
      gtag('event', 'interactive-figures', { 'event_category': 'user', 'event_label': 'not-enabled', 'value': 0 });
    }
  } catch (err) {
    console.error('Error' + err);
    gtag('event', 'interactive-figures', { 'event_category': 'user', 'event_label': 'not-enabled', 'value': 0 });
  }
}

function setDiscussionCount() {
  try {
    if (window.discussion_url && window.fetch) {
      fetch(window.discussion_url)
        .then(function (response) { return response.json(); })
        .then(function (response) {
          if (!response) {
            return;
          }

          var comments = + response.posts_count - 1;
          if (isNaN(comments)) {
            return;
          }
          document.querySelectorAll('.num_comments').forEach(el => {
            el.innerText = comments;
          });

          if (comments === 1) {
            document.querySelectorAll('.comment-singular').forEach(el => {
              el.removeAttribute('data-translation');
            });
          } else {
            document.querySelectorAll('.comment-plural').forEach(el => {
              el.removeAttribute('data-translation');
            });
          }

          gtag('event', 'discussion-count', { 'event_category': 'user', 'event_label': 'enabled', 'value': 1 });
        })
        .catch(function (err) {
          console.error(err);
          gtag('event', 'discussion-count', { 'event_category': 'user', 'event_label': 'not-enabled', 'value': 0 });
        });
    }
  } catch (err) {
    console.error('Error' + err);
    gtag('event', 'discussion-count', { 'event_category': 'user', 'event_label': 'not-enabled', 'value': 0 });
  }
}

function indexHighlighter() {

  // Don't implement this on mobile as won't be used
  // Note: do show on tablet in case needed when rotating into landscape
  if (window.matchMedia('(max-width: 37.5em)').matches) {
    return;
  }

  //Only activate this if IntersectionObserver is supported
  if (!('IntersectionObserver' in window)) {
    gtag('event', 'index-highlighter', { 'event_category': 'user', 'event_label': 'not-enabled', 'value': 0 });
    return;
  }

  var chapterIndex = document.querySelector('.index-box');

  // If no index - then nothing to do!
  if (!chapterIndex) {
    return;
  }

  // Check if user has set reduced motion and only continue if not
  var hasOSReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  if (hasOSReducedMotion) {
    console.log('User has set prefers-reduced-motion to ' + hasOSReducedMotion + ' so not highlighting the current section in chapter index');
    gtag('event', 'prefers-reduced-motion', { 'event_category': 'user', 'event_label': 'reduce', 'value': 0 });
    gtag('event', 'index-highlighter', { 'event_category': 'user', 'event_label': 'not-enabled', 'value': 0 });
    return;
  }

  // Check if 'position:sticky' is supported (as this is not great UX when not so don't bother)
  // Add the sticky class (which sets 'position:sticky') and then test if that stuck :-)
  // Also use endsWith to support vendor prefixes (Safari v12 needs this)
  chapterIndex.classList.add('sticky');
  var chapterIndexStyles = getComputedStyle(chapterIndex);
  if (!chapterIndexStyles || !chapterIndexStyles.position || !chapterIndexStyles.position.endsWith('sticky')) {
    gtag('event', 'index-highlighter', { 'event_category': 'user', 'event_label': 'not-enabled', 'value': 0 });
    return;
  }

  // Restrict the page height of the index to the page-height, as we're going to scroll this.
  chapterIndex.classList.add('page-height');

  // Create a function to handle highlighting a new index item
  // that will be called by the IntersectionObserver
  function highlightIndexEntry(link) {

    var indexLink = document.querySelector('.index-box a[href="#' + link + '"]');
    var oldIndexLink = document.querySelector('.index-box .active');

    if (!indexLink || indexLink.isEqualNode(oldIndexLink)) {
      return;
    }

    if (oldIndexLink) {
      oldIndexLink.classList.remove('active');
    }
    indexLink.parentNode.classList.add('active');

    // If the index is displayed in full then we're done!
    if (chapterIndex.scrollHeight <= chapterIndex.clientHeight) {
      return;
    }
    // Otherwise if too large to display in full then scroll to this element
    // We'd love to use scrollIntoView but unfortunately won't work if user
    // is still scrolling in main doc, so do it the old fashioned way
    var currentPosition = indexLink.offsetTop;
    var currentNode = indexLink;
    // Walk the node back up to the index-scroller to get the total offset
    // of this entry, relative to the full Index
    while (currentNode && currentNode.parentNode != chapterIndex) {
      currentPosition = currentPosition + currentNode.offsetTop;
      currentNode = currentNode.parentNode;
    }
    // Show the current image in the middle of the screen
    chapterIndex.scrollTop = currentPosition - (chapterIndex.clientHeight / 2);
  }

  // Set up a new Interstection Observer for when the title is 80% from the bottom of the page
  var options = {
    root: null,
    rootMargin: "0px 0px -80% 0px",
    threshold: null
  };
  var observer = new IntersectionObserver(function (entries) {
    for (var index = 0; index < entries.length; ++index) {
      var entry = entries[index];

      if (entry.isIntersecting && entry.target && entry.target.id) {
        highlightIndexEntry(entry.target.id);
      }
    }
  }, options);

  // Add an intersection observer to each heading
  var all_headings = document.querySelectorAll('article h1, article h2, article h3, article h4, article h5, article h6');
  for (var index = 0; index < all_headings.length; ++index) {
    var heading = all_headings[index];
    observer.observe(heading);
  };

  gtag('event', 'index-highlighter', { 'event_category': 'user', 'event_label': 'enabled', 'value': 0 });

}

function toggleDescription(event) {
  var event_button = event.target;
  if (!event_button) {
    return;
  }
  var description_id = event_button.getAttribute('aria-controls');
  if (!description_id) {
    return;
  }

  var description = document.querySelector('#' + description_id);
  if (!description) {
    return;
  }

  description.hidden = !description.hidden;
  event_button.setAttribute('aria-expanded', event_button.getAttribute('aria-expanded') == 'true' ? 'false' : 'true');
  event_button.innerHTML = event_button.getAttribute('aria-expanded') == 'true' ? event_button.getAttribute('data-hide-text') : event_button.getAttribute('data-show-text');

}

function addShowDescription() {
  var all_desc_buttons = document.querySelectorAll('.fig-description-button');

  for (var index = 0; index < all_desc_buttons.length; ++index) {
    var desc_button = all_desc_buttons[index];
    desc_button.addEventListener('click', toggleDescription);
    desc_button.hidden = false;
    var description = document.querySelector('#' + desc_button.getAttribute('aria-controls'));
    if (description) {
      description.classList.remove('visually-hidden');
      description.classList.add('fig-description');
      description.hidden = true;
    }
  }

}

function addKeyboardScollableRegions() {
  // If a table or code block is overflowing then should allow keyboard focus
  // More details - https://adrianroselli.com/2020/11/under-engineered-responsive-tables.html

  // Handle tables that have overflowed
  var all_table_containers = document.querySelectorAll('.table-wrap-container');
  for (var index = 0; index < all_table_containers.length; ++index) {
    var table_container = all_table_containers[index];

    if (table_container.scrollWidth > table_container.clientWidth) {
      var figure = table_container.parentElement.parentElement;
      if (figure && figure.nodeName == "FIGURE") {
        var figid = figure.id;
        var figcaption = figure.querySelector('figcaption');

        if (figid && figcaption) {
          figcaption.setAttribute('id', figid + '-caption');
          table_container.setAttribute('tabindex', '0');
          table_container.setAttribute('role', 'region');
          table_container.setAttribute('aria-labelledby', figid + '-caption');
        }
      }
    }
  }

  // Handle code blocks that have overflowed
  var all_pre_elements = document.querySelectorAll('pre');
  for (var index = 0; index < all_pre_elements.length; ++index) {
    var pre_element = all_pre_elements[index];

    if (pre_element.scrollWidth > pre_element.clientWidth) {
      pre_element.setAttribute('tabindex', '0');
      pre_element.setAttribute('role', 'region');
      pre_element.setAttribute('aria-label', `Code ${index}`);

    }
  }

}

function addShortKeyEventListers() {
  document.addEventListener("keyup", function onPress(event) {
    if (event.key === 'p' || event.key === 'P' || event.key === ',' || event.key === '<') {
      var previous = document.getElementById('previous-chapter');
      if (previous) {
        previous.click();
      }
    }
    if (event.key === 'n' || event.key === 'N' || event.key === '.' || event.key === '>') {
      var next = document.getElementById('next-chapter');
      if (next) {
        next.click();
      }
    }
    if (event.key === 'd' || event.key === 'D') {
      document.querySelectorAll('.fig-description-button').forEach(descButton => {
        descButton.click();
      });
    }
  });
}

function indexMenu() {
  var indexBox = document.querySelector('.index-box');
  var indexBoxTitle = document.querySelector('.index .index-btn');

  if (!indexBox || !indexBoxTitle) {
    return;
  }

  indexBoxTitle.addEventListener('click', function (e) {
    var indexOpen = indexBox.classList.toggle('show');
    indexBoxTitle.setAttribute('aria-expanded', indexOpen);
    var ariaLabel = indexOpen ? indexBoxTitle.getAttribute('data-close-text') : indexBoxTitle.getAttribute('data-open-text');
    indexBoxTitle.setAttribute('aria-label', ariaLabel);
  });

  indexBox.addEventListener("keydown", function onPress(event) {
    if (event.key === 'Escape') {
      if (indexBoxTitle.getAttribute('aria-expanded') === 'true') {
        indexBoxTitle.click();
        indexBoxTitle.focus();
      }
    }
  });
}

handleSelectSwitchers();
handleMobileMenu();
handleNavMenu();
handleDataEvents();
activateJavaScriptElements();
indexMenu();
indexHighlighter();
addShowDescription();
removeLazyLoadingOnPrint();
upgradeInteractiveFigures();
addKeyboardScollableRegions();
setDiscussionCount();
addShortKeyEventListers();
