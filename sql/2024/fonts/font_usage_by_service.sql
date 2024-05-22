WITH totals AS (
  SELECT
    IF(ENDS_WITH(_TABLE_SUFFIX, 'desktop'), 'desktop', 'mobile') AS client,
    REGEXP_REPLACE(_TABLE_SUFFIX, r'(\d+)_(\d+)_(\d+).*', r'\1-\2-\3') AS date,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.*`
  WHERE
    (
      _TABLE_SUFFIX LIKE '2019_07_01%' OR
      _TABLE_SUFFIX LIKE '2020_08_01%' OR
      _TABLE_SUFFIX LIKE '2021_07_01%' OR
      _TABLE_SUFFIX LIKE '2022_06_01%'
    )
  GROUP BY
    client,
    date
),

counts AS (
  SELECT
    IF(ENDS_WITH(_TABLE_SUFFIX, 'desktop'), 'desktop', 'mobile') AS client,
    REGEXP_REPLACE(_TABLE_SUFFIX, r'(\d+)_(\d+)_(\d+).*', r'\1-\2-\3') AS date,
    pageid,
    LOGICAL_OR(REGEXP_CONTAINS(url, r'(fonts\.(gstatic|googleapis)\.com)|(themes.googleusercontent.com/static/fonts)|(ssl.gstatic.com/fonts/)')) AS google_fonts,
    LOGICAL_OR(REGEXP_CONTAINS(url, r'(use|fonts)\.typekit\.(net|com)')) AS adobe_fonts,
    LOGICAL_OR(REGEXP_CONTAINS(url, r'(use\.edgefonts\.net|webfonts\.creativecloud\.com)')) AS edge_web_fonts,
    LOGICAL_OR(REGEXP_CONTAINS(url, r'fast\.fonts\.(com|net)\/(jsapi|cssapi)')) AS fonts_com,
    LOGICAL_OR(REGEXP_CONTAINS(url, r'f\.fontdeck\.com')) AS fontdeck,
    LOGICAL_OR(REGEXP_CONTAINS(url, r'cloud\.webtype\.com')) AS webtype,
    LOGICAL_OR(REGEXP_CONTAINS(url, r'cloud\.typenetwork\.com')) AS type_network,
    LOGICAL_OR(REGEXP_CONTAINS(url, r'cloud\.typography\.com')) AS cloud_typography,
    LOGICAL_OR(REGEXP_CONTAINS(url, r'fnt\.webink\.com')) AS webink,
    LOGICAL_OR(REGEXP_CONTAINS(url, r'fonts\.typotheque\.com')) AS typotheque,
    LOGICAL_OR(REGEXP_CONTAINS(url, r'webfonts\.fontstand\.com')) AS fontstand,
    LOGICAL_OR(REGEXP_CONTAINS(url, r'typesquare\.com')) AS type_square,
    LOGICAL_OR(REGEXP_CONTAINS(url, r'webfont\.fontplus\.jp')) AS font_plus,
    LOGICAL_OR(REGEXP_CONTAINS(url, r'fontawesome\.com')) AS fontawesome,
    LOGICAL_OR(REGEXP_CONTAINS(url, r'webfonts\.fontslive\.com')) AS fontslive,
    LOGICAL_OR(REGEXP_CONTAINS(url, r'webfonts\.justanotherfoundry\.com')) AS just_another_foundry,
    LOGICAL_OR(REGEXP_CONTAINS(url, r'fonts\.typonine\.com')) AS typonine,
    LOGICAL_OR(REGEXP_CONTAINS(url, r'kernest\.com')) AS kernest,
    LOGICAL_OR(REGEXP_CONTAINS(url, r'typefront\.com')) AS typefront,
    LOGICAL_OR((REGEXP_CONTAINS(mimeType, r'font|woff|eot') OR
        (ext = 'woff' OR
          ext = 'woff2' OR
          ext = 'eot' OR
          ext = 'ttf' OR
          ext = 'otf')) AND
      (REGEXP_CONTAINS(url, r'(fonts\.(gstatic|googleapis)\.com)|(themes.googleusercontent.com/static/fonts)|(ssl.gstatic.com/fonts/)') IS FALSE AND
        REGEXP_CONTAINS(url, r'(use|fonts)\.typekit\.(net|com)') IS FALSE AND
        REGEXP_CONTAINS(url, r'(use\.edgefonts\.net|webfonts\.creativecloud\.com)') IS FALSE AND
        REGEXP_CONTAINS(url, r'fast\.fonts\.(com|net)\/(jsapi|cssapi)') IS FALSE AND
        REGEXP_CONTAINS(url, r'f\.fontdeck\.com') IS FALSE AND
        REGEXP_CONTAINS(url, r'cloud\.webtype\.com') IS FALSE AND
        REGEXP_CONTAINS(url, r'cloud\.typenetwork\.com') IS FALSE AND
        REGEXP_CONTAINS(url, r'cloud\.typography\.com') IS FALSE AND
        REGEXP_CONTAINS(url, r'fnt\.webink\.com') IS FALSE AND
        REGEXP_CONTAINS(url, r'fonts\.typotheque\.com') IS FALSE AND
        REGEXP_CONTAINS(url, r'webfonts\.fontstand\.com') IS FALSE AND
        REGEXP_CONTAINS(url, r'typesquare\.com') IS FALSE AND
        REGEXP_CONTAINS(url, r'webfont\.fontplus\.jp') IS FALSE AND
        REGEXP_CONTAINS(url, r'fontawesome\.com') IS FALSE AND
        REGEXP_CONTAINS(url, r'webfonts\.fontslive\.com') IS FALSE AND
        REGEXP_CONTAINS(url, r'webfonts\.justanotherfoundry\.com') IS FALSE AND
        REGEXP_CONTAINS(url, r'fonts\.typonine\.com') IS FALSE AND
        REGEXP_CONTAINS(url, r'kernest\.com') IS FALSE AND
        REGEXP_CONTAINS(url, r'typefront\.com') IS FALSE)) AS self_hosted
  FROM
    `httparchive.summary_requests.*`
  WHERE
    (
      _TABLE_SUFFIX LIKE '2019_07_01%' OR
      _TABLE_SUFFIX LIKE '2020_08_01%' OR
      _TABLE_SUFFIX LIKE '2021_07_01%' OR
      _TABLE_SUFFIX LIKE '2022_06_01%'
    )
  GROUP BY
    date,
    client,
    pageid
)

SELECT
  date,
  client,
  total,
  COUNTIF(google_fonts OR
    adobe_fonts OR
    edge_web_fonts OR
    fonts_com OR
    fontdeck OR
    webtype OR
    type_network OR
    cloud_typography OR
    webink OR
    typotheque OR
    fontstand OR
    type_square OR
    font_plus OR
    fontawesome OR
    fontslive OR
    just_another_foundry OR
    typonine OR
    kernest OR
    typefront OR
    self_hosted) / total AS pages_using_webfonts,
  COUNTIF(google_fonts OR
    adobe_fonts OR
    edge_web_fonts OR
    fonts_com OR
    fontdeck OR
    webtype OR
    type_network OR
    cloud_typography OR
    webink OR
    typotheque OR
    fontstand OR
    type_square OR
    font_plus OR
    fontawesome OR
    fontslive OR
    just_another_foundry OR
    typonine OR
    kernest OR
    typefront) / total AS pages_using_webfont_services,
  COUNTIF((google_fonts OR
      adobe_fonts OR
      edge_web_fonts OR
      fonts_com OR
      fontdeck OR
      webtype OR
      type_network OR
      cloud_typography OR
      webink OR
      typotheque OR
      fontstand OR
      type_square OR
      font_plus OR
      fontawesome OR
      fontslive OR
      just_another_foundry OR
      typonine OR
      kernest OR
      typefront) AND
    NOT self_hosted) / total AS pages_using_webfont_services_exclusive,
  COUNTIF(self_hosted) / total AS self_hosted,
  COUNTIF(NOT(google_fonts OR
      adobe_fonts OR
      edge_web_fonts OR
      fonts_com OR
      fontdeck OR
      webtype OR
      type_network OR
      cloud_typography OR
      webink OR
      typotheque OR
      fontstand OR
      type_square OR
      font_plus OR
      fontawesome OR
      fontslive OR
      just_another_foundry OR
      typonine OR
      kernest OR
      typefront) AND
    self_hosted) / total AS self_hosted_exclusive,
  COUNTIF(google_fonts) / total AS google_fonts,
  COUNTIF(adobe_fonts) / total AS adobe_fonts,
  COUNTIF(edge_web_fonts) / total AS edge_web_fonts,
  COUNTIF(fonts_com) / total AS fonts_com,
  COUNTIF(fontdeck) / total AS fontdeck,
  COUNTIF(webtype) / total AS webtype,
  COUNTIF(type_network) / total AS type_network,
  COUNTIF(cloud_typography) / total AS cloud_typography,
  COUNTIF(webink) / total AS webink,
  COUNTIF(typotheque) / total AS typotheque,
  COUNTIF(fontstand) / total AS fontstand,
  COUNTIF(type_square) / total AS type_square,
  COUNTIF(font_plus) / total AS font_plus,
  COUNTIF(fontawesome) / total AS fontawesome,
  COUNTIF(fontslive) / total AS fontslive,
  COUNTIF(just_another_foundry) / total AS just_another_foundry,
  COUNTIF(typonine) / total AS typonine,
  COUNTIF(kernest) / total AS kernest,
  COUNTIF(typefront) / total AS typefront
FROM
  counts
JOIN
  totals
USING (date, client)
GROUP BY
  date,
  client,
  total
ORDER BY
  date DESC,
  client
