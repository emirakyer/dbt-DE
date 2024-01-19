WITH general_table AS (
  -- Gerekli işlemleri yaparak raw veriyi düzenle
  SELECT
    vendorid,
    passenger_count
  FROM
    dbt_lrn.greentripexe
)

SELECT
  *
FROM
  general_table