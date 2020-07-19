#standardSQL
# Core Web Vitals by device

SELECT 
device,

# using adjusted values where fast+avg+slow add up to 1 (100%) for each row/metric group

# Core Web Vitals indicate 75% good for all metrics is a pass
ROUND(COUNTIF( fast_lcp_adjusted  > 0.75 AND fast_fid_adjusted  > 0.75 AND small_cls_adjusted  > 0.75) * 100 / COUNT(0), 2) AS corewebvitals_pass_pct,
# pass based on each metric
ROUND(COUNTIF( fast_lcp_adjusted  > 0.75) * 100 / COUNT(0), 2) AS corewebvitals_pass_pct_lcp,
ROUND(COUNTIF( fast_fid_adjusted  > 0.75) * 100 / COUNT(0), 2) AS corewebvitals_pass_pct_fid,
ROUND(COUNTIF( small_cls_adjusted  > 0.75) * 100 / COUNT(0), 2) AS corewebvitals_pass_pct_cls,

# work out the grouped percents
ROUND(AVG( fast_lcp_adjusted) * 100, 2) AS fast_lcp_pct,
ROUND(AVG( avg_lcp_adjusted) * 100, 2) AS avg_lcp_pct,
ROUND(AVG( slow_lcp_adjusted) * 100, 2) AS slow_lcp_pct,

ROUND(AVG( fast_fid_adjusted) * 100, 2) AS fast_fid_pct,
ROUND(AVG( avg_fid_adjusted) * 100, 2) AS avg_fid_pct,
ROUND(AVG( slow_fid_adjusted) * 100, 2) AS slow_fid_pct,

ROUND(AVG( small_cls_adjusted) * 100, 2) AS small_cls_pct,
ROUND(AVG( medium_cls_adjusted) * 100, 2) AS medium_cls_pct,
ROUND(AVG( large_cls_adjusted) * 100, 2) AS large_cls_pct,

ROUND(AVG( fast_ttfb_adjusted) * 100, 2) AS fast_ttfb_pct,
ROUND(AVG( avg_ttfb_adjusted) * 100, 2) AS avg_ttfb_pct,
ROUND(AVG( slow_ttfb_adjusted) * 100, 2) AS slow_ttfb_pct,

ROUND(AVG( fast_fcp_adjusted) * 100, 2) AS fast_fcp_pct,
ROUND(AVG( avg_fcp_adjusted) * 100, 2) AS avg_fcp_pct,
ROUND(AVG( slow_fcp_adjusted) * 100, 2) AS slow_fcp_pct,

# from 2019 07_05b - Older metrics for speed scores
ROUND(COUNTIF(fast_fcp_adjusted >= .9 AND fast_fid_adjusted >= .95) * 100 / COUNT(0), 2) AS pct_fast,
ROUND(COUNTIF(NOT(slow_fcp_adjusted >= .1 OR slow_fid_adjusted >= 0.05) AND NOT(fast_fcp_adjusted >= .9 AND fast_fid_adjusted >= .95)) * 100 / COUNT(0), 2) AS pct_avg,
ROUND(COUNTIF(slow_fcp_adjusted >= .1 OR slow_fid_adjusted >= 0.05) * 100 / COUNT(0), 2) AS pct_slow

FROM (
    # fix percents so a rows fast+avg+slow total 1 
    # needed when origins are split into multiple rows like device and country, all rows for an origin add up to 1. This changes it so each row adds up to 1
    SELECT 
        device, 

        # re work out percentage for each row
        SAFE_DIVIDE(fast_lcp, fast_lcp+avg_lcp+slow_lcp) AS fast_lcp_adjusted,
        SAFE_DIVIDE(avg_lcp, fast_lcp+avg_lcp+slow_lcp) AS avg_lcp_adjusted,
        SAFE_DIVIDE(slow_lcp, fast_lcp+avg_lcp+slow_lcp) AS slow_lcp_adjusted, 

        SAFE_DIVIDE(fast_fid, fast_fid+avg_fid+slow_fid) AS fast_fid_adjusted,
        SAFE_DIVIDE(avg_fid, fast_fid+avg_fid+slow_fid) AS avg_fid_adjusted,
        SAFE_DIVIDE(slow_fid, fast_fid+avg_fid+slow_fid) AS slow_fid_adjusted, 

        SAFE_DIVIDE(small_cls, small_cls+medium_cls+large_cls) AS small_cls_adjusted,
        SAFE_DIVIDE(medium_cls, small_cls+medium_cls+large_cls) AS medium_cls_adjusted,
        SAFE_DIVIDE(large_cls, small_cls+medium_cls+large_cls) AS large_cls_adjusted,

        SAFE_DIVIDE(fast_ttfb, fast_ttfb+avg_ttfb+slow_ttfb) AS fast_ttfb_adjusted,
        SAFE_DIVIDE(avg_ttfb, fast_ttfb+avg_ttfb+slow_ttfb) AS avg_ttfb_adjusted,
        SAFE_DIVIDE(slow_ttfb, fast_ttfb+avg_ttfb+slow_ttfb) AS slow_ttfb_adjusted,

        SAFE_DIVIDE(fast_fcp, fast_fcp+avg_fcp+slow_fcp) AS fast_fcp_adjusted,
        SAFE_DIVIDE(avg_fcp, fast_fcp+avg_fcp+slow_fcp) AS avg_fcp_adjusted,
        SAFE_DIVIDE(slow_fcp, fast_fcp+avg_fcp+slow_fcp) AS slow_fcp_adjusted

    FROM `chrome-ux-report.materialized.device_summary` 
    WHERE yyyymm = 202006 # can determine latest month via latest entry in chrome-ux-report
    # AND fast_fid + avg_fid + slow_fid > 0  # from 2019 07_05b - I presume to exclude when no data is available. not sure is needed as we use SAFE_DIVIDE and AVG ignores nulls
    # AND device IN ('desktop', 'phone') # from 2019 07_05b - excluding tablet ?
)
GROUP BY device;
