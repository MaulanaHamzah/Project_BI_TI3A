USE superstore_dw;

-- Query 1: Total Penjualan Keseluruhan
SELECT 
    SUM(sales) AS total_sales,
    COUNT(*) AS total_transactions
FROM fact_sales;

-- Query 2: Top 5 Produk Terlaris (berdasarkan jumlah penjualan)
SELECT 
    p.product_name,
    p.category,
    COUNT(f.fact_id) AS total_transactions,
    SUM(f.sales) AS total_sales
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_sales DESC
LIMIT 5;

-- Query 3: Penjualan per Kategori Produk
SELECT 
    p.category,
    COUNT(f.fact_id) AS total_transactions,
    SUM(f.sales) AS total_sales,
    AVG(f.sales) AS avg_sales
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

-- Query 4: Penjualan per Segment Pelanggan
SELECT 
    c.segment,
    COUNT(f.fact_id) AS total_transactions,
    SUM(f.sales) AS total_sales
FROM fact_sales f
JOIN dim_customer c ON f.customer_id = c.customer_id
GROUP BY c.segment
ORDER BY total_sales DESC;

-- Query 5: Penjualan per Region
SELECT 
    c.region,
    COUNT(f.fact_id) AS total_transactions,
    SUM(f.sales) AS total_sales
FROM fact_sales f
JOIN dim_customer c ON f.customer_id = c.customer_id
GROUP BY c.region
ORDER BY total_sales DESC;

-- Query 6: Penjualan per Bulan
SELECT 
    d.year,
    d.month,
    d.month_name,
    COUNT(f.fact_id) AS total_transactions,
    SUM(f.sales) AS total_sales
FROM fact_sales f
JOIN dim_date d ON f.date_id = d.date_id
GROUP BY d.year, d.month, d.month_name
ORDER BY d.year, d.month;

-- Query 7: Penjualan per Quarter
SELECT 
    d.year,
    d.quarter,
    COUNT(f.fact_id) AS total_transactions,
    SUM(f.sales) AS total_sales
FROM fact_sales f
JOIN dim_date d ON f.date_id = d.date_id
GROUP BY d.year, d.quarter
ORDER BY d.year, d.quarter;

-- Query 8: Top 5 Customer dengan Pembelian Terbanyak
SELECT 
    c.customer_name,
    c.segment,
    c.region,
    COUNT(f.fact_id) AS total_transactions,
    SUM(f.sales) AS total_sales
FROM fact_sales f
JOIN dim_customer c ON f.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name, c.segment, c.region
ORDER BY total_sales DESC
LIMIT 5;