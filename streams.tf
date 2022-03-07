# CREATE STREAM IF NOT EXISTS results.raw_alerts_stream
# ON TABLE results.raw_alerts
# ;
resource "snowflake_stream" "raw_alerts_stream" {
  provider = snowflake.alerting_role

  database = snowflake_database.snowalert.name
  schema   = snowflake_schema.rules.name
  name     = "raw_alerts_stream"

  on_table = join(".", [
    snowflake_database.snowalert.name,
    snowflake_schema.results.name,
    snowflake_table.raw_alerts.name,
  ])
  comment = "A stream to track the diffs on raw_alerts table."
}
