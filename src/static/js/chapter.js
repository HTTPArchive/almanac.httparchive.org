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
  for (index = 0; index < all_fig_imgs.length; ++index) {
    var fig_img = all_fig_imgs[index];
    fig_img.classList.remove("fig-mobile");
  }

  var all_fig_iframes = document.querySelectorAll('figure .fig-iframe');
  for (index = 0; index < all_fig_iframes.length; ++index) {
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
    if (bigEnoughForInteractiveFigures() && !dataSaverEnabled() && highBandwidthConnection() && highResolutionCanvasSupported()) {

      console.log('Upgrading to interactive figures');

      //Find each image and create the iframe
      var all_fig_imgs = document.querySelectorAll('figure img');

      for (index = 0; index < all_fig_imgs.length; ++index) {
        var fig_img = all_fig_imgs[index];

        if (fig_img.getAttribute('data-src')) {

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
          iframe.setAttribute('src', fig_img.dataset.src);

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
    if (window.discussion_url) {
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
          el.innerText = comments + ' ' + (comments == 1 ? 'comment' : 'comments');
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

upgradeInteractiveFigures();
setDiscussionCount();
