CREATE TABLE `rakaminkfanalytic.kimia_farma.transaction_data` AS
SELECT
    t.transaction_id,
    t.date,
    t.branch_id,
    kc.branch_name,
    kc.kota,
    kc.provinsi,
    kc.rating AS rating_cabang,
    t.customer_name,
    t.product_id,
    p.product_name,
    p.product_category,
    p.price AS actual_price,
    t.discount_percentage,
    CASE
        WHEN t.price <= 50000 THEN 0.10
        WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15
        WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20
        WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25
        WHEN t.price > 500000 THEN 0.30
    END AS persentase_gross_laba,
    t.price AS nett_sales,
    t.price * (
        CASE
            WHEN t.price <= 50000 THEN 0.10
            WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15
            WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20
            WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25
            WHEN t.price > 500000 THEN 0.30
        END
    ) AS nett_profit,
    t.rating AS rating_transaksi
FROM
    `rakaminkfanalytic.kimia_farma.kf_final_transaction` t
LEFT JOIN
    `rakaminkfanalytic.kimia_farma.kf_kantor_cabang` kc ON t.branch_id = kc.branch_id
LEFT JOIN
    `rakaminkfanalytic.kimia_farma.kf_product` p ON t.product_id = p.product_id;
