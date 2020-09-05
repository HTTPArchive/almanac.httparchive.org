#standardSQL
# page wpt_bodies metrics grouped by device

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _wpt_bodies
CREATE TEMPORARY FUNCTION get_wpt_bodies_info(wpt_bodies_string STRING)
RETURNS STRUCT<
  
  # tags
  n_titles INT64,
  title_words INT64, 
  n_meta_descriptions INT64,
  n_h1 INT64, 
  n_h2 INT64, 
  n_h3 INT64, 
  n_h4 INT64, 
  n_non_empty_h1 INT64, 
  n_non_empty_h2 INT64, 
  n_non_empty_h3 INT64, 
  n_non_empty_h4 INT64,
  has_same_h1_title BOOL,

  # robots
  robots_has_robots_meta_tag BOOL,
  robots_has_x_robots_tag BOOL,
  rendering_changed_robots_meta_tag BOOL,

  # canonical
  has_canonicals BOOL, 
  has_self_canonical BOOL, 
  is_canonicalized BOOL,
  has_http_canonical BOOL, 
  has_rendered_canonical BOOL, 
  has_raw_canonical BOOL, 
  has_canonical_mismatch BOOL, 
  rendering_changed_canonical BOOL, 
  http_header_changed_canonical BOOL,

  # hreflang
  rendering_changed_hreflang BOOL, 
  has_hreflang BOOL,
  has_http_hreflang BOOL,
  has_rendered_hreflang BOOL,
  has_raw_hreflang BOOL,

  # structured data
  has_raw_jsonld_or_microdata BOOL,
  has_rendered_jsonld_or_microdata BOOL,
  rendering_changes_structured_data BOOL

> LANGUAGE js AS '''
var result = {};
try {
    var wpt_bodies;

    if (true) { // LIVE = true
      wpt_bodies = JSON.parse(wpt_bodies_string); // LIVE
    }
    else 
    {
      // TEST
      wpt_bodies = {
        "canonicals": {
          "rendered": {
              "html_link_canoncials": [
                  "https://btpi.com/"
              ]
          },
          "raw": {
              "html_link_canoncials": [
                  "https://btpi.com/"
              ]
          },
          "self_canonical": Math.floor(Math.random() * 2) == 0,
          "other_canonical": Math.floor(Math.random() * 10) == 0,
          "canonicals": [
              "https://btpi.com/"
          ],
          "url": "https://btpi.com/",
          "http_header_link_canoncials": [],
          "canonical_missmatch": Math.floor(Math.random() * 20) == 0
        },
        "robots": {
            "has_robots_meta_tag":  Math.floor(Math.random() * 3) == 0,
            "has_x_robots_tag": Math.floor(Math.random() * 20) == 0,
            "rendered": {
                "otherbot": {
                    "status_index": true,
                    "status_follow": true,
                    "via_meta_tag": false,
                    "via_x_robots_tag": false
                },
                "googlebot": {
                    "status_index": true,
                    "status_follow": true,
                    "via_meta_tag": false,
                    "via_x_robots_tag": false
                },
                "googlebot_news": {
                    "status_index": true,
                    "status_follow": true,
                    "via_meta_tag": false,
                    "via_x_robots_tag": false
                },
                "google": {}
            },
            "raw": {
                "otherbot": {
                    "status_index": true,
                    "status_follow": true,
                    "via_meta_tag": false,
                    "via_x_robots_tag": false
                },
                "googlebot": {
                    "status_index": true,
                    "status_follow": true,
                    "via_meta_tag": false,
                    "via_x_robots_tag": false
                },
                "googlebot_news": {
                    "status_index": true,
                    "status_follow": true,
                    "via_meta_tag": false,
                    "via_x_robots_tag": false
                },
                "google": {}
            }
        },
        "title": {
          "rendered": {
              "primary": {
                  "characters": Math.floor(Math.random() * 200),
                  "words": Math.floor(Math.random() * 20),
                  "text": "Headsets, Wireless Plantronics Headset Distributor, BTP"
              },
              "total": Math.floor(Math.random() * 3)
          },
          "raw": {
              "primary": {
                  "characters": 55,
                  "words": 6,
                  "text": "Headsets, Wireless Plantronics Headset Distributor, BTP"
              },
              "total": 2
          },
          "title_changed_on_render": Math.floor(Math.random() * 5) == 0
        },
        "meta_description": {
          "rendered": {
              "all": {
                  "text": "BUGG has you covered with BUGGINS insect repellents and BUGGSLAYER insecticides. Click here to solve box elder bug, stink bug, Asian lady beetle and over 50 other bug problems.",
                  "words": 29,
                  "characters": 176
              },
              "primary": {
                  "characters": 176,
                  "words": 29,
                  "text": "BUGG has you covered with BUGGINS insect repellents and BUGGSLAYER insecticides. Click here to solve box elder bug, stink bug, Asian lady beetle and over 50 other bug problems."
              },
              "total": Math.floor(Math.random() * 3)
          },
          "raw": {
              "all": {
                  "text": "BUGG has you covered with BUGGINS insect repellents and BUGGSLAYER insecticides. Click here to solve box elder bug, stink bug, Asian lady beetle and over 50 other bug problems.",
                  "words": 29,
                  "characters": 176
              },
              "primary": {
                  "characters": 176,
                  "words": 29,
                  "text": "BUGG has you covered with BUGGINS insect repellents and BUGGSLAYER insecticides. Click here to solve box elder bug, stink bug, Asian lady beetle and over 50 other bug problems."
              },
              "total": 1
          }
        },
        "headings": {
          "rendered": {
              "first_non_empty_heading_hidden": false,
              "primary": {
                  "words": 3,
                  "characters": 17,
                  "matches_title":  Math.floor(Math.random() * 2) == 0,
                  "text": "BUGG Products LLC",
                  "level": 1
              },
              "h1": {
                  "total": Math.floor(Math.random() * 2),
                  "non_empty_total":  Math.floor(Math.random() * 2),
                  "characters": 17,
                  "words": 3
              },
              "h2": {
                  "total": Math.floor(Math.random() * 3),
                  "non_empty_total":  Math.floor(Math.random() * 3),
                  "characters": 186,
                  "words": 28
              },
              "h3": {
                  "total": Math.floor(Math.random() * 4),
                  "non_empty_total":  Math.floor(Math.random() * 3),
                  "characters": 0,
                  "words": 0
              },
              "h4": {
                  "total": Math.floor(Math.random() * 5),
                  "non_empty_total":  Math.floor(Math.random() * 3),
                  "characters": 0,
                  "words": 0
              },
              "h5": {
                  "total": Math.floor(Math.random() * 2),
                  "non_empty_total":  Math.floor(Math.random() * 3),
                  "characters": 0,
                  "words": 0
              },
              "h6": {
                  "total":  Math.floor(Math.random() * 2),
                  "non_empty_total":  Math.floor(Math.random() * 3),
                  "characters": 0,
                  "words": 0
              },
              "h7": {
                  "total":  Math.floor(Math.random() * 2),
                  "non_empty_total":  Math.floor(Math.random() * 3),
                  "characters": 0,
                  "words": 0
              },
              "h8": {
                  "total":  Math.floor(Math.random() * 2),
                  "non_empty_total":  Math.floor(Math.random() * 3),
                  "characters": 0,
                  "words": 0
              }
          },
          "raw": {
              "first_non_empty_heading_hidden": false,
              "primary": {
                  "words": 3,
                  "characters": 17,
                  "matches_title": false,
                  "text": "BUGG Products LLC",
                  "level": 1
              },
              "h1": {
                  "total": 1,
                  "non_empty_total": 1,
                  "characters": 17,
                  "words": 3
              },
              "h2": {
                  "total": 4,
                  "non_empty_total": 4,
                  "characters": 186,
                  "words": 28
              },
              "h3": {
                  "total": 0,
                  "non_empty_total": 0,
                  "characters": 0,
                  "words": 0
              },
              "h4": {
                  "total": 0,
                  "non_empty_total": 0,
                  "characters": 0,
                  "words": 0
              },
              "h5": {
                  "total": 0,
                  "non_empty_total": 0,
                  "characters": 0,
                  "words": 0
              },
              "h6": {
                  "total": 0,
                  "non_empty_total": 0,
                  "characters": 0,
                  "words": 0
              },
              "h7": {
                  "total": 0,
                  "non_empty_total": 0,
                  "characters": 0,
                  "words": 0
              },
              "h8": {
                  "total": 0,
                  "non_empty_total": 0,
                  "characters": 0,
                  "words": 0
              }
          }
        },
        "hreflangs": {
          "http_header": {
              "values": []
          },
          "rendered": {
              "values": [
                  "en-us",
                  "en-gb",
                  "en-ca",
                  "fr-ca"
              ]
          },
          "raw": {
              "values": [
                  "en-us",
                  "en-gb",
                  "en-ca",
                  "fr-ca"
              ]
          }
        },
      "structured_data": {
          "rendered": {
              "jsonld_and_microdata_types": [
                  {
                      "name": "schema.org/-UnknownType-",
                      "count": 4,
                      "jsonld": 4,
                      "microdata": 0,
                      "https": 4,
                      "http": 0,
                      "www": 0
                  },
                  {
                      "name": "schema.org/Organization",
                      "count": 1,
                      "jsonld": 1,
                      "microdata": 0,
                      "https": 1,
                      "http": 0,
                      "www": 0
                  },
                  {
                      "name": "schema.org/WebSite",
                      "count": 1,
                      "jsonld": 1,
                      "microdata": 0,
                      "https": 1,
                      "http": 0,
                      "www": 0
                  },
                  {
                      "name": "schema.org/WebPage",
                      "count": 1,
                      "jsonld": 1,
                      "microdata": 0,
                      "https": 1,
                      "http": 0,
                      "www": 0
                  }
              ],
              "jsonldIds": 3,
              "jsonldReferencedIds": 3,
              "microdataIds": 0,
              "microdataReferencedIds": 0,
              "jsonlsMicrodataCommonIds": 0,
              "logo": false,
              "sitelinks_search_box": false,
              "same_as_values": [],
              "items_by_format": {
                  "microformats2": 0,
                  "microdata": 0,
                  "jsonld": 7,
                  "rdfa": 0
              },
              "context_hostnames": [
                  "schema.org"
              ],
              "jsonld_scripts": {
                  "count": 1,
                  "errors": 0
              },
              "microformats2_types": []
          },
          "raw": {
              "jsonld_and_microdata_types": [
                  {
                      "name": "schema.org/-UnknownType-",
                      "count": 4,
                      "jsonld": 4,
                      "microdata": 0,
                      "https": 4,
                      "http": 0,
                      "www": 0
                  },
                  {
                      "name": "schema.org/Organization",
                      "count": 1,
                      "jsonld": 1,
                      "microdata": 0,
                      "https": 1,
                      "http": 0,
                      "www": 0
                  },
                  {
                      "name": "schema.org/WebSite",
                      "count": 1,
                      "jsonld": 1,
                      "microdata": 0,
                      "https": 1,
                      "http": 0,
                      "www": 0
                  },
                  {
                      "name": "schema.org/WebPage",
                      "count": 1,
                      "jsonld": 1,
                      "microdata": 0,
                      "https": 1,
                      "http": 0,
                      "www": 0
                  }
              ],
              "jsonldIds": 3,
              "jsonldReferencedIds": 3,
              "microdataIds": 0,
              "microdataReferencedIds": 0,
              "jsonlsMicrodataCommonIds": 0,
              "logo": false,
              "sitelinks_search_box": false,
              "same_as_values": [],
              "items_by_format": {
                  "microformats2": 0,
                  "microdata": 0,
                  "jsonld": 7,
                  "rdfa": 0
              },
              "context_hostnames": [
                  "schema.org"
              ],
              "jsonld_scripts": {
                  "count": 1,
                  "errors": 0
              },
              "microformats2_types": []
          }
        }
      }; 
      if (Math.floor(Math.random() * 50) == 0) {
        wpt_bodies.canonicals.canonicals = []; // sometimes no canonicals
      }
      if (Math.floor(Math.random() * 25) == 0) {
        wpt_bodies.canonicals.rendered.html_link_canoncials = ["https://someoneelse.com/"]; // sometimes rendering changes it
      }
      if (Math.floor(Math.random() * 30) == 0) {
        wpt_bodies.canonicals.http_header_link_canoncials = ["https://someoneelse.com/"]; // sometimes header exists
      }
      if (Math.floor(Math.random() * 10) == 0) {
        wpt_bodies.hreflangs.rendered.values.push("en-au"); 
      }  else if (Math.floor(Math.random() * 10) == 0) {
        wpt_bodies.hreflangs.rendered.values = []; 
      }  else if (Math.floor(Math.random() * 10) == 0) {
        wpt_bodies.hreflangs.raw.values = []; 
      }
      if (Math.floor(Math.random() * 20) == 0) {
        wpt_bodies.hreflangs.http_header.values.push("en-au"); 
      }
      if (Math.floor(Math.random() * 30) == 0) {
        wpt_bodies.canonicals.raw = {}; // sometimes no raw canonicals
      }
      if (Math.floor(Math.random() * 15) == 0) {
        wpt_bodies.canonicals.rendered = {}; // sometimes no rendered canonicals
      }
      if (Math.floor(Math.random() * 15) == 0) {
        wpt_bodies.robots.rendered.googlebot.status_index = false; 
      }
      if (Math.floor(Math.random() * 5) == 0) {
        wpt_bodies.structured_data.rendered.jsonld_and_microdata_types.push({"name": "schema.org/RenderedType", "count": 4, "jsonld": 4, "https": 4}); 
      }
      if (Math.floor(Math.random() * 100) == 0) {
        wpt_bodies.structured_data.rendered.jsonld_and_microdata_types = []; 
      }
      if (Math.floor(Math.random() * 10) == 0) {
        wpt_bodies.structured_data.raw.jsonld_and_microdata_types = []; 
        wpt_bodies.structured_data.rendered.jsonld_and_microdata_types = []; 
      }
      if (Math.floor(Math.random() * 20) == 0) {
        wpt_bodies.structured_data.raw.jsonld_and_microdata_types = [];  
      }
    }


  if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

  // tests if two string arrays contain the same strings
  function compareStringArrays(array1, array2) {
      if (!array1 && !array2) return true; // both missing
      if (!array1 && array2.length > 0) return false; 
      if (!array2 && array1.length > 0) return false; 
      if (array1.length != array2.length) return false;

      array1 = array1.slice();
      array1.sort();
      array2 = array2.slice();
      array2.sort();

      for (var i = 0; i < array1.length; i++) {
          if (array1[i] != array2[i]) {
              return false;
          }
      }

      return true;
  }

  var title = wpt_bodies.title;
  if (title) {
    if (title.rendered) {
      var title_rendered = title.rendered;
      //Number of words in the title tag
      if (title_rendered.primary) {
        result.title_words = title_rendered.primary.words;
      }

      //If the webpage has a title
      result.n_titles = title_rendered.total
    }
  }

  var meta_description = wpt_bodies.meta_description;
  if (meta_description) {
    
    if (meta_description.rendered) {
      //If the webpage has a meta description
      result.n_meta_descriptions = meta_description.rendered.total;
    }
  }

  var headings = wpt_bodies.headings;
  if (headings) {
    var headings_rendered = headings.rendered;
    if (headings_rendered) {

      //If the webpage has h1
      result.n_h1 = headings_rendered.h1.total;

      //If the webpage has h2
      result.n_h2 = headings_rendered.h2.total;

      //If the webpage has h3
      result.n_h3 = headings_rendered.h3.total;

      //If the webpage has h4
      result.n_h4 = headings_rendered.h4.total;

      //If the webpage has a non empty h1
      result.n_non_empty_h1 = headings_rendered.h1.non_empty_total;

      //If the webpage has a non empty h2
      result.n_non_empty_h2 = headings_rendered.h2.non_empty_total;

      //If the webpage has a non empty h3
      result.n_non_empty_h3 = headings_rendered.h3.non_empty_total;

      //If the webpage has a non empty h4
      result.n_non_empty_h4 = headings_rendered.h4.non_empty_total;


      //If h1 and title tag are the same
      result.has_same_h1_title = headings_rendered.primary.matches_title;
    }
  }

  var robots = wpt_bodies.robots;
  if (robots) {
    result.robots_has_robots_meta_tag = robots.has_robots_meta_tag;
    result.robots_has_x_robots_tag = robots.has_x_robots_tag;

    // added to rendered
    // has_rendered_robots_meta_tag ???
    // added to raw
    // raw and rendered are different

    //rendering_changed_robots_meta_tag
    // if the raw and rendered data are different.
    if (robots.raw && robots.rendered) {
      var rendered = robots.rendered;
      var raw = robots.raw;
      if (
        rendered.otherbot.status_index !== raw.otherbot.status_index ||
        rendered.otherbot.status_follow !== raw.otherbot.status_follow ||
        rendered.googlebot.status_index !== raw.googlebot.status_index ||
        rendered.googlebot.status_follow !== raw.googlebot.status_follow ||
        rendered.googlebot_news.status_index !== raw.googlebot_news.status_index ||
        rendered.googlebot_news.status_follow !== raw.googlebot_news.status_follow ||
        JSON.stringify(rendered.google) !== JSON.stringify(raw.google)
      )
      {
        result.rendering_changed_robots_meta_tag = true;
      }
      else 
      {
        result.rendering_changed_robots_meta_tag = false;
      }
      // result.rendering_changed_robots_meta_tag = JSON.stringify(robots.raw) === JSON.stringify(robots.rendered);
    }

  }

  var canonicals = wpt_bodies.canonicals;
  if (canonicals) {

    if (canonicals.canonicals && canonicals.canonicals.length) {
      result.has_canonicals = canonicals.canonicals.length > 0;
    }

    if (canonicals.self_canonical) {
      result.has_self_canonical = canonicals.self_canonical;
    }

    if (canonicals.other_canonical) {
      result.is_canonicalized = canonicals.other_canonical;
    }

    if (canonicals.http_header_link_canoncials) {     
      result.has_http_canonical = canonicals.http_header_link_canoncials.length > 0;
    }

    result.has_rendered_canonical = false; // used in a NOT so must be set for a simple query to work
    if (canonicals.rendered && canonicals.rendered.html_link_canoncials) {     
      result.has_rendered_canonical = canonicals.rendered.html_link_canoncials.length > 0;
    }

    result.has_raw_canonical = false; // used in a NOT so must be set for a simple query to work
    if (canonicals.raw && canonicals.raw.html_link_canoncials) {     
      result.has_raw_canonical = canonicals.raw.html_link_canoncials.length > 0;
    }

    if (canonicals.canonical_missmatch) {
      result.has_canonical_mismatch = canonicals.canonical_missmatch;
    }

    if (canonicals.raw && canonicals.rendered) {
      result.rendering_changed_canonical = !compareStringArrays(canonicals.raw.html_link_canoncials, canonicals.rendered.html_link_canoncials);
    }

    if (canonicals.raw && canonicals.http_header_link_canoncials && canonicals.http_header_link_canoncials.length > 0) {
      result.http_header_changed_canonical = !compareStringArrays(canonicals.raw.html_link_canoncials, canonicals.http_header_link_canoncials);
    }
  }

  var hreflangs = wpt_bodies.hreflangs;
  if (hreflangs) {

    if (hreflangs.raw && hreflangs.raw.values && hreflangs.rendered && hreflangs.rendered.values) {
      result.rendering_changed_hreflang = !compareStringArrays(hreflangs.raw.values, hreflangs.rendered.values);
    }

    if (hreflangs.rendered && hreflangs.rendered.values) {
      result.has_hreflang = hreflangs.rendered.values.length > 0;
    }

    if (hreflangs.http_header && hreflangs.http_header.values) {
      result.has_http_hreflang = hreflangs.http_header.values.length > 0;
    }

    result.has_rendered_hreflang = false; // used in a NOT so must be set for a simple query to work
    if (hreflangs.rendered && hreflangs.rendered.values) {     
      result.has_rendered_hreflang = hreflangs.rendered.values.length > 0;
    }

    result.has_raw_hreflang = false; // used in a NOT so must be set for a simple query to work
    if (hreflangs.raw && hreflangs.raw.values) {     
      result.has_raw_hreflang = hreflangs.raw.values.length > 0;
    }
  }

  var structured_data = wpt_bodies.structured_data;
  if (structured_data) {
    result.has_raw_jsonld_or_microdata = structured_data.raw && structured_data.raw.jsonld_and_microdata_types && structured_data.raw.jsonld_and_microdata_types.length > 0;
    result.has_rendered_jsonld_or_microdata = structured_data.rendered && structured_data.rendered.jsonld_and_microdata_types  && structured_data.rendered.jsonld_and_microdata_types.length > 0;

    if (structured_data.raw && structured_data.rendered) {
      result.rendering_changes_structured_data = JSON.stringify(structured_data.raw) !== JSON.stringify(structured_data.rendered);
    }
  }
} catch (e) {}
return result;
''';

SELECT
  client,
  COUNT(0) AS total,
  
  # titles with less than 5 words (NOT USED?)
  # COUNTIF(wpt_bodies_info.title_words < 5) AS freq_short_title_tag,
  #AS_PERCENT(COUNTIF(wpt_bodies_info.title_words < 5), COUNT(0)) AS pct_short_title_tag,

  # meta title inclusion
  # COUNTIF(wpt_bodies_info.n_titles > 0) AS freq_has_title_tag,
  AS_PERCENT(COUNTIF(wpt_bodies_info.n_titles > 0), COUNT(0)) AS pct_has_title_tag,

  # meta description inclusion
  # COUNTIF(wpt_bodies_info.n_meta_descriptions > 0) AS freq_has_meta_description,
  AS_PERCENT(COUNTIF(wpt_bodies_info.n_meta_descriptions > 0), COUNT(0)) AS pct_has_meta_description,

  # H1 inclusion
  # COUNTIF(wpt_bodies_info.n_h1 > 0) AS freq_has_h1,
  AS_PERCENT(COUNTIF(wpt_bodies_info.n_h1 > 0), COUNT(0)) AS pct_has_h1,

  # H2 inclusion
  # COUNTIF(wpt_bodies_info.n_h2 > 0) AS freq_has_h2,
  AS_PERCENT(COUNTIF(wpt_bodies_info.n_h2 > 0), COUNT(0)) AS pct_has_h2,

  # H3 inclusion
  # COUNTIF(wpt_bodies_info.n_h3 > 0) AS freq_has_h3,
  AS_PERCENT(COUNTIF(wpt_bodies_info.n_h3 > 0), COUNT(0)) AS pct_has_h3,

  # H4 inclusion
  # COUNTIF(wpt_bodies_info.n_h4 > 0) AS freq_has_h4,
  AS_PERCENT(COUNTIF(wpt_bodies_info.n_h4 > 0), COUNT(0)) AS pct_has_h4,

  # Non-empty H1 inclusion
  # COUNTIF(wpt_bodies_info.n_non_empty_h1 > 0) AS freq_has_non_empty_h1,
  AS_PERCENT(COUNTIF(wpt_bodies_info.n_non_empty_h1 > 0), COUNT(0)) AS pct_has_non_empty_h1,

  # Non-empty H2 inclusion
  # COUNTIF(wpt_bodies_info.n_non_empty_h2 > 0) AS freq_has_non_empty_h2,
  AS_PERCENT(COUNTIF(wpt_bodies_info.n_non_empty_h2 > 0), COUNT(0)) AS pct_has_non_empty_h2,

  # Non-empty H3 inclusion
  # COUNTIF(wpt_bodies_info.n_non_empty_h3 > 0) AS freq_has_non_empty_h3,
  AS_PERCENT(COUNTIF(wpt_bodies_info.n_non_empty_h3 > 0), COUNT(0)) AS pct_has_non_empty_h3,

  # Non-empty H4 inclusion
  # COUNTIF(wpt_bodies_info.n_non_empty_h4 > 0) AS freq_has_non_empty_h4,
  AS_PERCENT(COUNTIF(wpt_bodies_info.n_non_empty_h4 > 0), COUNT(0)) AS pct_has_non_empty_h4,

  # Same title and H1
  # COUNTIF(wpt_bodies_info.has_same_h1_title ) AS freq_has_same_h1_title,
  AS_PERCENT(COUNTIF(wpt_bodies_info.has_same_h1_title ), COUNT(0)) AS pct_has_same_h1_title,

  # Meta Robots inclusion
  # COUNTIF(wpt_bodies_info.robots_has_robots_meta_tag) AS freq_has_meta_robots,
  AS_PERCENT(COUNTIF(wpt_bodies_info.robots_has_robots_meta_tag), COUNT(0)) AS pct_has_meta_robots,

  # HTTP Header Robots inclusion
  # COUNTIF(wpt_bodies_info.robots_has_x_robots_tag) AS freq_has_x_robots_tag,
  AS_PERCENT(COUNTIF(wpt_bodies_info.robots_has_x_robots_tag), COUNT(0)) AS pct_has_x_robots_tag,

  # Meta Robots and x-robots inclusion
  # COUNTIF(wpt_bodies_info.robots_has_robots_meta_tag AND wpt_bodies_info.robots_has_x_robots_tag) AS freq_has_meta_robots_and_x_robots_tag,
  AS_PERCENT(COUNTIF(wpt_bodies_info.robots_has_robots_meta_tag AND wpt_bodies_info.robots_has_x_robots_tag), COUNT(0)) AS pct_has_meta_robots_and_x_robots_tag,

  # Rendering changed Robots
  # COUNTIF(wpt_bodies_info.rendering_changed_robots_meta_tag) AS freq_rendering_changed_robots_meta_tag,
  AS_PERCENT(COUNTIF(wpt_bodies_info.rendering_changed_robots_meta_tag), COUNT(0)) AS pct_rendering_changed_robots_meta_tag,

  # Pages with canonical
  #COUNTIF(wpt_bodies_info.has_canonicals) as has_canonical,
  AS_PERCENT(COUNTIF(wpt_bodies_info.has_canonicals), COUNT(0)) AS pct_has_canonical,

  # Pages with self-canonical
  #COUNTIF(wpt_bodies_info.has_self_canonical) as has_self_canonical,
  AS_PERCENT(COUNTIF(wpt_bodies_info.has_self_canonical), COUNT(0)) AS pct_has_self_canonical,

  # Pages canonicalized
  #COUNTIF(wpt_bodies_info.is_canonicalized)) as is_canonicalized,
  AS_PERCENT(COUNTIF(wpt_bodies_info.is_canonicalized), COUNT(0)) AS pct_is_canonicalized,

  # Pages with canonical in HTTP header 
  #COUNTIF(wpt_bodies_info.has_http_canonical) as has_http_canonical,
  AS_PERCENT(COUNTIF(wpt_bodies_info.has_http_canonical), COUNT(0)) AS pct_http_canonical,

  # Pages with canonical in raw html 
  #COUNTIF(wpt_bodies_info.has_raw_canonical) as has_raw_canonical,
  AS_PERCENT(COUNTIF(wpt_bodies_info.has_raw_canonical), COUNT(0)) AS pct_has_raw_canonical,

  # Pages with canonical in rendered html 
  #COUNTIF(wpt_bodies_info.has_rendered_canonical) as has_rendered_canonical,
  AS_PERCENT(COUNTIF(wpt_bodies_info.has_rendered_canonical), COUNT(0)) AS pct_has_rendered_canonical,

  # Pages with canonical in rendered but not raw html 
  #COUNTIF(wpt_bodies_info.has_rendered_canonical AND NOT wpt_bodies_info.has_raw_canonical) as has_rendered_but_not_raw_canonical,
  AS_PERCENT(COUNTIF(wpt_bodies_info.has_rendered_canonical AND NOT wpt_bodies_info.has_raw_canonical), COUNT(0)) AS pct_has_rendered_but_not_raw_canonical,

  # Pages with canonical mismatch
  #COUNTIF(wpt_bodies_info.has_canonical_mismatch) as has_canonical_mismatch,
  AS_PERCENT(COUNTIF(wpt_bodies_info.has_canonical_mismatch), COUNT(0)) AS pct_has_canonical_mismatch,

  # Pages with canonical conflict between raw and rendered 
  #COUNTIF(wpt_bodies_info.rendering_changed_canonical) as has_conflict_rendering_changed_canonical,
  AS_PERCENT(COUNTIF(wpt_bodies_info.rendering_changed_canonical), COUNT(0)) AS pct_has_conflict_rendering_changed_canonical, 

  # Pages with canonical conflict between raw and http header 
  #COUNTIF(wpt_bodies_info.http_header_changed_canonical) as has_conflict_http_header_changed_canonical,
  AS_PERCENT(COUNTIF(wpt_bodies_info.http_header_changed_canonical), COUNT(0)) AS pct_has_conflict_http_header_changed_canonical,

  # Pages with canonical conflict between raw and http header 
  #COUNTIF(wpt_bodies_info.http_header_changed_canonical OR wpt_bodies_info.rendering_changed_canonical) as has_conflict_http_header_or_rendering_changed_canonical,
  AS_PERCENT(COUNTIF(wpt_bodies_info.http_header_changed_canonical OR wpt_bodies_info.rendering_changed_canonical), COUNT(0)) AS pct_has_conflict_http_header_or_rendering_changed_canonical,

   # Pages with hreflang conflict between raw and rendered 
  #COUNTIF(wpt_bodies_info.rendering_changed_hreflang) as has_conflict_raw_rendered_hreflang,
  AS_PERCENT(COUNTIF(wpt_bodies_info.rendering_changed_hreflang), COUNT(0)) AS pct_has_conflict_raw_rendered_hreflang, 

  # Pages with hreflang
  #COUNTIF(wpt_bodies_info.has_hreflang) as has_hreflang,
  AS_PERCENT(COUNTIF(wpt_bodies_info.has_hreflang), COUNT(0)) AS pct_has_hreflang,

  # Pages with http hreflang
  #COUNTIF(wpt_bodies_info.has_http_hreflang) as has_http_hreflang,
  AS_PERCENT(COUNTIF(wpt_bodies_info.has_http_hreflang), COUNT(0)) AS pct_has_http_hreflang,

  # Pages with rendered hreflang
  #COUNTIF(wpt_bodies_info.has_rendered_hreflang) as has_rendered_hreflang,
  AS_PERCENT(COUNTIF(wpt_bodies_info.has_rendered_hreflang), COUNT(0)) AS pct_has_rendered_hreflang,

  # Pages with raw hreflang
  #COUNTIF(wpt_bodies_info.has_raw_hreflang) as has_raw_hreflang,
  AS_PERCENT(COUNTIF(wpt_bodies_info.has_raw_hreflang), COUNT(0)) AS pct_has_raw_hreflang,

  # Pages with hreflang in rendered but not raw html 
  #COUNTIF(wpt_bodies_info.has_rendered_hreflang AND NOT wpt_bodies_info.has_raw_hreflang) as has_rendered_but_not_raw_hreflang,
  AS_PERCENT(COUNTIF(wpt_bodies_info.has_rendered_hreflang AND NOT wpt_bodies_info.has_raw_hreflang), COUNT(0)) AS pct_has_rendered_but_not_raw_hreflang,

  # Pages with raw jsonld or microdata
  #COUNTIF(wpt_bodies_info.has_raw_jsonld_or_microdata) as has_raw_jsonld_or_microdata,
  AS_PERCENT(COUNTIF(wpt_bodies_info.has_raw_jsonld_or_microdata), COUNT(0)) AS pct_has_raw_jsonld_or_microdata,

  # Pages with rendered jsonld or microdata
  #COUNTIF(wpt_bodies_info.has_rendered_jsonld_or_microdata) as has_rendered_jsonld_or_microdata,
  AS_PERCENT(COUNTIF(wpt_bodies_info.has_rendered_jsonld_or_microdata), COUNT(0)) AS pct_has_rendered_jsonld_or_microdata,

    # Pages with only rendered jsonld or microdata
  #COUNTIF(wpt_bodies_info.has_rendered_jsonld_or_microdata AND NOT wpt_bodies_info.has_raw_jsonld_or_microdata) as has_only_rendered_jsonld_or_microdata,
  AS_PERCENT(COUNTIF(wpt_bodies_info.has_rendered_jsonld_or_microdata AND NOT wpt_bodies_info.has_raw_jsonld_or_microdata), COUNT(0)) AS pct_has_only_rendered_jsonld_or_microdata,

  # Pages where rendering changed jsonld or microdata
  #COUNTIF(wpt_bodies_info.rendering_changes_structured_data) as rendering_changes_structured_data,
  AS_PERCENT(COUNTIF(wpt_bodies_info.rendering_changes_structured_data), COUNT(0)) AS pct_rendering_changes_structured_data,

  # http or https
  #COUNTIF(protocol = "https") as https_count,
  AS_PERCENT(COUNTIF(protocol = "https"), COUNT(0)) AS pct_https,

  FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        SPLIT(url, ":")[OFFSET(0)] as protocol,
        #get_wpt_bodies_info('') AS wpt_bodies_info # TEST
        get_wpt_bodies_info(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies')) AS wpt_bodies_info # LIVE      
      FROM
        #`httparchive.sample_data.pages_*` # TEST
        `httparchive.pages.2020_08_01_*` # LIVE
    )
GROUP BY
  client
