csp = {
    'default-src': '\'self\'',
    'style-src': [
        '\'self\'',
        '\'unsafe-inline\'',
        'fonts.googleapis.com'
    ],
    'script-src': [
        '\'self\'',
        'cdn.ampproject.org',
        'www.google-analytics.com',
        'www.googletagmanager.com'
    ],
    'font-src': [
        '\'self\'',
        'fonts.gstatic.com'
    ],
    'connect-src': [
        '\'self\'',
        'discuss.httparchive.org',
        'www.google-analytics.com',
        'www.googletagmanager.com',
        'cdn.ampproject.org'
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
    'frame-ancestors': [
        '*'
    ],
    'object-src': [
        '\'none\''
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
