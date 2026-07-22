/* MERCHANT RFM SEGMENTATION MODEL */
-- Business Value: Segments merchants into tiers to drive targeted PhonePe cashback or retention campaigns.

WITH Merchant_RFM AS (
    SELECT 
        merchant_id,
        MAX(txn_timestamp) AS last_transaction_date,                 -- Recency
        COUNT(txn_id) AS total_transactions,                         -- Frequency
        SUM(txn_amount) AS total_processing_volume                   -- Monetary Value
    FROM transactions
    WHERE txn_status = 'SUCCESS'
    GROUP BY merchant_id
)
SELECT 
    merchant_id,
    total_transactions,
    total_processing_volume,
    -- Apply Business Logic for Segmentation
    CASE 
        WHEN total_transactions > 5000 AND total_processing_volume > 1000000 THEN 'Tier 1 - Enterprise (High Value)'
        WHEN total_transactions > 1000 AND total_processing_volume > 250000 THEN 'Tier 2 - Mid-Market (Growing)'
        WHEN DATEDIFF(DAY, last_transaction_date, GETDATE()) > 60 THEN 'Tier 4 - Churn Risk (Inactive)'
        ELSE 'Tier 3 - Long Tail (Standard)'
    END AS merchant_segment
FROM Merchant_RFM
ORDER BY total_processing_volume DESC;
