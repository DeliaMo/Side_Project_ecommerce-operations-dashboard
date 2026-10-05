-- 
  KPI 層：
    Total Revenue
    Total Orders
    Total Customers
    Units Sold
    Average Order Value (AOV)
    Average Units per Order
-- 

SELECT 
	ROUND(SUM(quantity * unit_price),2) AS total_revenue, -- 分析期間內的總營收
  COUNT(DISTINCT invoice_no) AS total_orders, -- 分析期間內的不重複訂單數
  COUNT(DISTINCT customer_id) as total_customer, -- 分析期間內可識別的不重複客戶數，不包含 NULL
  SUM(quantity) as total_Units_Sold, -- 分析期間內的總銷售數量
  ROUND(SUM(quantity * unit_price) / count(DISTINCT invoice_no), 2) AS average_order_value, -- 分析期間內的平均客單價
  MIN(invoice_date) as start_date,
  MAX(invoice_date) as end_date
FROM sales;