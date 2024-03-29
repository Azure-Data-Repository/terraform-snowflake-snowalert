SELECT day
    , COUNT(DISTINCT SUBSTR(exc, 0, 50)) AS num_distinct_exceptions
    , SUM(IFF(exc IS NOT NULL, 1, 0)) AS num_errors
FROM (
    SELECT slice_start::DATE AS day
    FROM TABLE(${data_time_slices_before_t_without_time}(30, 60*60*24))
) d
RIGHT OUTER JOIN (
    SELECT v:START_TIME::DATE AS day
        , v:ERROR.EXCEPTION_ONLY AS exc
    FROM ${ingestion_metadata_table}
) e
USING (day)
GROUP BY day
ORDER BY day DESC
