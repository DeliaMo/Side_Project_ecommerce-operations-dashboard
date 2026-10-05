# Data Dictionary

## Dataset

- Source: UCI Online Retail
- Worksheet: Online Retail
- Raw rows: 541,909
- Period: 2010-12-01 08:26:00 to 2011-12-09 12:50:00

## Fields

| Field | Description | Expected Type | Notes |
|---|---|---|---|
| InvoiceNo | 發票／交易編號 | String | C 開頭代表取消交易 |
| StockCode | 商品編號 | String | 不應視為數字運算 |
| Description | 商品名稱 | String | 需檢查空值與名稱一致性 |
| Quantity | 商品數量 | Integer | 負值可能與取消或退貨有關 |
| InvoiceDate | 交易日期時間 | Datetime | 用於年月日與時段分析 |
| UnitPrice | 商品單價 | Decimal | 需檢查零值與負值 |
| CustomerID | 客戶編號 | String | 缺失資料不能用於顧客分析 |
| Country | 客戶所在國家 | String | 用於市場及地區分析 |