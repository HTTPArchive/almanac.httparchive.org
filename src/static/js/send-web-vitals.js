/* global gtag, webVitals */

function sendWebVitals() {

  function sendWebVitalsGAEvents({name, delta, value, id, attribution, navigationType}) {

    let overrides = {};

    function roundIfNotNull(x) {
      return x != null ? Math.round(x) : null;
    }

    switch (name) {
      case 'CLS':
        overrides = {
          debug_time: attribution.largestShiftTime,
          debug_load_state: attribution.loadState,
          debug_target: attribution.largestShiftTarget || '(not set)',
        };
        break;
      case 'FCP':
        overrides = {
          debug_time_to_first_byte: attribution.timeToFirstByte,
          debug_first_byte_to_fcp: attribution.firstByteToFCP,
          debug_load_state: attribution.loadState,
          debug_target: attribution.loadState || '(not set)',
        };
        break;
      case 'INP': {
        overrides = {
          debug_event: attribution.interactionType,
          debug_time: roundIfNotNull(attribution.interactionTime),
          debug_load_state: attribution.loadState,
          debug_target: attribution.interactionTarget || '(not set)',
          debug_interaction_delay: roundIfNotNull(attribution.inputDelay),
          debug_processing_duration: roundIfNotNull(attribution.processingDuration),
          debug_presentation_delay:  roundIfNotNull(attribution.presentationDelay),
          debug_totalPaintDuration: roundIfNotNull(attribution.totalPaintDuration),
          debug_totalScriptDuration: roundIfNotNull(attribution.totalScriptDuration),
          debug_totalStyleAndLayoutDuration: roundIfNotNull(attribution.totalStyleAndLayoutDuration),
          debug_totalUnattributedDuration: roundIfNotNull(attribution.totalUnattributedDuration),
          debug_longestScriptIntersectingDuration: roundIfNotNull(attribution.longestScript?.intersectingDuration),
          debug_longestScriptSubPart: attribution.longestScript?.subpart || null,
          debug_longestScriptInvoker: attribution.longestScript?.entry.invoker || null,
          debug_longestScriptInvokerType: attribution.longestScript?.entry.invokerType || null,
          debug_longestScriptName: attribution.longestScript?.entry.name || null,
        };
        break;
      }
      case 'LCP':
        overrides = {
          debug_url: attribution.url,
          debug_time_to_first_byte: attribution.timeToFirstByte,
          debug_resource_load_delay: attribution.resourceLoadDelay,
          debug_resource_load_time: attribution.resourceLoadTime,
          debug_element_render_delay: attribution.elementRenderDelay,
          debug_target: attribution.target || '(not set)',
        };
        break;
      case 'TTFB':
        overrides = {
          debug_waiting_time: attribution.waitingTime,
          debug_dns_time: attribution.dnsTime,
          debug_connection_time: attribution.connectionTime,
          debug_request_time: attribution.requestTime,
        };
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

    const params = Object.assign({
      event_category: 'Web Vitals',
      value: Math.round(name === 'CLS' ? delta * 1000 : delta),
      event_label: id,
      // Repeat with new fields to match web-vitals documentation
      // TODO deprecate above names when no longer required
      metric_value: Math.round(name === 'CLS' ? value * 1000 : value),
      metric_delta: Math.round(name === 'CLS' ? delta * 1000 : delta),
      metric_id: id,
      non_interaction: true,
      effective_type: effectiveType,
      data_saver: dataSaver,
      device_memory: deviceMemory,
      prefers_reduced_motion: prefersReducedMotion,
      prefers_color_scheme: prefersColorScheme,
      navigation_type: navigationType,
    }, overrides);

    gtag('event', name, params);

  }

  // As the web-vitals script and this script is set with defer in order, so it should be loaded
  if (webVitals) {
    webVitals.onFCP(sendWebVitalsGAEvents);
    webVitals.onLCP(sendWebVitalsGAEvents);
    webVitals.onCLS(sendWebVitalsGAEvents);
    webVitals.onTTFB(sendWebVitalsGAEvents);
    webVitals.onINP(sendWebVitalsGAEvents);
  } else {
    console.error('Web Vitals is not loaded!!');
  }

}

sendWebVitals();
