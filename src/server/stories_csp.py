csp = {
    "default-src": ["'self'"],
    "style-src": ["'self'", "'unsafe-inline'", "fonts.googleapis.com"],
    "script-src": [
        "'self'",
        "cdn.ampproject.org",
        "*.google-analytics.com",
        "www.googletagmanager.com",
    ],
    "font-src": ["'self'", "fonts.gstatic.com"],
    "connect-src": [
        "'self'",
        "discuss.httparchive.org",
        "*.google-analytics.com",
        "www.googletagmanager.com",
        "cdn.ampproject.org",
    ],
    "img-src": ["'self'", "https:", "data:"],
    "frame-src": [
        "'self'",
        "docs.google.com",
        "www.youtube.com",
        "www.googletagmanager.com"
    ],
    "frame-ancestors": ["*"],
    "object-src": ["'none'"],
    "base-uri": ["'none'"],
}
