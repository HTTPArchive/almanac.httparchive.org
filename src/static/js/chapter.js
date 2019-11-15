//Data Save can be set to on, so let's check it
function dataSaverEnabled() {
  let dataSaver = false;
  if ('connection' in navigator) {
    dataSaver = navigator.connection.saveData;
    if (dataSaver) {
      console.log('DataSaver is enabled');
      gtag('event', 'data-saver', { 'event_category': 'user', 'event_label': 'enabled', 'value': 1 });
    } else {
      gtag('event', 'data-saver', { 'event_category': 'user', 'event_label': 'not-enabled', 'value': 0 });
    }
  }

  return dataSaver;
}

//iOS causes Google Sheets to create a 6000 by 3700 canvas, which annoyingly isn't supported by iOS!
//Let's check if we have large Canvas support (annoyingly no API for this!)
function highResolutionCanvasSupported() {

  let largeCanvasSupported = false;

  try {
    // Set large sized canvas dimensions and draw test rectangle
    const cvs = document ? document.createElement('canvas') : null;
    const ctx = cvs && cvs.getContext ? cvs.getContext('2d') : null;
    cvs.width = 6000;
    cvs.height = 3700;
    ctx.fillRect(5999, 3699, 1, 1);
    largeCanvasSupported = Boolean(ctx.getImageData(5999, 3699, 1, 1).data[3]) == 1;
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

//We use Google Sheets for detailed visualisations
//Check for support and switch out images if supported
function upgradeInteractiveFigures() {

  try {
    if (highResolutionCanvasSupported() && !dataSaverEnabled()) {

      let sheetsAllowed = true;

      const sheets_url = 'https://docs.google.com/spreadsheets/';

      //Google Sheets is sometimes blocked by companies/proxies so let's check for that
      //Unfortunately no easy way to check this as cannot make non-CORS request to
      //Another domain and can't check status response when CORS domain :-(
      //Below seems to work for my corporate proxy anyway
      fetch(window.sheets_url, { method: 'HEAD', mode: 'no-cors' })
        .then(function (r) {
          //If response status is 0 then means CORS is blocking it, which Sheets requires
          //Which means it made it as proxies block with a 403 before getting that far,
          //or error completely.
          if (response.status != 0) {
            sheetsAllowed = false;
            gtag('event', 'sheets-access', { 'event_category': 'user', 'event_label': 'blocked', 'value': 0 });
          } else {
            console.log('Upgrading to interactive figures');

            //Set the Google Sheets iframe
            let all_fig_imgs = document.querySelectorAll('figure img');

            all_fig_imgs.forEach(function (fig_img) {

              if (fig_img.getAttribute('data-src')) {

                var iframe = document.createElement('iframe');

                //Set up some default attributes
                iframe.setAttribute('aria-describedby', fig_img.getAttribute('aria-describedby'));
                iframe.setAttribute('title', fig_img.getAttribute('alt'));
                iframe.setAttribute('width', fig_img.dataset.width || "600");
                iframe.setAttribute('height', fig_img.dataset.height || '371');
                iframe.setAttribute('seamless', fig_img.dataset.seamless || '');
                iframe.setAttribute('frameborder', fig_img.dataset.frameborder || '0');
                iframe.setAttribute('scrolling', fig_img.dataset.scrolling || 'no');
                iframe.setAttribute('loading', fig_img.dataset.loading || 'lazy');
                iframe.setAttribute('src', fig_img.dataset.src);

                //The figure should have a link
                const parentLink = fig_img.parentNode;
                if (parentLink.nodeName == "A") {

                  //Insert the iframe before the link.
                  parentLink.parentNode.insertBefore(iframe, parentLink);

                  //Add the fig-mobile class to hide the img in desktop view
                  parentLink.classList.add("fig-mobile");
                }

              }
            });
            gtag('event', 'interactive-figures', { 'event_category': 'user', 'event_label': 'enabled', 'value': 1 });
          }
        }).catch(function (err) {
          console.error('Error' + e);
          gtag('event', 'sheets-access', { 'event_category': 'user', 'event_label': 'blocked', 'value': 0 });
          gtag('event', 'interactive-figures', { 'event_category': 'user', 'event_label': 'not-enabled', 'value': 0 });
        });
    } else {
      gtag('event', 'interactive-figures', { 'event_category': 'user', 'event_label': 'not-enabled', 'value': 0 });
    }
  } catch (e) {
    console.error('Error' + e);
    gtag('event', 'interactive-figures', { 'event_category': 'user', 'event_label': 'not-enabled', 'value': 0 });
  }
}

function setDiscussionCount() {
  try {
    if (window.discussion_url) {
      fetch(window.discussion_url)
        .then(function (r) { return r.json(); })
        .then(function (r) {
          if (!r) {
            return;
          }

          var comments = +r.posts_count - 1;
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
  } catch (e) {
    console.error('Error' + e);
    gtag('event', 'discussion-count', { 'event_category': 'user', 'event_label': 'not-enabled', 'value': 0 });
  }
}

upgradeInteractiveFigures();
setDiscussionCount();


