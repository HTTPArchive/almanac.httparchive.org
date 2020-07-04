(function(){function r(e,n,t){function o(i,f){if(!n[i]){if(!e[i]){var c="function"==typeof require&&require;if(!f&&c)return c(i,!0);if(u)return u(i,!0);var a=new Error("Cannot find module '"+i+"'");throw a.code="MODULE_NOT_FOUND",a}var p=n[i]={exports:{}};e[i][0].call(p.exports,function(r){var n=e[i][1][r];return o(n||r)},p,p.exports,r,e,n,t)}return n[i].exports}for(var u="function"==typeof require&&require,i=0;i<t.length;i++)o(t[i]);return o}return r})()({1:[function(require,module,exports){
!function(t,e){"object"==typeof exports&&"undefined"!=typeof module?e(exports):"function"==typeof define&&define.amd?define(["exports"],e):e((t=t||self).webVitals={})}(this,(function(t){"use strict";var e,n,i=function(){return"".concat(Date.now(),"-").concat(Math.floor(8999999999999*Math.random())+1e12)},a=function(t){var e=arguments.length>1&&void 0!==arguments[1]?arguments[1]:-1;return{name:t,value:e,delta:0,entries:[],id:i(),isFinal:!1}},r=function(t,e){try{if(PerformanceObserver.supportedEntryTypes.includes(t)){var n=new PerformanceObserver((function(t){return t.getEntries().map(e)}));return n.observe({type:t,buffered:!0}),n}}catch(t){}},o=!1,s=!1,u=function(t){o=!t.persisted},c=function(){addEventListener("pagehide",u),addEventListener("unload",(function(){}))},f=function(t){var e=arguments.length>1&&void 0!==arguments[1]&&arguments[1];s||(c(),s=!0),addEventListener("visibilitychange",(function(e){var n=e.timeStamp;"hidden"===document.visibilityState&&t({timeStamp:n,isUnloading:o})}),{capture:!0,once:e})},d=function(t,e,n,i){var a;return function(){n&&e.isFinal&&n.disconnect(),e.value>=0&&(i||e.isFinal||"hidden"===document.visibilityState)&&(e.delta=e.value-(a||0),(e.delta||e.isFinal||void 0===a)&&(t(e),a=e.value))}},p=function(){return void 0===e&&(e="hidden"===document.visibilityState?0:1/0,f((function(t){var n=t.timeStamp;return e=n}),!0)),{get timeStamp(){return e}}},l=function(){return n||(n=new Promise((function(t){return["scroll","keydown","pointerdown"].map((function(e){addEventListener(e,t,{once:!0,passive:!0,capture:!0})}))}))),n};t.getCLS=function(t){var e,n=arguments.length>1&&void 0!==arguments[1]&&arguments[1],i=a("CLS",0),o=function(t){t.hadRecentInput||(i.value+=t.value,i.entries.push(t),e())},s=r("layout-shift",o);s&&(e=d(t,i,s,n),f((function(t){var n=t.isUnloading;s.takeRecords().map(o),n&&(i.isFinal=!0),e()})))},t.getFCP=function(t){var e,n=a("FCP"),i=p(),o=r("paint",(function(t){"first-contentful-paint"===t.name&&t.startTime<i.timeStamp&&(n.value=t.startTime,n.isFinal=!0,n.entries.push(t),e())}));o&&(e=d(t,n,o))},t.getFID=function(t){var e=a("FID"),n=p(),i=function(t){t.startTime<n.timeStamp&&(e.value=t.processingStart-t.startTime,e.entries.push(t),e.isFinal=!0,s())},o=r("first-input",i),s=d(t,e,o);o?f((function(){o.takeRecords().map(i),o.disconnect()}),!0):window.perfMetrics&&window.perfMetrics.onFirstInputDelay&&window.perfMetrics.onFirstInputDelay((function(t,i){i.timeStamp<n.timeStamp&&(e.value=t,e.isFinal=!0,e.entries=[{entryType:"first-input",name:i.type,target:i.target,cancelable:i.cancelable,startTime:i.timeStamp,processingStart:i.timeStamp+t}],s())}))},t.getLCP=function(t){var e,n=arguments.length>1&&void 0!==arguments[1]&&arguments[1],i=a("LCP"),o=p(),s=function(t){var n=t.startTime;n<o.timeStamp?(i.value=n,i.entries.push(t)):i.isFinal=!0,e()},u=r("largest-contentful-paint",s);if(u){e=d(t,i,u,n);var c=function(){i.isFinal||(u.takeRecords().map(s),i.isFinal=!0,e())};l().then(c),f(c,!0)}},t.getTTFB=function(t){var e,n=a("TTFB");e=function(){try{var e=performance.getEntriesByType("navigation")[0]||function(){var t=performance.timing,e={entryType:"navigation",startTime:0};for(var n in t)"navigationStart"!==n&&"toJSON"!==n&&(e[n]=Math.max(t[n]-t.navigationStart,0));return e}();n.value=n.delta=e.responseStart,n.entries=[e],n.isFinal=!0,t(n)}catch(t){}},"complete"===document.readyState?setTimeout(e,0):addEventListener("pageshow",e)},Object.defineProperty(t,"__esModule",{value:!0})}));

},{}],2:[function(require,module,exports){
"use strict";

var _webVitals = require("web-vitals");

function sendToGoogleAnalytics(_ref) {
  var name = _ref.name,
      delta = _ref.delta,
      id = _ref.id;
  gtag('event', name, {
    event_category: 'Web Vitals',
    value: Math.round(name === 'CLS' ? delta * 1000 : delta),
    event_label: id,
    non_interaction: true
  });
}

(0, _webVitals.getCLS)(sendToGoogleAnalytics, true);
(0, _webVitals.getFID)(sendToGoogleAnalytics);
(0, _webVitals.getLCP)(sendToGoogleAnalytics);
(0, _webVitals.getFCP)(sendToGoogleAnalytics);

},{"web-vitals":1}]},{},[2]);
