

<p align="center">
<img src=https://nightheronry.github.io/Emergency-Healthcare-Safe-Path/cover.png>
 <br><br>
</p>
緊急醫療的處理首重於「適當時間將適當病人送至適當醫院」處置原則。
然而，當病人醫療需求與提供之醫療資源無法在第一次就醫就媒合成功時，或可能會觸發院際轉診的行為。
轉診行為有利有弊，或許可能讓病人得到更適切的醫療照護，但轉診過程所伴隨的潛在的風險，也應被仔細考慮。就整體社會安全網的系統觀點而言，轉診的浮現，在某種程度上也反應出緊急醫療過程中可能存在的照護缺口。若能釐清這問題，也許能讓我們對優化社區醫療配置與建構安全照護網絡有更明確的補強藍圖。

### 觀看[完整報告](http://d4sg.org/emergency-medical-optimization/)

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

## 4.2 轉診原因分析

原始資料轉院原因為「其他」者,佔了25%。「其他」一欄的補充說明,是可以一言以蔽之的
具體形容,也可能是故事性敘述的概念。我們透過文字探索方式,歸納原始資料中轉院原因為
「其他」的敘述性描述,可以發現許多筆資料可被歸類至各類別中,如:ICU、滿床、病房這
些字眼敘述的是醫院空間量能不足,無法再容納新的急診病患。而「醫師」一詞,在敘述中具
有顯著角色,如本院無XX科醫師,或XX科醫師建議等等,都會出現醫師一詞,但實務上卻可
能代表不同意義。這類詞彙出現頻率,我們以文字雲方式呈現於[轉院原因文字分析圖]。某些
頻繁出現的文字,也暗示未來進行智慧化語意分析的重點。

![轉院原因文字分析圖](https://github.com/nightheronry/Emergency-Healthcare-Safe-Path/blob/master/4.2_Reasons%20for%20Referral/img/wordcloud.png)

詳細分析:[R Markdown](https://github.com/nightheronry/Emergency-Healthcare-Safe-Path/blob/master/4.2_Reasons%20for%20Referral/Reasons%20for%20Referral.html)

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
