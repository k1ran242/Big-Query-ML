
WITH user_aggregate_behavior AS (
WITH
  events_first24hr AS (
    #select user data only from first 24 hr of using the app
    SELECT
      e.*
    FROM
      `dubaiproperties.analytics_299439497.events_*` e
    JOIN
      `GA4_ML.returning_user` r
    ON
      e.user_pseudo_id = r.user_pseudo_id
    WHERE
      e.event_timestamp <= r.ts_24hr_after_first_engagement
    )
SELECT
  user_pseudo_id,
  SUM(IF(event_name = 'user_engagement', 1, 0)) AS cnt_user_engagement,
  SUM(IF(event_name = 'Page_view', 1, 0)) AS cnt_page_view,
  SUM(IF(event_name = 'session_start', 1, 0)) AS cnt_session_start,
  SUM(IF(event_name = 'first_visit', 1, 0)) AS cnt_first_visit,
  SUM(IF(event_name = 'file_download', 1, 0)) AS cnt_file_download,
  SUM(IF(event_name = 'form_submission', 1, 0)) AS cnt_form_submission,
  SUM(IF(event_name = 'brochure_views', 1, 0)) AS cnt_brochure_views,
  SUM(IF(event_name = 'time_30_sec', 1, 0)) AS cnt_time_30_sec,
  SUM(IF(event_name = 'click', 1, 0)) AS cnt_click,

FROM
  events_first24hr
GROUP BY
  1
  )

SELECT
  *
FROM
  user_aggregate_behavior
