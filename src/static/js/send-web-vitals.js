function sendWebVitals() {

  function sendWebVitalsGAEvents({name, delta, id, attribution, navigationType}) {

    let webVitalInfo = '(not set)';

    switch (name) {
      case 'CLS':
        webVitalInfo = attribution.largestShiftTarget;
        break;
      case 'FID':
        webVitalInfo = attribution.eventTarget;
        break;
      case 'LCP':
        webVitalInfo = attribution.element;
        break;
      case 'TTFB':
        webVitalInfo = attribution.connectionTime;
        break;
      case 'FCP':
        webVitalInfo = attribution.firstByteToFCP;
        break;
      case 'INP':
        webVitalInfo = attribution.eventTarget;
        break;
    }


    // Measure some other user preferences
    let dataSaver;
    let effectiveType;
    if ('connection' in navigator) {
      dataSaver = navigator.connection.saveData.toString();
      effectiveType = navigator.connection.effectiveType;
    }
    let deviceMemory;
    if ('deviceMemory' in navigator) {
      deviceMemory = navigator.deviceMemory.toString();
    }
    let prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches.toString();
    let prefersColorScheme;
    if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
      prefersColorScheme = 'dark';
    } else if (window.matchMedia('(prefers-color-scheme: light)').matches) {
      prefersColorScheme = 'light';
    } else if (window.matchMedia('(prefers-color-scheme: no preference)').matches) {
      prefersColorScheme = 'no preference';
    } else {
      prefersColorScheme = 'not supported';
    }

    gtag('event', name, {
      event_category: 'Web Vitals',
      value: Math.round(name === 'CLS' ? delta * 1000 : delta),
      event_label: id,
      non_interaction: true,

      // See: https://web.dev/debug-web-vitals-in-the-field/
      dimension1: webVitalInfo,
      dimension2: effectiveType,
      dimension3: dataSaver,
      dimension4: deviceMemory,
      dimension5: prefersReducedMotion,
      dimension6: prefersColorScheme,
      dimension7: navigationType,
    });
  }

  // As the web-vitals script and this script is set with defer in order, so it should be loaded
  if (webVitals) {
    webVitals.onFCP(sendWebVitalsGAEvents);
    webVitals.onLCP(sendWebVitalsGAEvents);
    webVitals.onCLS(sendWebVitalsGAEvents);
    webVitals.onTTFB(sendWebVitalsGAEvents);
    webVitals.onFID(sendWebVitalsGAEvents);
    webVitals.onINP(sendWebVitalsGAEvents);
  } else {
    console.error('Web Vitals is not loaded!!');
  }

}

sendWebVitals();
