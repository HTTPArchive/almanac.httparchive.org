CREATE TEMPORARY FUNCTION getSummary(payload STRING) -- noqa: PRS
-- SQL Linter expects STRUCT field names to beging with a-z or A-Z so needs noqa ignore command on previous line
RETURNS STRUCT<requestId STRING, startedDateTime INT64, time INT64, method STRING, urlShort STRING, redirectUrl STRING, firstReq BOOLEAN, firstHtml BOOLEAN, reqHttpVersion STRING, reqHeadersSize INT64,
reqBodySize INT64, reqCookieLen INT64, reqOtherHeaders STRING, status INT64, respHttpVersion STRING, respHeadersSize INT64, respBodySize INT64, respSize INT64, respCookieLen INT64, expAge NUMERIC, mimeType STRING, respOtherHeaders STRING,
req_accept STRING, req_accept_charset STRING, req_accept_encoding STRING, req_accept_language STRING, req_connection STRING, req_host STRING, req_if_modified_since STRING, req_if_none_match STRING, req_referer STRING, req_user_agent STRING,
resp_accept_ranges STRING, resp_age STRING, resp_cache_control STRING, resp_connection STRING, resp_content_encoding STRING, resp_content_language STRING, resp_content_length STRING, resp_content_location STRING, resp_content_type STRING, resp_date STRING, resp_etag STRING, resp_expires STRING, resp_keep_alive STRING, resp_last_modified STRING, resp_location STRING, resp_pragma STRING, resp_server STRING, resp_transfer_encoding STRING, resp_vary STRING, resp_via STRING, resp_x_powered_by STRING,
_cdn_provider STRING, _gzip_save INT64, type STRING, ext STRING, format STRING>
LANGUAGE js AS """
  function getHeader(headers, name) {
    try {
      return headers.find(h => h.name.toLowerCase() === name.toLowerCase()).value;
    } catch (e) {
      return '';
    }
  }
  function getOtherHeaders(headers, excludes) {
    return headers.filter(h => !excludes.includes(h.name.toLowerCase())).map(h => `${h.name} = ${h.value}`).join(', ');
  }
  function getExt(ext) {
    var iQ = ext.indexOf('?');
    if (iQ !== -1) {
      ext = ext.substr(0, iQ);
    }

    ext = ext.substr(ext.lastIndexOf('/') + 1);

    var iDot = ext.lastIndexOf('.');
    if (iDot === -1) {
      return '';
    }

    ext = ext.substr(iDot + 1);
    if (ext.length > 5) {
      return '';
    }

    return ext;
  }
  function prettyType(mimeType, ext) {
    mimeType = mimeType.toLowerCase();

    var types = ['font', 'css', 'image', 'script', 'video', 'audio', 'xml'];
    for (type of types) {
      if (mimeType.includes(type)) {
        return type;
      }
    }

    if (mimeType.includes('json') || ['js', 'json'].includes(ext)) {
      return 'script';
    } else if (['eot', 'ttf', 'woff', 'woff2', 'otf'].includes(ext)) {
      return 'font';
    } else if (['png', 'gif', 'jpg', 'jpeg', 'webp', 'ico', 'svg'].includes(ext)) {
      return 'image';
    } else if (['css', 'xml'].includes(ext)) {
      return ext;
    } else if (mimeType.includes('flash') || mimeType.includes('webm') || mimeType.includes('mp4') || mimeType.includes('flv') || ['mp4', 'webm', 'ts', 'm4v', 'm4s', 'mov', 'ogv', 'swf', 'f4v', 'flv'].includes(ext)) {
      return 'video';
    } else if (mimeType.includes('html') || ['html', 'htm'].includes(ext)) {
      return 'html';
    } else if (mimeType.includes('text')) {
      return 'text';
    }

    return 'other';
  }
  function getFormat(prettyType, mimeType, ext) {
    ext = ext.toLowerCase();
    if (prettyType == 'image') {
      for (type of ['jpg', 'png', 'gif', 'webp', 'svg', 'ico']) {
        if (mimeType.includes(type) || ext == type) {
          return type;
        }
      }

      if (mimeType.includes('jpeg') || ext == 'jpeg') {
        return 'jpg'
      }
    } else if (prettyType == 'video') {
      for (type of ['flash', 'swf', 'mp4', 'flv', 'f4v', 'webm', 'ts', 'm4v', 'm4s', 'mov', 'ogv']) {
        if (mimeType.includes(type) || ext == type) {
          return type;
        }
      }
    }

    return '';
  }
  function getExpAge(headers, startedDateTime) {
    try {
      var cc = getHeader(headers, 'cache-control').toLowerCase();
      if (cc && (cc.includes('must-revalidate') || cc.includes('no-cache') || cc.includes('no-store'))) {
        return 0;
      }

      var maxAge = cc.match(/max-age=(\\d+)/);
      if (maxAge) {
        return Math.min(Number.MAX_SAFE_INTEGER, +maxAge[1]);
      }

      var expires = getHeader(headers, 'expires');
      var date = getHeader(headers, 'date');
      if (expires && (date || startedDateTime)) {
        var startEpoch = date ? new Date(date).getTime() : startedDateTime;
        var expAge = new Date(expires).getTime() - startEpoch;
        return isNaN(expAge) ? 0 : expAge;
      }

      return 0;
    } catch (e) {
      return 0;
    }
  }

  try {
    var $ = JSON.parse(payload);
    var mimeType = $.response.content.mimeType;
    var ext = getExt($.request.url);
    var prettyType = prettyType(mimeType, ext);
    var reqHeaders = ["accept", "accept-charset", "accept-encoding", "accept-language", "connection", "host", "if-modified-since", "if-none-match", "referer", "user-agent", "cookie"];
    var respHeaders = ["accept-ranges", "age", "cache-control", "connection", "content-encoding", "content-language", "content-length", "content-location", "content-type", "date", "etag", "expires", "keep-alive", "last-modified", "location", "pragma", "server", "transfer-encoding", "vary", "via", "x-powered-by", "set-cookie"];
    var startedDateTime = new Date($.startedDateTime).getTime();
    return {
requestId: $._request_id,
startedDateTime: +startedDateTime,
time: +$.time,
method: $.request.method,
urlShort: $.request.url.substr(0, 255),
redirectUrl: $.response.redirectUrl,
firstReq: $._index === 0,
firstHtml: !!$._final_base_page,
reqHttpVersion: $.request.httpVersion,
reqHeadersSize: +$.request.headersSize,
reqBodySize: +$.request.bodySize,
reqCookieLen: +getHeader($.request.headers, 'cookie').length,
reqOtherHeaders: getOtherHeaders($.request.headers, reqHeaders),
status: +$.response.status,
respHttpVersion: $.response.httpVersion,
respHeadersSize: +$.response.headersSize,
respBodySize: +$.response.bodySize,
respSize: +$.response.content.size,
respCookieLen: +getHeader($.response.headers, 'set-cookie').length,
expAge: getExpAge($.response.headers, startedDateTime),
mimeType: mimeType,
respOtherHeaders: getOtherHeaders($.response.headers, respHeaders),
req_accept: getHeader($.request.headers, 'accept'),
req_accept_charset: getHeader($.request.headers, 'accept-charset'),
req_accept_encoding: getHeader($.request.headers, 'accept-encoding'),
req_accept_language: getHeader($.request.headers, 'accept-language'),
req_connection: getHeader($.request.headers, 'connection'),
req_host: getHeader($.request.headers, 'host'),
req_if_modified_since: getHeader($.request.headers, 'if-modified-since'),
req_if_none_match: getHeader($.request.headers, 'if-none-match'),
req_referer: getHeader($.request.headers, 'referer'),
req_user_agent: getHeader($.request.headers, 'user-agent'),
resp_accept_ranges: getHeader($.response.headers, 'accept-ranges'),
resp_age: getHeader($.response.headers, 'age'),
resp_cache_control: getHeader($.response.headers, 'cache-control'),
resp_connection: getHeader($.response.headers, 'connection'),
resp_content_encoding: getHeader($.response.headers, 'content-encoding'),
resp_content_language: getHeader($.response.headers, 'content-language'),
resp_content_length: getHeader($.response.headers, 'content-length'),
resp_content_location: getHeader($.response.headers, 'content-location'),
resp_content_type: getHeader($.response.headers, 'content-type'),
resp_date: getHeader($.response.headers, 'date'),
resp_etag: getHeader($.response.headers, 'etag'),
resp_expires: getHeader($.response.headers, 'expires'),
resp_keep_alive: getHeader($.response.headers, 'keep-alive'),
resp_last_modified: getHeader($.response.headers, 'last-modified'),
resp_location: getHeader($.response.headers, 'location'),
resp_pragma: getHeader($.response.headers, 'pragma'),
resp_server: getHeader($.response.headers, 'server'),
resp_transfer_encoding: getHeader($.response.headers, 'transfer-encoding'),
resp_vary: getHeader($.response.headers, 'vary'),
resp_via: getHeader($.response.headers, 'via'),
resp_x_powered_by: getHeader($.response.headers, 'x-powered-by'),
_cdn_provider: $._cdn_provider,
_gzip_save: $._gzip_save,
type: prettyType,
ext: ext,
format: getFormat(prettyType, mimeType, ext)
    };

    return summary;
  } catch (e) {
    return e
  }
""";

SELECT
  CAST('2020-08-01' AS DATE) AS date,
  _TABLE_SUFFIX AS client,
  page,
  url,
  getSummary(payload).*, --  noqa: PRS, L013
  payload
FROM
  `httparchive.requests.2020_08_01_*`
