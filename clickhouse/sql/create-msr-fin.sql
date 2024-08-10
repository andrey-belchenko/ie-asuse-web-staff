-- drop table msr_fin;
CREATE TABLE msr_fin (
    dogovor_id Int32,
    vid_real_id Int32,
    data Nullable(DateTime),
    dok_nach_id Nullable(Int32),
    opl_id Nullable(Int32),
    akt_s DateTime,
    akt_po DateTime,
    nachisl Nullable(Decimal(25, 6)),
    pogash_oplatoy_bez_avansa Nullable(Decimal(25, 6)),
    pogash_oplatoy_avans Nullable(Decimal(25, 6)),
    pogash_iz_perepl Nullable(Decimal(25, 6)),
    pogash_iz_avansa Nullable(Decimal(25, 6)),
    pogash_oplatoy Nullable(Decimal(25, 6)),
    pogash_iz_kred Nullable(Decimal(25, 6)),
    pogash Nullable(Decimal(25, 6)),
    pogash_bez_avansa Nullable(Decimal(25, 6)),
    opl_kred_perepl Nullable(Decimal(25, 6)),
    opl_kred_avans Nullable(Decimal(25, 6)),
    storno_kred_perepl Nullable(Decimal(25, 6)),
    obor_kred Nullable(Decimal(25, 6)),
    opl_kred Nullable(Decimal(25, 6)),
    storno_kred Nullable(Decimal(25, 6)),
    dolg Nullable(Decimal(25, 6)),
    dolg_kred Nullable(Decimal(25, 6)),
    dolg_deb Nullable(Decimal(25, 6))
) ENGINE = MergeTree()
ORDER BY (akt_s, akt_po, dogovor_id, vid_real_id);


ALTER TABLE msr_fin
ADD INDEX udx_msr_fin_akt (akt_s,akt_po) TYPE minmax GRANULARITY 1;