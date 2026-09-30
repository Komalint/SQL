SELECT
    COALESCE(
        rm.material_id,
        srm.material_id
    ) AS unified_material_identifier,

    rm.material_name,

    rm.reorder_level AS main_reorder_level,

    srm.reorder_level AS staging_reorder_level,

    CASE
        WHEN rm.material_id IS NOT NULL
             AND srm.material_id IS NOT NULL
             AND rm.reorder_level = srm.reorder_level
            THEN 'SYNCED'

        WHEN rm.material_id IS NOT NULL
             AND srm.material_id IS NOT NULL
             AND rm.reorder_level <> srm.reorder_level
            THEN 'MISMATCH'

        WHEN rm.material_id IS NOT NULL
             AND srm.material_id IS NULL
            THEN 'MISSING IN STAGING'

        WHEN rm.material_id IS NULL
             AND srm.material_id IS NOT NULL
            THEN 'NEW IN STAGING'
    END AS reconciliation_status

FROM hra.raw_materials AS rm

FULL OUTER JOIN hra.stg_raw_materials AS srm
    ON rm.material_id = srm.material_id;