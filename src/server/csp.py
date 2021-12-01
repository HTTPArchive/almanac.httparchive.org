csp = {
    'default-src': '\'self\'',
    'style-src': [
        '\'self\''
    ],
    'script-src': [
        '\'self\'',
        '\'strict-dynamic\'',
        'www.google-analytics.com',
        'www.googletagmanager.com',
        '\'unsafe-inline\''
    ],
    'font-src': [
        '\'self\''
    ],
    'connect-src': [
        '\'self\'',
        'webmention.io',
        'discuss.httparchive.org',
        'www.google-analytics.com',
        'www.googletagmanager.com'
    ],
    'img-src': [
        '\'self\'',
        'https:',
        'data:'
    ],
    'frame-src': [
        '\'self\'',
        'docs.google.com',
        'www.youtube.com'
    ],
    'object-src': [
        '\'self\''
    ],
    'base-uri': [
        '\'none\''
    ],
    'report-uri': [
        'https://httparchive.report-uri.com/r/d/csp/enforce'
    ],
    'report-to': [
        'https://httparchive.report-uri.com/r/d/csp/enforce'
    ]
}
