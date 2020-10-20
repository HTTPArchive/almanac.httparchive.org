//This function removes the lazy-loading attributes from all img and iframe tags
//Useful for print view for example (https://bugs.chromium.org/p/chromium/issues/detail?id=875403)
function removeLazyLoading() {

  //If no Array.from then pretty sure there will be no native lazy-loading support to remove!
  if (Array.from) {
    console.log("Removing lazy loading...");
    
    Array.from(document.querySelectorAll('img[loading], iframe[loading]')).forEach(function(element) {
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
    console.log ("Print Mode");
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

      console.log('Upgrading to interactive figures');

      //Find each image and create the iframe
      var all_fig_imgs = document.querySelectorAll('figure img');

      for (var index = 0; index < all_fig_imgs.length; ++index) {
        var fig_img = all_fig_imgs[index];

        if (fig_img.getAttribute('data-iframe')) {

          var iframe = document.createElement('iframe');

          //Set up some default attributes
          iframe.setAttribute('title', fig_img.getAttribute('alt'));
          iframe.setAttribute('class', 'fig-iframe');
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
          var el = document.getElementById('num_comments');
          el.innerText = comments;
          
          document.getElementById(comments === 1 ? 'comment-singular' : 'comment-plural').removeAttribute('data-translation');
          
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
  if (window.matchMedia('(max-width: 600px)').matches) {
    return;
  }

    //Only activate this if IntersectionObserver is supported
  if(!('IntersectionObserver' in window)) {
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

    if(oldIndexLink) {
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
  var observer = new IntersectionObserver(function(entries) {
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
    if(description) {
      description.classList.remove('visually-hidden');
      description.classList.add('fig-description');
      description.hidden = true;
    }
  }

}

indexHighlighter();
addShowDescription();
removeLazyLoadingOnPrint();
upgradeInteractiveFigures();
setDiscussionCount();
