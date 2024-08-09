CREATE TABLE dim_date (
  `date` DateTime,
  `month` Nullable(Int32),
  `year` Nullable(Int32)
) ENGINE = MergeTree()
ORDER BY date;