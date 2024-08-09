-- drop table msr_fin;
CREATE TABLE ob_result (
  dogovor_id Int32,
  nachisl Nullable(Decimal(15, 2)),
  pogash_oplatoy Nullable(Decimal(15, 2)),
  pogash_iz_kred Nullable(Decimal(15, 2)),
  opl_kred_perepl Nullable(Decimal(15, 2)),
  opl_kred_avans Nullable(Decimal(15, 2)),
  dolg_deb_nach Nullable(Decimal(15, 2)),
  dolg_kred_nach Nullable(Decimal(15, 2)),
  dolg_deb_kon Nullable(Decimal(15, 2)),
  dolg_kred_kon Nullable(Decimal(15, 2))
) ENGINE = MergeTree()
ORDER BY (dogovor_id);
