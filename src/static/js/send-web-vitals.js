/* global gtag, webVitals */

function sendWebVitals() {

  function getLoafAttribution(attribution) {
    const loafEntriesLength = attribution?.longAnimationFrameEntries?.length || 0;
    if (loafEntriesLength === 0) {
      return {};
    }

    let loafAttribution = {
      debug_loaf_script_total_duration: 0
    };

    // The last LoAF entry is usually the most relevant.
    const loaf = attribution.longAnimationFrameEntries.at(-1);
    const loafEndTime = loaf.startTime + loaf.duration;
    loaf.scripts.forEach(script => {
      if (script.duration <= loafAttribution.debug_loaf_script_total_duration) {
        return;
      }
      loafAttribution = {
        // Stats for the LoAF entry itself.
        debug_loaf_entry_start_time: loaf.startTime,
        debug_loaf_entry_end_time: loafEndTime,
        debug_loaf_entry_work_duration: loaf.renderStart ? loaf.renderStart - loaf.startTime : loaf.duration,
        debug_loaf_entry_render_duration: loaf.renderStart ? loafEndTime - loaf.renderStart : 0,
        debug_loaf_entry_total_forced_style_and_layout_duration: loaf.scripts.reduce((sum, script) => sum + script.forcedStyleAndLayoutDuration, 0),
        debug_loaf_entry_pre_layout_duration: loaf.styleAndLayoutStart ? loaf.styleAndLayoutStart - loaf.renderStart : 0,
        debug_loaf_entry_style_and_layout_duration: loaf.styleAndLayoutStart ? loafEndTime - loaf.styleAndLayoutStart : 0,

        // Stats for the longest script in the LoAF entry.
        debug_loaf_script_total_duration: script.duration,
        debug_loaf_script_compile_duration: script.executionStart - script.startTime,
        debug_loaf_script_exec_duration: script.startTime + script.duration - script.executionStart,
        debug_loaf_script_forced_style_and_layout_duration: script.forcedStyleAndLayoutDuration,
        debug_loaf_script_type: script.invokerType,
        debug_loaf_script_invoker: script.invoker,
        debug_loaf_script_source_url: script.sourceURL,
        debug_loaf_script_source_function_name: script.sourceFunctionName,
        debug_loaf_script_source_char_position: script.sourceCharPosition,

        // LoAF metadata.
        debug_loaf_meta_length: loafEntriesLength,
      }
    });

    if (!loafAttribution.debug_loaf_script_total_duration) {
      return {};
    }

    // The LoAF script with the single longest total duration.
    return Object.fromEntries(Object.entries(loafAttribution).map(([k, v]) => {
      // Convert all floats to ints.
      return [k, typeof v == 'number' ? Math.floor(v) : v];
    }));
  }

  function sendWebVitalsGAEvents({name, delta, value, id, attribution, navigationType}) {

    let overrides = {};

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
      case 'FID':
      case 'INP': {
        const loafAttribution = getLoafAttribution(attribution);
        overrides = {
          debug_event: attribution.interactionType,
          debug_time: Math.round(attribution.interactionTime),
          debug_load_state: attribution.loadState,
          debug_target: attribution.interactionTarget || '(not set)',
          debug_interaction_delay: Math.round(attribution.inputDelay),
          debug_processing_duration: Math.round(attribution.processingDuration),
          debug_presentation_delay:  Math.round(attribution.presentationDelay),
          ...loafAttribution
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
          debug_target: attribution.element || '(not set)',
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
    webVitals.onFID(sendWebVitalsGAEvents);
    webVitals.onINP(sendWebVitalsGAEvents);
  } else {
    console.error('Web Vitals is not loaded!!');
  }

}

sendWebVitals();
