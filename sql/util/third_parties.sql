--In general we want to avoid "SELECT *" but we'll make an exception here so disable rile L044
SELECT -- noqa: L044
  DATE('2020-08-01') AS date,
  *
FROM
 `lighthouse-infrastructure.third_party_web.2020_08_01`
