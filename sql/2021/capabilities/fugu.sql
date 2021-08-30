CREATE TEMP FUNCTION getFuguAPIs(data STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
const $ = JSON.parse(data);
return Object.keys($);
''';
SELECT
  _TABLE_SUFFIX AS client,
  fuguAPI,
  COUNT(DISTINCT url) AS pages,
  total,
  COUNT(DISTINCT url) / total AS pct,
  ARRAY_TO_STRING(ARRAY_AGG(DISTINCT url LIMIT 50), ' ') AS sample_urls
FROM
  `httparchive.pages.2021_07_01_*`
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY
    _TABLE_SUFFIX)
USING
  (_TABLE_SUFFIX),
  UNNEST(getFuguAPIs(JSON_QUERY(payload, '$."_fugu-apis"'))) AS fuguAPI
WHERE
  JSON_QUERY(payload,
    '$."_fugu-apis"') != "[]" AND
  fuguAPI IN (
    'WebBluetooth',
    'WebUSB',
    'Web Share',
    'Web Share (Files)',
    'Async Clipboard',
    'Async Clipboard (Images)',
    'Contact Picker',
    'getInstalledRelatedApps',
    'Compression Streams',
    'Periodic Background Sync',
    'Badging',
    'Shape Detection (Barcodes)',
    'Shape Detection (Faces)',
    'Shape Detection (Texts)',
    'Screen Wake Lock',
    'Content Index',
    'Credential Management',
    'WebOTP',
    'File System Access',
    'Pointer Lock (unadjustedMovement)',
    'WebHID',
    'WebSerial',
    'WebNFC',
    'Run On Login',
    'WebCodecs',
    'Digital Goods',
    'Idle Detection',
    'Storage Foundation',
    'Handwriting Recognition',
    'Compute Pressure',
    'Accelerometer',
    'Gyroscope',
    'Absolute Orientation Sensor',
    'Relative Orientation Sensor',
    'Gravity Sensor',
    'Linear Acceleration Sensor',
    'Magnetometer',
    'Ambient Light Sensor',
    'File Handling',
    'Notification Triggers',
    'Local Font Access',
    'Multi-Screen Window Placement',
    'WebSocketStream',
    'WebTransport',
    'Gamepad',
    'WebGPU',
    'Window Controls Overlay',
    'Web Share Target',
    'Web Share Target (Files)',
    'Shortcuts',
    'Declarative Link Capturing',
    'Tabbed Application Mode',
    'URL Handlers',
    'Protocol Handlers')
GROUP BY
  fuguAPI,
  client,
  total
HAVING
  COUNT(DISTINCT url) >= 10
ORDER BY
  pages / total DESC,
  client;
