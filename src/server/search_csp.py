csp = {
    'default-src': '\'self\'',
    'style-src': [
        '\'self\'',
        '\'unsafe-inline\'',
        'cse.google.com',
        'www.google.com'
    ],
    'script-src': [
        '\'self\'',
        '\'strict-dynamic\'',
        'www.google-analytics.com',
        'www.googletagmanager.com',
        'cse.google.com',
        '\'unsafe-inline\'',
        '\'unsafe-eval\''
    ],
    'font-src': [
        '\'self\''
    ],
    'connect-src': [
        '\'self\'',
        'www.google-analytics.com',
        'www.googletagmanager.com'
    ],
    'img-src': [
        '\'self\'',
        'www.google-analytics.com',
        'www.googletagmanager.com',
        'www.googleapis.com',
        '*.google.com',
        '*.gstatic.com',
        'ssl.gstatic.com',
        'data:'
    ],
    'frame-src': [
        '\'self\'',
        'cse.google.com'
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
