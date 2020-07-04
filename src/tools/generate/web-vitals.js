import { getCLS, getFID, getLCP, getFCP, getTTFB } from 'web-vitals';

function sendToGoogleAnalytics(metric) {
  let event_value = 0;
  switch (metric.name) {
    case 'CLS':
      // For CLS event value is first multiplied by 1000 for greater precision.
      event_value = metric.delta * 1000;
      break;
    case 'TTFB':
      // For TTFB event value excludes DNS lookup, connection negotiation, network latency, and unloading the previous document.
      event_value = metric.value - metric.entries[0].requestStart;
      break;
    default:
      event_value = metric.delta;
  }

  gtag('event', metric.name, {
    event_category: 'Web Vitals',
    value: event_value,
    event_label: metric.id,
    non_interaction: true,
  });
}

getFCP(sendToGoogleAnalytics);
getLCP(sendToGoogleAnalytics, true);
getCLS(sendToGoogleAnalytics, true);
getTTFB(sendToGoogleAnalytics);
getFID(sendToGoogleAnalytics);
