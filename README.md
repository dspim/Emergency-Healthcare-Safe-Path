# Emergency-Healthcare-Safe-Path

## 4.1 EMOC資料探索  

*Contributor: [Yu-Lien Shih](@yulienshih)*

EMOC為[高雄市緊急醫療資訊整合中心](http://emoc.org.tw/emoc/index.php)。

詳細分析:[R Markdown](https://nightheronry.github.io/Emergency-Healthcare-Safe-Path/4.1_Exploratory%20Data/EMOC_example_chisquare.html)

## 4.3 急診轉診Sankey Diagram

*Contributor: [Xniper](@lwkuant)*

### 此部分為醫院指標分析程式碼，主要分析內容為：

-入院方式 → 急救責任分級 → 轉診型態

-入院方式 → 急救責任分級 → 轉院原因 → 轉診型態

詳細分析:[R Markdown](https://nightheronry.github.io/Emergency-Healthcare-Safe-Path/4.3__Emergency%20referral%20Sankey%20Diagram/Sankey_v2.nb.html)

## 4.7.1 急診轉診地圖

*Contributor: [Daniel Hsu](@nightheronry)*

藉由[R Shiny](https://shiny.rstudio.com/)框架將高雄市104~107年間，醫院間的急診轉診人數以地圖方式呈現。
![104~107高雄市醫院間急診轉診人數地圖](https://nightheronry.github.io/Emergency-Healthcare-Safe-Path/4.7_Emergency%20referral%20pathways%20analysis/img/map.PNG)

## 4.7.2 急診轉診網絡分析
使用[Gephi](https://gephi.org/)，計算各醫院間的Indegree、Outdegree、Clustering coefficient、HITS等等指標，藉此觀察醫院間轉診的型態。
![104~107高雄市醫院間急診轉診網絡圖](https://nightheronry.github.io/Emergency-Healthcare-Safe-Path/4.7_Emergency%20referral%20pathways%20analysis/img/network.PNG)

## EDA

### 此部分為醫院指標分析程式碼，主要分析內容為：

*Contributor: [tony50207](@tony50207)*

-各醫院指標分布圖及box-plot

詳細分析:[R Markdown](https://nightheronry.github.io/Emergency-Healthcare-Safe-Path/EDA/EMOC-EDA/EMOC-EDA.html)

-依醫院分級的醫院指標分布圖

詳細分析:[R Markdown](https://nightheronry.github.io/Emergency-Healthcare-Safe-Path/EDA/Hospital%20Indicators-EDA/Hospital%20Indicators-EDA.html)


