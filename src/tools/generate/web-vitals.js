import {getCLS, getFID, getLCP, getFCP, getTTFB} from 'web-vitals';

function sendToGoogleAnalytics({name, delta, id}) {
  gtag('event', name, {
    event_category: 'Web Vitals',
    value: Math.round(name === 'CLS' ? delta * 1000 : delta),
    event_label: id,
    non_interaction: true,
  });
}

getCLS(sendToGoogleAnalytics, true);
getFID(sendToGoogleAnalytics);
getLCP(sendToGoogleAnalytics);
getFCP(sendToGoogleAnalytics);
