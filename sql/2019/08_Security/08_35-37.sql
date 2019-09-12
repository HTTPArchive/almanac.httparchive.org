
#standardSQL
# 08_35-37: Groupings of availably parsed values by percentage by client
#   Mostly dynamic, but then removed all of the disinct values at "=" unless 
#     samesite rule is involved
#    
# 
#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#       0 rows available some far
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB
# 

SELECT
  client, 
  SUM(COUNT(0)) OVER (PARTITION BY client) AS client_tot,
  trim(substr(lower(policy), 1, 
      case 
        when 
          (strpos(lower(policy), 'samesite=strict') > 1 
            or strpos(lower(policy),'samesite=lax') > 0 
            or strpos(lower(policy),'samesite=none') > 1
          ) then length(policy) 
        when strpos(policy,'=') > 1 
            then strpos(lower(policy),'=')-1 
        else length(policy) 
        end
        )) substr_policy,
  COUNT(0) AS freq,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM
  `httparchive.almanac.summary_response_bodies`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(respOtherHeaders),r'set-cookie = ([^,\r\n]+)')) AS value,
  UNNEST(SPLIT(value, ';')) AS policy
WHERE
  firstHtml
GROUP BY
  client, substr_policy
ORDER BY
  client, freq DESC
