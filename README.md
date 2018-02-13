# Emergency-Healthcare-Safe-Path
![](https://nightheronry.github.io/Emergency-Healthcare-Safe-Path/cover.png)
## 4.1 EMOC資料探索  

*Contributor: [Yu-Lien Shih](https://github.com/yulienshih)*

EMOC為[高雄市緊急醫療資訊整合中心](http://emoc.org.tw/emoc/index.php)。
此部分為二次轉診與單次轉診之比較分析

EMOC_data為整理後表格，內容包含：

轉出、轉入醫院的基本資料 | 病患基本資料
------------ | -------------
醫院代號 | 年齡
急救責任醫院等級 | 性別
健保特約醫院等級 | 診斷
 醫院地址 | 檢傷級數
經緯度 |

使用[tableone](https://github.com/kaz-yos/tableone)套件，資料排除離群值醫院後，以卡方檢定比較二次轉診與單次轉診之族群差異

-資料處理

二次轉診定義為：入院方式為「他院轉入」
檢傷級數_新：以檢傷等級1-2為「1-2級」，3-5為「3-5級」
卡方檢定後之結果為

檢傷級數、轉出醫院急救責任等級、急診留置時間（分鐘）、轉診型態均有顯著差異
二次轉診的患者於轉院後急診留置時間較單次轉診者平均需多花費3小時

詳細分析:[R Markdown](https://nightheronry.github.io/Emergency-Healthcare-Safe-Path/4.1_Exploratory%20Data/EMOC_example_chisquare.html)

## 4.3 急診轉診Sankey Diagram

*Contributor: [Xniper](https://github.com/lwkuant)*

### 此部分為醫院指標分析程式碼，主要分析內容為：

-入院方式 → 急救責任分級 → 轉診型態

![sankey1](https://nightheronry.github.io/Emergency-Healthcare-Safe-Path/4.3__Emergency%20referral%20Sankey%20Diagram/img/sankey1.png)

-入院方式 → 急救責任分級 → 轉院原因 → 轉診型態

![sankey2](https://nightheronry.github.io/Emergency-Healthcare-Safe-Path/4.3__Emergency%20referral%20Sankey%20Diagram/img/sankey2.png)

詳細分析:[R Markdown](https://nightheronry.github.io/Emergency-Healthcare-Safe-Path/4.3__Emergency%20referral%20Sankey%20Diagram/Sankey_v2.nb.html)

## 4.7.1 急診轉診地圖

*Contributor: [Daniel Hsu](https://github.com/nightheronry)*

藉由[R Shiny](https://shiny.rstudio.com/)框架將高雄市104~107年間，醫院間的急診轉診人數以地圖方式呈現。
![104~107高雄市醫院間急診轉診人數地圖](https://nightheronry.github.io/Emergency-Healthcare-Safe-Path/4.7_Emergency%20referral%20pathways%20analysis/img/map.PNG)

## 4.7.2 急診轉診網絡分析

使用[Gephi](https://gephi.org/)，計算各醫院間的Indegree、Outdegree、Clustering coefficient、HITS等等指標，藉此觀察醫院間轉診的型態。
![104~107高雄市醫院間急診轉診網絡圖](https://nightheronry.github.io/Emergency-Healthcare-Safe-Path/4.7_Emergency%20referral%20pathways%20analysis/img/network.PNG)

## EMOC資料（轉診人數）、醫院指標

*Contributor: [tony50207](https://github.com/tony50207)*

#### EMOC資料（轉診人數）EDA

-轉診人數疊層直條圖

![轉診人數疊層直條圖](https://nightheronry.github.io/Emergency-Healthcare-Safe-Path/EDA/img/stacked_bar_chart.png)

-轉診人數折線圖

![轉診人數折線圖](https://nightheronry.github.io/Emergency-Healthcare-Safe-Path/EDA/img/line_chart.png)

詳細分析:[R Markdown](https://nightheronry.github.io/Emergency-Healthcare-Safe-Path/EDA/EMOC-EDA/EMOC-EDA.html)

#### 醫院指標EDA

-各醫院指標box-plot

![box-plot](https://nightheronry.github.io/Emergency-Healthcare-Safe-Path/EDA/img/box_plot.png)

詳細分析:[R Markdown](https://nightheronry.github.io/Emergency-Healthcare-Safe-Path/EDA/Hospital%20Indicators-EDA/Hospital%20Indicators-EDA.html)
