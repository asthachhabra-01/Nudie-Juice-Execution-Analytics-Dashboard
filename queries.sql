-- ============================================================
-- Nudie Juice – In-Store Execution Analytics
-- SQL Queries | Written in Metabase
-- ============================================================
-- Queries are filtered using Metabase template variables
-- (e.g. {{State}}, {{Store}}) allowing dynamic dashboard
-- filtering by state, store, or execution type.
-- ============================================================


-- ------------------------------------------------------------
-- Query 1: Penetration Across Zones
-- Purpose: Compares Nudie Juice penetration rates across Main
-- Beverage Fridge and Off Location zones, showing store count
-- and percentage of total stores per penetration category.
-- Excludes closed stores from the count.
-- ------------------------------------------------------------

WITH table1 AS (

    SELECT
        "nudie_penetration_in_main_fridge"  AS "Penetration",
        'Main Beverage Fridge Penetration'  AS "KPI",
        COUNT(*) OVER ()                    AS "Total Stores"
    FROM Nudie___Fridge_Compliance_Check_at_IGA
    WHERE {{State}}
        AND {{Code}}
        AND {{Store}}
        AND {{Exec}}
        AND "nudie_penetration_in_main_fridge" <> 'Store Closed'

    UNION ALL

    SELECT
        "display_penetration"       AS "Penetration",
        'Off Location Penetration'  AS "KPI",
        COUNT(*) OVER ()            AS "Total Stores"
    FROM Nudie___Fridge_Compliance_Check_at_IGA
    WHERE {{State}}
        AND {{Code}}
        AND {{Store}}
        AND {{Exec}}
        AND "display_penetration" <> 'Store Closed'
)

SELECT
    "Penetration",
    "KPI",
    COUNT(*)                         AS "Store Count",
    COUNT(*) * 1.00 / "Total Stores" AS "% of Stores"
FROM table1
GROUP BY "Penetration", "KPI", "Total Stores"
ORDER BY
    CASE WHEN "KPI" = 'Main Beverage Fridge Penetration' THEN 1 ELSE 2 END;


-- ------------------------------------------------------------
-- Query 2: Types of Nudie Juice Executions Across Zones
-- Purpose: Identifies execution types present across Main
-- Beverage Fridge and Off Location zones, showing percentage
-- of stores carrying each execution type. Uses UNNEST to
-- expand array-type execution fields into individual rows.
-- Excludes stores with no Nudie presence and closed stores.
-- ------------------------------------------------------------

WITH table1 AS (

    SELECT
        "main_beverage_fridge__execution_type"  AS "SKUs",
        COUNT(*) OVER ()                        AS "Total Stores"
    FROM Nudie___Fridge_Compliance_Check_at_IGA
    WHERE {{State}}
        AND {{Code}}
        AND {{Store}}
        AND {{Exec}}
        AND "main_beverage_fridge__execution_type" <> '{"No Nudie in Main Beverage Fridge"}'
        AND "nudie_penetration_in_main_fridge"     <> 'Store Closed'

    UNION ALL

    SELECT
        "display_type"      AS "SKUs",
        COUNT(*) OVER ()    AS "Total Stores"
    FROM Nudie___Fridge_Compliance_Check_at_IGA
    WHERE {{State}}
        AND {{TradeRep}}
        AND {{Code}}
        AND {{Store}}
        AND {{Exec}}
        AND "display_type"        <> '{"N/A – No display"}'
        AND "display_penetration" <> 'Store Closed'
),

table2 AS (
    SELECT
        UNNEST("SKUs")  AS "SKU",
        "Total Stores",
        COUNT(*)        AS "Store Count"
    FROM table1
    GROUP BY "SKU", "Total Stores"
)

SELECT
    "SKU",
    "Store Count" * 1.00 / "Total Stores" AS "% of Stores",
    "Store Count"
FROM table2
ORDER BY "% of Stores" DESC;


-- ------------------------------------------------------------
-- Query 3: SKU Availability Across Zones
-- Purpose: Measures individual SKU availability across Main
-- Beverages Fridge and Off Location zones, showing store count
-- and percentage of total stores per SKU per zone. Uses UNNEST
-- to expand array-type SKU fields into individual rows.
-- Excludes unranged, unavailable and closed stores.
-- ------------------------------------------------------------

WITH table1 AS (

    SELECT
        UNNEST("sku_availability__main_fridge")  AS "KPI",
        'Main Beverages Fridge'                  AS "Zone",
        COUNT(*) OVER ()                         AS "Total Stores"
    FROM Nudie___Fridge_Compliance_Check_at_IGA
    WHERE {{State}}
        AND {{Code}}
        AND {{Store}}
        AND {{Exec}}
        AND "sku_availability__main_fridge"    <> '{"Not ranged"}'
        AND "sku_availability__main_fridge"    <> '{"None available"}'
        AND "nudie_penetration_in_main_fridge" <> 'Store Closed'

    UNION ALL

    SELECT
        UNNEST("sku_assortment__off_locations")  AS "KPI",
        'Off Location'                           AS "Zone",
        COUNT(*) OVER ()                         AS "Total Stores"
    FROM Nudie___Fridge_Compliance_Check_at_IGA
    WHERE {{State}}
        AND {{Code}}
        AND {{Store}}
        AND {{Exec}}
        AND "sku_assortment__off_locations" <> '{"Not ranged"}'
        AND "display_penetration"           <> 'Store Closed'
)

SELECT
    "KPI",
    "Zone",
    COUNT(*)                         AS "Store Count",
    COUNT(*) * 1.00 / "Total Stores" AS "% of Stores"
FROM table1
GROUP BY "KPI", "Zone", "Total Stores"
ORDER BY
    CASE WHEN "Zone" = 'Main Beverages Fridge' THEN 1 ELSE 2 END;
