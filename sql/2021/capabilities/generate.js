const fs = require('fs');

const getQuery = (api, platform) => {
  return `CREATE TEMP FUNCTION
getFuguAPIs(DATA STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
const $ = JSON.parse(data);
return Object.keys($);
''';
SELECT
  fuguAPI,
  url,
  payload
FROM
  \`httparchive.pages.2021_07_01_${platform}\`,
  UNNEST(getFuguAPIs(JSON_QUERY(payload,
        '$."_fugu-apis"'))) AS fuguAPI
WHERE
  JSON_QUERY(payload,
    '$."_fugu-apis"') != "[]"
AND
  fuguAPI = "${api}"
GROUP BY
  fuguAPI,
  url,
  payload;
`;
};

const apis = [
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
  'Protocol Handlers',
];

const platforms = ['desktop', 'mobile'];

platforms.forEach((platform) => {
  fs.mkdirSync(`./${platform}`);
  apis.forEach((api) => {
    const query = getQuery(api, platform);
    console.log(query);
    fs.writeFileSync(
      `./${platform}/${api
        .toLowerCase()
        .replace(/\s+/g, '_')
        .replace(/[\(\)]/g, '')}.sql`,
      query,
      { encoding: 'utf8' },
    );
  });
});
