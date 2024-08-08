-- Normalize a name. Used in FAMILY.
CREATE TEMPORARY FUNCTION FAMILY_INNER(name STRING) AS (
  IF(LENGTH(TRIM(name)) < 3, NULL, NULLIF(TRIM(name), ''))
);

-- Extract the family name from a payload.
CREATE TEMPORARY FUNCTION FAMILY(payload STRING) AS (
  FAMILY_INNER(JSON_EXTRACT_SCALAR(payload, '$._font_details.names[1]'))
);

-- Extract the file format from a URL and a Content-Type header.
CREATE TEMPORARY FUNCTION FILE_FORMAT(url STRING, header STRING) AS (
  LOWER(COALESCE(
    REGEXP_EXTRACT(LOWER(header), r'(otf|sfnt|svg|ttf|woff2?|fontobject|opentype|truetype)'),
    REGEXP_EXTRACT(url, r'\.(\w+)(?:$|\?|#)'),
    header
  ))
);

-- Extract the foundry name from a payload.
CREATE TEMPORARY FUNCTION FOUNDRY(payload STRING) AS (
  JSON_EXTRACT_SCALAR(payload, '$._font_details.OS2.achVendID')
);

-- Infer scripts from codepoints. Used in SCRIPTS.
CREATE TEMPORARY FUNCTION SCRIPTS_INNER(codepoints ARRAY<STRING>)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = ["gs://httparchive/lib/text-utils.js"])
AS r"""
if (codepoints && codepoints.length) {
  return detectWritingScript(codepoints.map(c => parseInt(c, 10)), 0.05);
} else {
  return [];
}
""";

-- Infer scripts from a payload.
CREATE TEMPORARY FUNCTION SCRIPTS(payload STRING) AS (
  SCRIPTS_INNER(JSON_EXTRACT_STRING_ARRAY(payload, '$._font_details.cmap.codepoints'))
);

-- Infer the service from a URL.
CREATE TEMPORARY FUNCTION SERVICE(url STRING) AS (
  CASE
    WHEN REGEXP_CONTAINS(url, r'(use|fonts)\.typekit\.(net|com)') THEN 'Adobe'
    WHEN REGEXP_CONTAINS(url, r'(fonts\.(gstatic|googleapis)\.com)|themes.googleusercontent.com/static/fonts|ssl.gstatic.com/fonts') THEN 'Google'
    WHEN REGEXP_CONTAINS(url, r'cloud\.typenetwork\.com') THEN 'typenetwork.com'
    WHEN REGEXP_CONTAINS(url, r'cloud\.typography\.com') THEN 'typography.com'
    WHEN REGEXP_CONTAINS(url, r'cloud\.webtype\.com') THEN 'webtype.com'
    WHEN REGEXP_CONTAINS(url, r'f\.fontdeck\.com') THEN 'fontdeck.com'
    WHEN REGEXP_CONTAINS(url, r'fast\.fonts\.(com|net)\/(jsapi|cssapi)') THEN 'fonts.com'
    WHEN REGEXP_CONTAINS(url, r'fnt\.webink\.com') THEN 'webink.com'
    WHEN REGEXP_CONTAINS(url, r'fontawesome\.com') THEN 'fontawesome.com'
    WHEN REGEXP_CONTAINS(url, r'fonts\.typonine\.com') THEN 'typonine.com'
    WHEN REGEXP_CONTAINS(url, r'fonts\.typotheque\.com') THEN 'typotheque.com'
    WHEN REGEXP_CONTAINS(url, r'typesquare\.com') THEN 'typesquare.com'
    WHEN REGEXP_CONTAINS(url, r'use\.edgefonts\.net|webfonts\.creativecloud\.com') THEN 'edgefonts.net'
    WHEN REGEXP_CONTAINS(url, r'webfont\.fontplus\.jp') THEN 'fontplus.jp'
    WHEN REGEXP_CONTAINS(url, r'webfonts\.fontslive\.com') THEN 'fontslive.com'
    WHEN REGEXP_CONTAINS(url, r'webfonts\.fontstand\.com') THEN 'fontstand.com'
    WHEN REGEXP_CONTAINS(url, r'webfonts\.justanotherfoundry\.com') THEN 'justanotherfoundry.com'
    ELSE 'self-hosted'
  END
);

-- Extract the color formats from a payload.
CREATE TEMPORARY FUNCTION COLOR_FORMATS(payload STRING) AS (
  REGEXP_EXTRACT_ALL(
    JSON_EXTRACT(payload, '$._font_details.color.formats'),
    '(?i)(sbix|CBDT|COLRv0|COLRv1|SVG)'
  )
);

-- Check if it is a color font given its payload.
CREATE TEMPORARY FUNCTION IS_COLOR(payload STRING) AS (
  ARRAY_LENGTH(COLOR_FORMATS(payload)) > 0
);

-- Check if it is a variable font given its payload.
CREATE TEMPORARY FUNCTION IS_VARIABLE(payload STRING) AS (
  REGEXP_CONTAINS(
    JSON_EXTRACT(payload, '$._font_details.table_sizes'),
    '(?i)gvar|CFF2'
  )
);

-- Extract the variable formats from a payload.
CREATE TEMPORARY FUNCTION VARIABLE_FORMATS(payload STRING) AS (
  REGEXP_EXTRACT_ALL(
    JSON_EXTRACT(payload, '$._font_details.table_sizes'),
    '(?i)glyf|CFF2'
  )
);
