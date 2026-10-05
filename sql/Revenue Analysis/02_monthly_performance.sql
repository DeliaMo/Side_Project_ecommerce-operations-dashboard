-- 
    月趨勢層:
        Monthly Revenue
        Monthly Orders
        Monthly Active Customers
        Monthly AOV
        Month-over-Month Growth，MoM(月增率=（本月營收－上月營收）÷ 上月營收 × 100%)
-- 

-- 先彙總，再計算月增長率
with monthly_sales as (
    select 
        DATE_FORMAT(invoice_date, '%Y-%m') AS sales_month,
        ROUND(SUM(quantity * unit_price),2) AS monthly_revenue, -- 分析期間內的總營收
        COUNT(DISTINCT invoice_no) AS monthly_orders, -- 分析期間內的不重複訂單數
        COUNT(DISTINCT customer_id) as monthly_active_customers, -- 分析期間內可識別的不重複客戶數，不包含 'NULL'
        SUM(quantity) as monthly_units_sold -- 分析期間內的總銷售數量
    FROM sales
    GROUP BY sales_month
),
monthly_comparison as (
    select *,
        LAG(monthly_revenue) OVER (ORDER BY sales_month) AS previous_month_revenue -- 取得前一個月的營收，用於計算月增長率
    FROM monthly_sales
)
select 
    sales_month,
    monthly_revenue,
    monthly_orders,
    monthly_active_customers,
    monthly_units_sold,
    ROUND(monthly_revenue / NULLIF(monthly_orders, 0), 2) AS monthly_aov, -- 月平均客單價
--     ROUND(previous_month_revenue, 2) AS previous_month_revenue, -- 前一個月的營收
    ROUND((monthly_revenue - previous_month_revenue) / NULLIF(previous_month_revenue, 0) * 100, 2) AS mom_growth_percentage -- 月增長率
FROM monthly_comparison
ORDER BY sales_month;