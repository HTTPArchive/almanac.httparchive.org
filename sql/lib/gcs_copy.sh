#!/bin/bash
# Copy each lib script to Google Cloud Storage (GCS).
# Files are available at gs://httparchive/lib/*.js
# And via HTTPS at https://cdn.httparchive.org/lib/*.js (with caching)

gsutil cp sql/lib/*.js gs://httparchive/lib
