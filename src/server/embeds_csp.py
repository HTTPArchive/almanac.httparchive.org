csp = {
    "default-src": ["'self'"],
    "style-src": ["'self'", "'unsafe-inline'", "www.gstatic.com"],
    "script-src": [
        "'self'",
        "'strict-dynamic'",
        "*.google-analytics.com",
        "www.googletagmanager.com",
        "'unsafe-inline'",
    ],
    "font-src": ["'self'"],
    "connect-src": [
        "'self'",
        "webmention.io",
        "discuss.httparchive.org",
        "*.google-analytics.com",
        "www.googletagmanager.com",
    ],
    "img-src": ["'self'", "https:", "data:"],
    "frame-src": [
        "'self'",
        "docs.google.com",
        "www.youtube.com",
        "www.googletagmanager.com",
    ],
    "object-src": ["'self'"],
    "base-uri": ["'none'"],
}
