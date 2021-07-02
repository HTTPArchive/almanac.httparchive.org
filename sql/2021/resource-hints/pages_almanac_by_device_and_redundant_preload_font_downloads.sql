#standardSQL

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
    ROUND(SAFE_DIVIDE(freq, total), 4)
);

# retruns the number of redundant font downloads
# use https://replit.com/@NitinPasumarthy/almanac-2021-redundant-font-preloads#index.js to run the JS on several test payloads
CREATE TEMPORARY FUNCTION getUnnecessaryFontDownloadsCount(almanac_string STRING)
RETURNS INT64 LANGUAGE js AS '''
try {
    var almanac = JSON.parse(almanac_string)
    if (Array.isArray(almanac) || typeof almanac != 'object') return -1;
    
    var nodes = almanac["link-nodes"]["nodes"]
    nodes = typeof nodes == 'string' ? JSON.parse(nodes) : nodes

    var preloadFontRes = nodes.filter(n => n['as'] === "font" && n['rel'] === 'preload')
    var fontFiles = preloadFontRes.map(r => {
        // r is of the form, ./fonts/roboto-regular.woff2
        var filePathParts = r.href.split("/");
        // return would be of the form, roboto-regular.woff2
        return filePathParts[filePathParts.length - 1]
    });
    
    // only include sites which preload at least one font file
    if (fontFiles.length === 0) {
        return -1;
    }
    
    var fontsWithExt = {} // {"woff2": Set( 'font1', 'font2' ), "ttf": Set( 'font2' )}
    for(var i = 0; i < fontFiles.length; i++) {
        var [fontName, ext] = fontFiles[i].split(".")
        if(ext in fontsWithExt) {
            fontsWithExt[ext].add(fontName)
        } else {
            fontsWithExt[ext] = new Set([fontName])
        }
    }

    var redundantDownloads = 0
    if("woff2" in fontsWithExt) {
        for(var ext of Object.keys(fontsWithExt) ) {
            if(ext !== "woff2") {
                redundantDownloads += [...fontsWithExt["woff2"]].filter(f => fontsWithExt[ext].has(f)).length
            }
        }
    }

    return redundantDownloads;
}
catch {
    return -1
}
''';

SELECT
    client,
    rd as redundantDownloads,
    count(0) as freq,
    AS_PERCENT(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS pct
FROM (
    SELECT 
        _TABLE_SUFFIX AS client,
        JSON_QUERY(payload, '$._almanac') AS almanac, 
        getUnnecessaryFontDownloadsCount(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS rd 
    FROM
        `httparchive.sample_data.pages*`
)
WHERE 
    rd > -1
GROUP BY
    client,
    rd
ORDER BY
    rd DESC