#standardSQL
# All CMS popularity per geo
CREATE TEMP FUNCTION GET_GEO(country_code STRING, geo STRING) RETURNS STRING LANGUAGE js AS '''
var countries = {
  "af": {
    "name": "Afghanistan",
    "region": "Asia",
    "sub-region": "Southern Asia"
  },
  "ax": {
    "name": "Åland Islands",
    "region": "Europe",
    "sub-region": "Northern Europe"
  },
  "al": {
    "name": "Albania",
    "region": "Europe",
    "sub-region": "Southern Europe"
  },
  "dz": {
    "name": "Algeria",
    "region": "Africa",
    "sub-region": "Northern Africa"
  },
  "as": {
    "name": "American Samoa",
    "region": "Oceania",
    "sub-region": "Polynesia"
  },
  "ad": {
    "name": "Andorra",
    "region": "Europe",
    "sub-region": "Southern Europe"
  },
  "ao": {
    "name": "Angola",
    "region": "Africa",
    "sub-region": "Middle Africa"
  },
  "ai": {
    "name": "Anguilla",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "ag": {
    "name": "Antigua and Barbuda",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "ar": {
    "name": "Argentina",
    "region": "Americas",
    "sub-region": "South America"
  },
  "am": {
    "name": "Armenia",
    "region": "Asia",
    "sub-region": "Western Asia"
  },
  "aw": {
    "name": "Aruba",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "au": {
    "name": "Australia",
    "region": "Oceania",
    "sub-region": "Australia and New Zealand"
  },
  "at": {
    "name": "Austria",
    "region": "Europe",
    "sub-region": "Western Europe"
  },
  "az": {
    "name": "Azerbaijan",
    "region": "Asia",
    "sub-region": "Western Asia"
  },
  "bs": {
    "name": "Bahamas",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "bh": {
    "name": "Bahrain",
    "region": "Asia",
    "sub-region": "Western Asia"
  },
  "bd": {
    "name": "Bangladesh",
    "region": "Asia",
    "sub-region": "Southern Asia"
  },
  "bb": {
    "name": "Barbados",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "by": {
    "name": "Belarus",
    "region": "Europe",
    "sub-region": "Eastern Europe"
  },
  "be": {
    "name": "Belgium",
    "region": "Europe",
    "sub-region": "Western Europe"
  },
  "bz": {
    "name": "Belize",
    "region": "Americas",
    "sub-region": "Central America"
  },
  "bj": {
    "name": "Benin",
    "region": "Africa",
    "sub-region": "Western Africa"
  },
  "bm": {
    "name": "Bermuda",
    "region": "Americas",
    "sub-region": "Northern America"
  },
  "bt": {
    "name": "Bhutan",
    "region": "Asia",
    "sub-region": "Southern Asia"
  },
  "bo": {
    "name": "Bolivia (Plurinational State of)",
    "region": "Americas",
    "sub-region": "South America"
  },
  "bq": {
    "name": "Bonaire, Sint Eustatius and Saba",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "ba": {
    "name": "Bosnia and Herzegovina",
    "region": "Europe",
    "sub-region": "Southern Europe"
  },
  "bw": {
    "name": "Botswana",
    "region": "Africa",
    "sub-region": "Southern Africa"
  },
  "br": {
    "name": "Brazil",
    "region": "Americas",
    "sub-region": "South America"
  },
  "io": {
    "name": "British Indian Ocean Territory",
    "region": null,
    "sub-region": null
  },
  "bn": {
    "name": "Brunei Darussalam",
    "region": "Asia",
    "sub-region": "South-Eastern Asia"
  },
  "bg": {
    "name": "Kosovo",
    "region": "Europe",
    "sub-region": "Eastern Europe"
  },
  "bf": {
    "name": "Burkina Faso",
    "region": "Africa",
    "sub-region": "Western Africa"
  },
  "bi": {
    "name": "Burundi",
    "region": "Africa",
    "sub-region": "Eastern Africa"
  },
  "kh": {
    "name": "Cambodia",
    "region": "Asia",
    "sub-region": "South-Eastern Asia"
  },
  "cm": {
    "name": "Cameroon",
    "region": "Africa",
    "sub-region": "Middle Africa"
  },
  "ca": {
    "name": "Canada",
    "region": "Americas",
    "sub-region": "Northern America"
  },
  "cv": {
    "name": "Cabo Verde",
    "region": "Africa",
    "sub-region": "Western Africa"
  },
  "ky": {
    "name": "Cayman Islands",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "cf": {
    "name": "Central African Republic",
    "region": "Africa",
    "sub-region": "Middle Africa"
  },
  "td": {
    "name": "Chad",
    "region": "Africa",
    "sub-region": "Middle Africa"
  },
  "cl": {
    "name": "Chile",
    "region": "Americas",
    "sub-region": "South America"
  },
  "cn": {
    "name": "China",
    "region": "Asia",
    "sub-region": "Eastern Asia"
  },
  "cx": {
    "name": "Christmas Island",
    "region": null,
    "sub-region": null
  },
  "co": {
    "name": "Colombia",
    "region": "Americas",
    "sub-region": "South America"
  },
  "km": {
    "name": "Comoros",
    "region": "Africa",
    "sub-region": "Eastern Africa"
  },
  "cg": {
    "name": "Congo",
    "region": "Africa",
    "sub-region": "Middle Africa"
  },
  "cd": {
    "name": "Congo (Democratic Republic of the)",
    "region": "Africa",
    "sub-region": "Middle Africa"
  },
  "ck": {
    "name": "Cook Islands",
    "region": "Oceania",
    "sub-region": "Polynesia"
  },
  "cr": {
    "name": "Costa Rica",
    "region": "Americas",
    "sub-region": "Central America"
  },
  "ci": {
    "name": "Côte d'Ivoire",
    "region": "Africa",
    "sub-region": "Western Africa"
  },
  "hr": {
    "name": "Croatia",
    "region": "Europe",
    "sub-region": "Southern Europe"
  },
  "cu": {
    "name": "Cuba",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "cw": {
    "name": "Curaçao",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "cy": {
    "name": "Cyprus",
    "region": "Asia",
    "sub-region": "Western Asia"
  },
  "cz": {
    "name": "Czech Republic",
    "region": "Europe",
    "sub-region": "Eastern Europe"
  },
  "dk": {
    "name": "Denmark",
    "region": "Europe",
    "sub-region": "Northern Europe"
  },
  "dj": {
    "name": "Djibouti",
    "region": "Africa",
    "sub-region": "Eastern Africa"
  },
  "dm": {
    "name": "Dominica",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "do": {
    "name": "Dominican Republic",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "ec": {
    "name": "Ecuador",
    "region": "Americas",
    "sub-region": "South America"
  },
  "eg": {
    "name": "Egypt",
    "region": "Africa",
    "sub-region": "Northern Africa"
  },
  "sv": {
    "name": "El Salvador",
    "region": "Americas",
    "sub-region": "Central America"
  },
  "gq": {
    "name": "Equatorial Guinea",
    "region": "Africa",
    "sub-region": "Middle Africa"
  },
  "er": {
    "name": "Eritrea",
    "region": "Africa",
    "sub-region": "Eastern Africa"
  },
  "ee": {
    "name": "Estonia",
    "region": "Europe",
    "sub-region": "Northern Europe"
  },
  "et": {
    "name": "Ethiopia",
    "region": "Africa",
    "sub-region": "Eastern Africa"
  },
  "fk": {
    "name": "Falkland Islands (Malvinas)",
    "region": "Americas",
    "sub-region": "South America"
  },
  "fo": {
    "name": "Faroe Islands",
    "region": "Europe",
    "sub-region": "Northern Europe"
  },
  "fj": {
    "name": "Fiji",
    "region": "Oceania",
    "sub-region": "Melanesia"
  },
  "fi": {
    "name": "Finland",
    "region": "Europe",
    "sub-region": "Northern Europe"
  },
  "fr": {
    "name": "France",
    "region": "Europe",
    "sub-region": "Western Europe"
  },
  "gf": {
    "name": "French Guiana",
    "region": "Americas",
    "sub-region": "South America"
  },
  "pf": {
    "name": "French Polynesia",
    "region": "Oceania",
    "sub-region": "Polynesia"
  },
  "ga": {
    "name": "Gabon",
    "region": "Africa",
    "sub-region": "Middle Africa"
  },
  "gm": {
    "name": "Gambia",
    "region": "Africa",
    "sub-region": "Western Africa"
  },
  "ge": {
    "name": "Georgia",
    "region": "Asia",
    "sub-region": "Western Asia"
  },
  "de": {
    "name": "Germany",
    "region": "Europe",
    "sub-region": "Western Europe"
  },
  "gh": {
    "name": "Ghana",
    "region": "Africa",
    "sub-region": "Western Africa"
  },
  "gi": {
    "name": "Gibraltar",
    "region": "Europe",
    "sub-region": "Southern Europe"
  },
  "gr": {
    "name": "Greece",
    "region": "Europe",
    "sub-region": "Southern Europe"
  },
  "gl": {
    "name": "Greenland",
    "region": "Americas",
    "sub-region": "Northern America"
  },
  "gd": {
    "name": "Grenada",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "gp": {
    "name": "Guadeloupe",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "gu": {
    "name": "Guam",
    "region": "Oceania",
    "sub-region": "Micronesia"
  },
  "gt": {
    "name": "Guatemala",
    "region": "Americas",
    "sub-region": "Central America"
  },
  "gg": {
    "name": "Guernsey",
    "region": "Europe",
    "sub-region": "Northern Europe"
  },
  "gn": {
    "name": "Guinea",
    "region": "Africa",
    "sub-region": "Western Africa"
  },
  "gw": {
    "name": "Guinea-Bissau",
    "region": "Africa",
    "sub-region": "Western Africa"
  },
  "gy": {
    "name": "Guyana",
    "region": "Americas",
    "sub-region": "South America"
  },
  "ht": {
    "name": "Haiti",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "hn": {
    "name": "Honduras",
    "region": "Americas",
    "sub-region": "Central America"
  },
  "hk": {
    "name": "Hong Kong",
    "region": "Asia",
    "sub-region": "Eastern Asia"
  },
  "hu": {
    "name": "Hungary",
    "region": "Europe",
    "sub-region": "Eastern Europe"
  },
  "is": {
    "name": "Iceland",
    "region": "Europe",
    "sub-region": "Northern Europe"
  },
  "in": {
    "name": "India",
    "region": "Asia",
    "sub-region": "Southern Asia"
  },
  "id": {
    "name": "Indonesia",
    "region": "Asia",
    "sub-region": "South-Eastern Asia"
  },
  "ir": {
    "name": "Iran (Islamic Republic of)",
    "region": "Asia",
    "sub-region": "Southern Asia"
  },
  "iq": {
    "name": "Iraq",
    "region": "Asia",
    "sub-region": "Western Asia"
  },
  "ie": {
    "name": "Ireland",
    "region": "Europe",
    "sub-region": "Northern Europe"
  },
  "im": {
    "name": "Isle of Man",
    "region": "Europe",
    "sub-region": "Northern Europe"
  },
  "il": {
    "name": "Israel",
    "region": "Asia",
    "sub-region": "Western Asia"
  },
  "it": {
    "name": "Italy",
    "region": "Europe",
    "sub-region": "Southern Europe"
  },
  "jm": {
    "name": "Jamaica",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "jp": {
    "name": "Japan",
    "region": "Asia",
    "sub-region": "Eastern Asia"
  },
  "je": {
    "name": "Jersey",
    "region": "Europe",
    "sub-region": "Northern Europe"
  },
  "jo": {
    "name": "Jordan",
    "region": "Asia",
    "sub-region": "Western Asia"
  },
  "kz": {
    "name": "Kazakhstan",
    "region": "Asia",
    "sub-region": "Central Asia"
  },
  "ke": {
    "name": "Kenya",
    "region": "Africa",
    "sub-region": "Eastern Africa"
  },
  "ki": {
    "name": "Kiribati",
    "region": "Oceania",
    "sub-region": "Micronesia"
  },
  "kp": {
    "name": "Korea (Democratic People's Republic of)",
    "region": "Asia",
    "sub-region": "Eastern Asia"
  },
  "kr": {
    "name": "Korea (Republic of)",
    "region": "Asia",
    "sub-region": "Eastern Asia"
  },
  "kw": {
    "name": "Kuwait",
    "region": "Asia",
    "sub-region": "Western Asia"
  },
  "kg": {
    "name": "Kyrgyzstan",
    "region": "Asia",
    "sub-region": "Central Asia"
  },
  "la": {
    "name": "Lao People's Democratic Republic",
    "region": "Asia",
    "sub-region": "South-Eastern Asia"
  },
  "lv": {
    "name": "Latvia",
    "region": "Europe",
    "sub-region": "Northern Europe"
  },
  "lb": {
    "name": "Lebanon",
    "region": "Asia",
    "sub-region": "Western Asia"
  },
  "ls": {
    "name": "Lesotho",
    "region": "Africa",
    "sub-region": "Southern Africa"
  },
  "lr": {
    "name": "Liberia",
    "region": "Africa",
    "sub-region": "Western Africa"
  },
  "ly": {
    "name": "Libya",
    "region": "Africa",
    "sub-region": "Northern Africa"
  },
  "li": {
    "name": "Liechtenstein",
    "region": "Europe",
    "sub-region": "Western Europe"
  },
  "lt": {
    "name": "Lithuania",
    "region": "Europe",
    "sub-region": "Northern Europe"
  },
  "lu": {
    "name": "Luxembourg",
    "region": "Europe",
    "sub-region": "Western Europe"
  },
  "mo": {
    "name": "Macao",
    "region": "Asia",
    "sub-region": "Eastern Asia"
  },
  "mk": {
    "name": "Macedonia (the former Yugoslav Republic of)",
    "region": "Europe",
    "sub-region": "Southern Europe"
  },
  "mg": {
    "name": "Madagascar",
    "region": "Africa",
    "sub-region": "Eastern Africa"
  },
  "mw": {
    "name": "Malawi",
    "region": "Africa",
    "sub-region": "Eastern Africa"
  },
  "my": {
    "name": "Malaysia",
    "region": "Asia",
    "sub-region": "South-Eastern Asia"
  },
  "mv": {
    "name": "Maldives",
    "region": "Asia",
    "sub-region": "Southern Asia"
  },
  "ml": {
    "name": "Mali",
    "region": "Africa",
    "sub-region": "Western Africa"
  },
  "mt": {
    "name": "Malta",
    "region": "Europe",
    "sub-region": "Southern Europe"
  },
  "mh": {
    "name": "Marshall Islands",
    "region": "Oceania",
    "sub-region": "Micronesia"
  },
  "mq": {
    "name": "Martinique",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "mr": {
    "name": "Mauritania",
    "region": "Africa",
    "sub-region": "Western Africa"
  },
  "mu": {
    "name": "Mauritius",
    "region": "Africa",
    "sub-region": "Eastern Africa"
  },
  "yt": {
    "name": "Mayotte",
    "region": "Africa",
    "sub-region": "Eastern Africa"
  },
  "mx": {
    "name": "Mexico",
    "region": "Americas",
    "sub-region": "Central America"
  },
  "fm": {
    "name": "Micronesia (Federated States of)",
    "region": "Oceania",
    "sub-region": "Micronesia"
  },
  "md": {
    "name": "Moldova (Republic of)",
    "region": "Europe",
    "sub-region": "Eastern Europe"
  },
  "mc": {
    "name": "Monaco",
    "region": "Europe",
    "sub-region": "Western Europe"
  },
  "mn": {
    "name": "Mongolia",
    "region": "Asia",
    "sub-region": "Eastern Asia"
  },
  "me": {
    "name": "Montenegro",
    "region": "Europe",
    "sub-region": "Southern Europe"
  },
  "ms": {
    "name": "Montserrat",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "ma": {
    "name": "Morocco",
    "region": "Africa",
    "sub-region": "Northern Africa"
  },
  "mz": {
    "name": "Mozambique",
    "region": "Africa",
    "sub-region": "Eastern Africa"
  },
  "mm": {
    "name": "Myanmar",
    "region": "Asia",
    "sub-region": "South-Eastern Asia"
  },
  "na": {
    "name": "Namibia",
    "region": "Africa",
    "sub-region": "Southern Africa"
  },
  "nr": {
    "name": "Nauru",
    "region": "Oceania",
    "sub-region": "Micronesia"
  },
  "np": {
    "name": "Nepal",
    "region": "Asia",
    "sub-region": "Southern Asia"
  },
  "nl": {
    "name": "Netherlands",
    "region": "Europe",
    "sub-region": "Western Europe"
  },
  "nc": {
    "name": "New Caledonia",
    "region": "Oceania",
    "sub-region": "Melanesia"
  },
  "nz": {
    "name": "New Zealand",
    "region": "Oceania",
    "sub-region": "Australia and New Zealand"
  },
  "ni": {
    "name": "Nicaragua",
    "region": "Americas",
    "sub-region": "Central America"
  },
  "ne": {
    "name": "Niger",
    "region": "Africa",
    "sub-region": "Western Africa"
  },
  "ng": {
    "name": "Nigeria",
    "region": "Africa",
    "sub-region": "Western Africa"
  },
  "nf": {
    "name": "Norfolk Island",
    "region": "Oceania",
    "sub-region": "Australia and New Zealand"
  },
  "mp": {
    "name": "Northern Mariana Islands",
    "region": "Oceania",
    "sub-region": "Micronesia"
  },
  "no": {
    "name": "Norway",
    "region": "Europe",
    "sub-region": "Northern Europe"
  },
  "om": {
    "name": "Oman",
    "region": "Asia",
    "sub-region": "Western Asia"
  },
  "pk": {
    "name": "Pakistan",
    "region": "Asia",
    "sub-region": "Southern Asia"
  },
  "pw": {
    "name": "Palau",
    "region": "Oceania",
    "sub-region": "Micronesia"
  },
  "ps": {
    "name": "Palestine, State of",
    "region": "Asia",
    "sub-region": "Western Asia"
  },
  "pa": {
    "name": "Panama",
    "region": "Americas",
    "sub-region": "Central America"
  },
  "pg": {
    "name": "Papua New Guinea",
    "region": "Oceania",
    "sub-region": "Melanesia"
  },
  "py": {
    "name": "Paraguay",
    "region": "Americas",
    "sub-region": "South America"
  },
  "pe": {
    "name": "Peru",
    "region": "Americas",
    "sub-region": "South America"
  },
  "ph": {
    "name": "Philippines",
    "region": "Asia",
    "sub-region": "South-Eastern Asia"
  },
  "pl": {
    "name": "Poland",
    "region": "Europe",
    "sub-region": "Eastern Europe"
  },
  "pt": {
    "name": "Portugal",
    "region": "Europe",
    "sub-region": "Southern Europe"
  },
  "pr": {
    "name": "Puerto Rico",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "qa": {
    "name": "Qatar",
    "region": "Asia",
    "sub-region": "Western Asia"
  },
  "re": {
    "name": "Réunion",
    "region": "Africa",
    "sub-region": "Eastern Africa"
  },
  "ro": {
    "name": "Romania",
    "region": "Europe",
    "sub-region": "Eastern Europe"
  },
  "ru": {
    "name": "Russian Federation",
    "region": "Europe",
    "sub-region": "Eastern Europe"
  },
  "rw": {
    "name": "Rwanda",
    "region": "Africa",
    "sub-region": "Eastern Africa"
  },
  "bl": {
    "name": "Saint Barthélemy",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "sh": {
    "name": "Saint Helena, Ascension and Tristan da Cunha",
    "region": "Africa",
    "sub-region": "Western Africa"
  },
  "kn": {
    "name": "Saint Kitts and Nevis",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "lc": {
    "name": "Saint Lucia",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "mf": {
    "name": "Saint Martin (French part)",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "pm": {
    "name": "Saint Pierre and Miquelon",
    "region": "Americas",
    "sub-region": "Northern America"
  },
  "vc": {
    "name": "Saint Vincent and the Grenadines",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "ws": {
    "name": "Samoa",
    "region": "Oceania",
    "sub-region": "Polynesia"
  },
  "sm": {
    "name": "San Marino",
    "region": "Europe",
    "sub-region": "Southern Europe"
  },
  "st": {
    "name": "Sao Tome and Principe",
    "region": "Africa",
    "sub-region": "Middle Africa"
  },
  "sa": {
    "name": "Saudi Arabia",
    "region": "Asia",
    "sub-region": "Western Asia"
  },
  "sn": {
    "name": "Senegal",
    "region": "Africa",
    "sub-region": "Western Africa"
  },
  "rs": {
    "name": "Serbia",
    "region": "Europe",
    "sub-region": "Southern Europe"
  },
  "sc": {
    "name": "Seychelles",
    "region": "Africa",
    "sub-region": "Eastern Africa"
  },
  "sl": {
    "name": "Sierra Leone",
    "region": "Africa",
    "sub-region": "Western Africa"
  },
  "sg": {
    "name": "Singapore",
    "region": "Asia",
    "sub-region": "South-Eastern Asia"
  },
  "sx": {
    "name": "Sint Maarten (Dutch part)",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "sk": {
    "name": "Slovakia",
    "region": "Europe",
    "sub-region": "Eastern Europe"
  },
  "si": {
    "name": "Slovenia",
    "region": "Europe",
    "sub-region": "Southern Europe"
  },
  "sb": {
    "name": "Solomon Islands",
    "region": "Oceania",
    "sub-region": "Melanesia"
  },
  "so": {
    "name": "Somalia",
    "region": "Africa",
    "sub-region": "Eastern Africa"
  },
  "za": {
    "name": "South Africa",
    "region": "Africa",
    "sub-region": "Southern Africa"
  },
  "ss": {
    "name": "South Sudan",
    "region": "Africa",
    "sub-region": "Eastern Africa"
  },
  "es": {
    "name": "Spain",
    "region": "Europe",
    "sub-region": "Southern Europe"
  },
  "lk": {
    "name": "Sri Lanka",
    "region": "Asia",
    "sub-region": "Southern Asia"
  },
  "sd": {
    "name": "Sudan",
    "region": "Africa",
    "sub-region": "Northern Africa"
  },
  "sr": {
    "name": "Suriname",
    "region": "Americas",
    "sub-region": "South America"
  },
  "sj": {
    "name": "Svalbard and Jan Mayen",
    "region": "Europe",
    "sub-region": "Northern Europe"
  },
  "sz": {
    "name": "Swaziland",
    "region": "Africa",
    "sub-region": "Southern Africa"
  },
  "se": {
    "name": "Sweden",
    "region": "Europe",
    "sub-region": "Northern Europe"
  },
  "ch": {
    "name": "Switzerland",
    "region": "Europe",
    "sub-region": "Western Europe"
  },
  "sy": {
    "name": "Syrian Arab Republic",
    "region": "Asia",
    "sub-region": "Western Asia"
  },
  "tw": {
    "name": "Taiwan, Province of China",
    "region": "Asia",
    "sub-region": "Eastern Asia"
  },
  "tj": {
    "name": "Tajikistan",
    "region": "Asia",
    "sub-region": "Central Asia"
  },
  "tz": {
    "name": "Tanzania, United Republic of",
    "region": "Africa",
    "sub-region": "Eastern Africa"
  },
  "th": {
    "name": "Thailand",
    "region": "Asia",
    "sub-region": "South-Eastern Asia"
  },
  "tl": {
    "name": "Timor-Leste",
    "region": "Asia",
    "sub-region": "South-Eastern Asia"
  },
  "tg": {
    "name": "Togo",
    "region": "Africa",
    "sub-region": "Western Africa"
  },
  "to": {
    "name": "Tonga",
    "region": "Oceania",
    "sub-region": "Polynesia"
  },
  "tt": {
    "name": "Trinidad and Tobago",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "tn": {
    "name": "Tunisia",
    "region": "Africa",
    "sub-region": "Northern Africa"
  },
  "tr": {
    "name": "Turkey",
    "region": "Asia",
    "sub-region": "Western Asia"
  },
  "tm": {
    "name": "Turkmenistan",
    "region": "Asia",
    "sub-region": "Central Asia"
  },
  "tc": {
    "name": "Turks and Caicos Islands",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "tv": {
    "name": "Tuvalu",
    "region": "Oceania",
    "sub-region": "Polynesia"
  },
  "ug": {
    "name": "Uganda",
    "region": "Africa",
    "sub-region": "Eastern Africa"
  },
  "ua": {
    "name": "Ukraine",
    "region": "Europe",
    "sub-region": "Eastern Europe"
  },
  "ae": {
    "name": "United Arab Emirates",
    "region": "Asia",
    "sub-region": "Western Asia"
  },
  "gb": {
    "name": "United Kingdom of Great Britain and Northern Ireland",
    "region": "Europe",
    "sub-region": "Northern Europe"
  },
  "us": {
    "name": "United States of America",
    "region": "Americas",
    "sub-region": "Northern America"
  },
  "uy": {
    "name": "Uruguay",
    "region": "Americas",
    "sub-region": "South America"
  },
  "uz": {
    "name": "Uzbekistan",
    "region": "Asia",
    "sub-region": "Central Asia"
  },
  "vu": {
    "name": "Vanuatu",
    "region": "Oceania",
    "sub-region": "Melanesia"
  },
  "ve": {
    "name": "Venezuela (Bolivarian Republic of)",
    "region": "Americas",
    "sub-region": "South America"
  },
  "vn": {
    "name": "Viet Nam",
    "region": "Asia",
    "sub-region": "South-Eastern Asia"
  },
  "vg": {
    "name": "Virgin Islands (British)",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "vi": {
    "name": "Virgin Islands (U.S.)",
    "region": "Americas",
    "sub-region": "Caribbean"
  },
  "eh": {
    "name": "Western Sahara",
    "region": "Africa",
    "sub-region": "Northern Africa"
  },
  "ye": {
    "name": "Yemen",
    "region": "Asia",
    "sub-region": "Western Asia"
  },
  "zm": {
    "name": "Zambia",
    "region": "Africa",
    "sub-region": "Eastern Africa"
  },
  "zw": {
    "name": "Zimbabwe",
    "region": "Africa",
    "sub-region": "Eastern Africa"
  },
  "xk": {
    "name": "Kosovo",
    "region": "Europe",
    "sub-region": "Eastern Europe"
  }
};
return countries[country_code][geo];
''';

WITH geo_summary AS (
  SELECT
    GET_GEO(country_code, 'region') AS region,
    IF(device = 'desktop', 'desktop', 'mobile') AS client,
    origin,
    COUNT(DISTINCT origin) OVER (PARTITION BY GET_GEO(country_code, 'region'), IF(device = 'desktop', 'desktop', 'mobile')) AS total
  FROM
    `chrome-ux-report.materialized.country_summary`
  WHERE
    # We're intentionally using May 2021 CrUX data here.
    # That's because there's a two month lag between CrUX and HA datasets.
    # Since we're only JOINing with the CrUX dataset to see which URLs
    # belong to different countries (as opposed to CWV field data)
    # it's not necessary to look at the 202107 dataset.
    yyyymm = 202105
)

SELECT
  *
FROM (
  SELECT
    app,
    client,
    region,
    COUNT(DISTINCT url) AS origins,
    COUNT(0) AS pages,
    ANY_VALUE(total) AS total,
    COUNT(0) / ANY_VALUE(total) AS pct
  FROM (
    SELECT DISTINCT
      region,
      client,
      total,
      CONCAT(origin, '/') AS url
    FROM
      geo_summary
  ) JOIN (
    SELECT DISTINCT
      _TABLE_SUFFIX AS client,
      app,
      url
    FROM
      `httparchive.technologies.2021_07_01_*`
    WHERE
      LOWER(category) = 'static site generator' OR
      app = 'Next.js' OR
      app = 'Nuxt.js'
  ) USING (client, url)
  GROUP BY
    app,
    client,
    region
  ORDER BY
    origins DESC
)
