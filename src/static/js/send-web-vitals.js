function sendWebVitals() {

  function getSelector(node, maxLen = 100) {
    let sel = '';
    try {
      while (node && node.nodeType !== 9) {
        const part = node.id ? '#' + node.id : node.nodeName.toLowerCase() + (
          (node.className && node.className.length) ?
          '.' + Array.from(node.classList.values()).join('.') : '');
        if (sel.length + part.length > maxLen - 1) return sel || part;
        sel = sel ? part + '>' + sel : part;
        if (node.id) break;
        node = node.parentNode;
      }
    } catch (err) {
      // Do nothing...
    }
    return sel;
  }

  function getLargestLayoutShiftEntry(entries) {
    return entries.reduce((a, b) => a && a.value > b.value ? a : b);
  }

  function getLargestLayoutShiftSource(sources) {
    return sources.reduce((a, b) => {
      return a.node && a.previousRect.width * a.previousRect.height >
          b.previousRect.width * b.previousRect.height ? a : b;
    });
  }

  function sendWebVitalsGAEvents({name, delta, id, entries}) {

    let webVitalInfo = '(not set)';
    // Set a custom dimension for more info for any CVW breaches
    // In some cases there won't be any entries (e.g. if CLS is 0,
    // or for LCP after a bfcache restore), so we have to check first.
    if (entries.length) {
      if (name === 'LCP') {
        const lastEntry = entries[entries.length - 1];
        webVitalInfo =  getSelector(lastEntry.element);
      } else if (name === 'FID') {
        const firstEntry = entries[0];
        webVitalInfo = getSelector(firstEntry.target);
      } else if (name === 'CLS') {
        const largestEntry = getLargestLayoutShiftEntry(entries);
        if (largestEntry && largestEntry.sources && largestEntry.sources.length) {
          const largestSource = getLargestLayoutShiftSource(largestEntry.sources);
          if (largestSource) {
            webVitalInfo = getSelector(largestSource.node);
          }
        }
      }
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
