# Data Quality

- 541,909交易明細

- 4,372位客戶

- 38個國家

- 5,268筆重複資料

- 9,288筆取消交易

- 10,624筆負數數量

- 2筆負價格

- 2,515筆零價格

- CustomerID缺失25%

---
###
# 目前已知 資料品質問題
| 項目 | 結果 | 是否需要處理 |
|---|---|---|
|Description 空值 | 1454 | 是
|CustomerID 空值 | 135080 | 是
|重複資料 | 5268 | 是
|Quantity<0 | 10624 | 是
|UnitPrice<0 | 2 | 是
|UnitPrice=0 | 2515 | 是
|取消訂單 | 9288 | 是


---
###
# 找出 UnitPrice=0 共同特徵
UnitPrice = 0 共 2,515 筆。

其中： 
- Description 空值：1,454 筆，約 57.8%
- CustomerID 空值：2,475 筆，約 98.4%
- Quantity > 0：1,179 筆，約 46.9%
- Quantity < 0：1,336 筆，約 53.1%

## 第一個發現
前面整份 541,909 筆資料的 Description 缺失數也是：
`1,454 筆`

而現在 UnitPrice = 0 裡面的 Description 缺失：
`也是 1,454 筆`

換句話說：
- 整份資料所有 Description 缺失紀錄，都集中在 UnitPrice = 0 的資料裡。

這就不是一個隨機的空值現象了。

## 第二個發現
### 2,515 筆零價格紀錄中有 2,475 筆沒有 CustomerID。

也就是大約 98% 沒有客戶資料。

- 如果是正常的顧客購買，只是公司送贈品，我們至少會期待其中一部分能關聯到顧客。但這批資料幾乎都沒有。

- 這讓「這些可能不是正常顧客銷售紀錄」的可能性提高了。

但注意，目前仍然是資料上的證據支持這個懷疑，不是已經證明原因。

## 第三個發現
前幾名 Description 是:
```
check; ?; damages; damaged; found;sold as set on dotcom;adjustment; Damaged;thrown away; Unsaleable, destroyed.;amazon; Found
```
- 其中有些文字看起來不像正常商品名稱，反而比較像某種營運或庫存處理紀錄。
- 有些文字又像正常商品名稱。

因此，不是 "UnitPrice = 0 → 全部都是垃圾資料 → 全刪。"


---
###
# 確認 Quantity < 0 = 取消交易?
```
Quantity < 0
    True = 9288
    False = 1336
```

## 第一群
### 9288
```
Quantity < 0
AND
InvoiceNo = Cxxxx
```
- 可以直接定義：取消交易


## 第二群
### 1366
```
Quantity < 0
AND
InvoiceNo 非 C
```
- 查核 UnitPrice = 0, 屬於非正常銷售交易紀錄
- 猜測: 可能是庫存調整/可能是報廢/可能是損壞品

---

# Duplicate Records

- 偵測到 5,268 筆後續重複紀錄
- 涉及 10,147 筆資料
- 部分紀錄重複次數達 6、8、12、20 次
- 目前無法確認為系統重複匯入或合法交易紀錄

因此：
    暫不移除重複資料，
    保留於後續分析資料集中。