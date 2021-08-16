CREATE TEMP FUNCTION retrieveOriginTrials(tokenElem STRING)
  RETURNS STRUCT<
    validityElem STRING,
    versionElem INTEGER,
    originElem STRING,
    subdomainElem BOOLEAN,
    thirdpartyElem BOOLEAN,
    usageElem STRING,
    featureElem STRING,
    expiryElem TIMESTAMP
  >

  LANGUAGE js
  -- https://stackoverflow.com/questions/60094731/can-i-use-textencoder-in-bigquery-js-udf
  OPTIONS (library="gs://fh-bigquery/js/inexorabletash.encoding.js");
  -- https://github.com/GoogleChrome/OriginTrials/blob/gh-pages/check-token.html
  AS """
  let validityElem,
    versionElem,
    originElem,
    subdomainElem,
    thirdpartyElem,
    usageElem,
    featureElem,
    expiryElem,
    origin_trial_metadata = {};

  const utf8Decoder = new TextDecoder('utf-8', {fatal: true});

  // atob: https://stackoverflow.com/a/44836424/7391782

  var chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=';

  function InvalidCharacterError(message) {
    this.message = message;
  }
  InvalidCharacterError.prototype = new Error;
  InvalidCharacterError.prototype.name = 'InvalidCharacterError';

  // encoder
  // [https://gist.github.com/1020396] by [https://github.com/atk]
  const atob = function (input) {
    var str = String(input).replace(/[=]+$/, ''); // #31: ExtendScript bad parse of /=
    if (str.length % 4 == 1) {
      throw new InvalidCharacterError("'atob' failed: The string to be decoded is not correctly encoded.");
    }
    for (
      // initialize result and counters
      var bc = 0, bs, buffer, idx = 0, output = '';
      // get next character
      buffer = str.charAt(idx++);
      // character found in table? initialize bit storage and add its ascii value;
      ~buffer && (bs = bc % 4 ? bs * 64 + buffer : buffer,
        // and if not first of each 4 characters,
        // convert the first 8 bits to one ascii character
        bc++ % 4) ? output += String.fromCharCode(255 & bs >> (-2 * bc & 6)) : 0
    ) {
      // try to find character in table (0-63, not found => -1)
      buffer = chars.indexOf(buffer);
    }
    return output;
  };

  // Base64-decode the token into a Uint8Array.
  let tokenStr;
  try {
    tokenStr = atob(tokenElem);
  } catch (e) {
    console.error(e);
    origin_trial_metadata.validityElem = 'Invalid Base64';
  return origin_trial_metadata;
  }
  const token = new Uint8Array(tokenStr.length);
  for (let i = 0; i < token.length; i++) {
    token[i] = tokenStr.charCodeAt(i);
  }

  // Check that the version number is 2 or 3.
  const version = token[0];
  versionElem = '' + version;
  if (version !== 2 && version !== 3) {
    origin_trial_metadata.validityElem = 'Unknown version';
  return origin_trial_metadata;
  }

  // Pull the fields out of the token.
  if (token.length < 69) {
    origin_trial_metadata.validityElem = 'Token is too short';
  return origin_trial_metadata;
  }
  const payloadLength = new DataView(token.buffer, 65, 4).getInt32(0, /*littleEndian=*/ false);
  const payload = new Uint8Array(token.buffer, 69);
  if (payload.length !== payloadLength) {
    origin_trial_metadata.validityElem = 'Token is ' + payload.length + ' bytes; expected ' + payloadLength;
  return origin_trial_metadata;
  }

  // The version + length + payload is signed.
  const signedData = new Uint8Array(token.buffer.slice(64));
  signedData[0] = token[0];

  // Pull the fields out of the JSON payload.
  let json;
  try {
    json = utf8Decoder.decode(payload);
  } catch (e) {
    origin_trial_metadata.validityElem = 'Invalid UTF-8';
  return origin_trial_metadata;
  }

  let obj;
  try {
    obj = JSON.parse(json);
  } catch (e) {
    origin_trial_metadata.validityElem = 'Invalid JSON';
  return origin_trial_metadata;
  }

  originElem = obj.origin;
  subdomainElem = !!obj.isSubdomain;
  thirdpartyElem = !!obj.isThirdParty;
  usageElem = obj.usage;
  featureElem = obj.feature;
  let expiry;
  try {
    expiry = parseInt(obj.expiry);
  } catch (e) {
    origin_trial_metadata.validityElem = "Expiry value wasn't an integer";
    origin_trial_metadata.expiryElem = obj.expiry;
  return origin_trial_metadata;
  }

  let expiryDate = new Date(expiry * 1000);
  expiryElem = expiryDate;
  if (expiryDate < new Date()) {
    origin_trial_metadata.validityElem = 'Expired';
  return origin_trial_metadata;
  }

  origin_trial_metadata = {
    validityElem: 'Valid',
    versionElem: versionElem,
    originElem: originElem,
    subdomainElem: subdomainElem,
    thirdpartyElem: thirdpartyElem,
    usageElem: usageElem,
    featureElem: featureElem,
    expiryElem: expiryElem,
  };

  return origin_trial_metadata;
""";

WITH pages_origin_trials AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    JSON_VALUE(payload, "$._origin-trials") AS metrics
  FROM
    `httparchive.pages.2021_08_01_*`
)

, extracted_origin_trials AS (
SELECT
  client,
  url as site, -- the home page that was crawled
  retrieveOriginTrials(JSON_VALUE(metric, "$.token")) origin_trials
FROM
  pages_origin_trials, UNNEST(JSON_QUERY_ARRAY(metrics)) metric
)

-- TODO: combine with header data

SELECT
  client,
  COUNT(DISTINCT site) nb_websites, -- crawled sites containing at leat one origin trial
  COUNT(DISTINCT origin_trials.originElem) nb_origins, -- origins with an origin trial
FROM
  extracted_origin_trials
WHERE
  origin_trials.featureElem = 'InterestCohortAPI'
GROUP BY
  1
