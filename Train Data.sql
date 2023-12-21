

WITH 
train AS (
    
  SELECT
    dem.*,
    IFNULL(beh.cnt_user_engagement, 0) AS cnt_user_engagement,
    IFNULL(beh.cnt_page_view, 0) AS cnt_page_view,
    IFNULL(beh.cnt_first_visit, 0) AS cnt_first_visit,
    IFNULL(beh.cnt_session_start, 0) AS cnt_session_start,
    IFNULL(beh.cnt_file_download, 0) AS cnt_file_download,
    IFNULL(beh.cnt_form_submission, 0) AS cnt_form_submission,
    IFNULL(beh.cnt_brochure_views, 0) AS cnt_brochure_views,
    IFNULL(beh.cnt_time_30_sec, 0) AS cnt_time_30_sec,
    IFNULL(beh.cnt_click, 0) AS cnt_click,

    ret.user_first_engagement,
    ret.month,
    ret.julianday,
    ret.dayofweek,
    ret.churned
  FROM
    `GA4_ML.returning_user` ret
  LEFT OUTER JOIN
    `GA4_ML.user_demographics` dem
  ON 
    ret.user_pseudo_id = dem.user_pseudo_id
  LEFT OUTER JOIN 
    `GA4_ML.user_aggregate_behavior` beh
  ON
    ret.user_pseudo_id = beh.user_pseudo_id
  WHERE ret.bounced = 0
  )

SELECT
  *
FROM
  train
