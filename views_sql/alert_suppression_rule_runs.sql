SELECT V:RUN_ID::VARCHAR AS run_id
    , V:QUERY_NAME::VARCHAR AS rule_name
    , V:START_TIME::TIMESTAMP AS start_time
    , V:END_TIME::TIMESTAMP AS end_time
    , V:ROW_COUNT.SUPPRESSED::INTEGER AS num_alerts_suppressed
    , V:ERROR AS error
FROM ${results_query_metadata}
WHERE V:QUERY_NAME ILIKE '%_ALERT_SUPPRESSION'
