function sendWebVitals() {
  function sendWebVitalsGAEvents({name, delta, id}) {
    gtag('event', name, {
      event_category: 'Web Vitals',
      value: Math.round(name === 'CLS' ? delta * 1000 : delta),
      event_label: id,
      non_interaction: true,
    });
  }

  // As the web-vitals script and this script is set with defer in order, so it should be loaded
  if (webVitals) {
    webVitals.getFCP(sendWebVitalsGAEvents);
    webVitals.getLCP(sendWebVitalsGAEvents);
    webVitals.getCLS(sendWebVitalsGAEvents);
    webVitals.getTTFB(sendWebVitalsGAEvents);
    webVitals.getFID(sendWebVitalsGAEvents);
  } else {
    console.error('Web Vitals is not loaded!!');
  }

}

sendWebVitals();
