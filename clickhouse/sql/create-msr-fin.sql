-- drop table msr_fin;

CREATE TABLE msr_fin (
  dogovor_id Int32,
  vid_real_id Int32,
  data Nullable(DateTime),
  dok_nach_id Nullable(Int32),
  opl_id Nullable(Int32),
  akt_s DateTime,
  akt_po DateTime,
  nachisl Nullable(Decimal(15,2)),
  pogash_oplatoy_bez_avansa Nullable(Decimal(15,2)),
  pogash_oplatoy_avans Nullable(Decimal(15,2)),
  pogash_iz_perepl Nullable(Decimal(15,2)),
  pogash_iz_avansa Nullable(Decimal(15,2)),
  pogash_oplatoy Nullable(Decimal(15,2)),
  pogash_iz_kred Nullable(Decimal(15,2)),
  pogash Nullable(Decimal(15,2)),
  pogash_bez_avansa Nullable(Decimal(15,2)),
  opl_kred_perepl Nullable(Decimal(15,2)),
  opl_kred_avans Nullable(Decimal(15,2)),
  storno_kred_perepl Nullable(Decimal(15,2)),
  obor_kred Nullable(Decimal(15,2)),
  opl_kred Nullable(Decimal(15,2)),
  storno_kred Nullable(Decimal(15,2)),
  dolg Nullable(Decimal(15,2)),
  dolg_kred Nullable(Decimal(15,2)),
  dolg_deb Nullable(Decimal(15,2))
) ENGINE = MergeTree()
ORDER BY (dogovor_id, vid_real_id, akt_s, akt_po);