SELECT ext, COUNT (ext) AS cnt
FROM summary_requests.2021_07_01_desktop
WHERE mimetype LIKE "%video%"
GROUP BY ext
ORDER BY cnt DESC