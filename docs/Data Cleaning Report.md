# Data Cleaning Rule
## Rule 1：Cancellation Transactions

條件:
 - InvoiceNo 開頭 C

處理方式：
 - 視為取消交易（Cancellation）
 - 不納入正常銷售分析
 - 保留供取消／退貨分析使用

---

## Rule 2：Non-Sales Transactions

條件:
 - UnitPrice <= 0
 - 屬於非銷售性質之調整紀錄

觀察結果：
 - 包含 Adjust bad debt、damaged、thrown away、adjustment、check 等紀錄
 - 多數缺少 CustomerID 或 Description

處理方式:
 - 原始資料仍保留
 - 不納入正常銷售營收分析

---

## Rule 3：Duplicate Records

條件：
 - 全欄位完全相同

觀察結果：
 - 共 5,268 筆後續重複紀錄
 - 部分紀錄重複次數高達 6、8、12、20 次
 - InvoiceDate、CustomerID、InvoiceNo 等關鍵欄位均完全一致

判斷：
 - 高度疑似資料重複匯入或重複記錄

處理方式：
 - 移除重複紀錄
 - 保留第一筆