# Emergency-Healthcare-Safe-Path

## 4.1 EMOC資料探索
EMOC為[高雄市緊急醫療資訊整合中心](http://emoc.org.tw/emoc/index.php)。

詳細分析:[R Markdown](https://github.com/nightheronry/Emergency-Healthcare-Safe-Path/blob/master/4.1_Exploratory%20Data/EMOC_example_chisquare.html)

## 4.7.1 急診轉診地圖
藉由[R Shiny](https://shiny.rstudio.com/)框架將高雄市104~107年間，醫院間的急診轉診人數以地圖方式呈現。
![104~107高雄市醫院間急診轉診人數地圖](https://raw.githubusercontent.com/nightheronry/Emergency-Healthcare-Safe-Path/master/4.7_Emergency%20referral%20pathways%20analysis/img/map.PNG)

## 4.7.2 急診轉診網絡分析
使用[Gephi](https://gephi.org/)，計算各醫院間的Indegree、Outdegree、Clustering coefficient、HITS等等指標，藉此觀察醫院間轉診的型態。
![104~107高雄市醫院間急診轉診網絡圖](https://raw.githubusercontent.com/nightheronry/Emergency-Healthcare-Safe-Path/master/4.7_Emergency%20referral%20pathways%20analysis/img/network.PNG)
