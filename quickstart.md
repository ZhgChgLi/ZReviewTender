---
title: "Quick Start! Github Action x ZReviewTender 免費快速部署你的 App 商城評價監控機器人"
author: "ZhgChgLi"
date: 2024-09-26T20:42:21.606+0800
last_modified_at: 2024-09-26T20:42:21.606+0800
categories: "ZRealm Dev."
tags: ["ios-app-development","app-review","app-store","google-play","android"]
description: "簡單三步驟為您建立免費穩定安全的 App 評價機器人，即時關注使用者的最新評價。"
image:
  path: /assets/0095528cf875/1*k8RswW3es9L19jIgbRDLpQ.png
---

### \[Quick Start\! \] Github Action x ZReviewTender 免費快速部署你的 App 商城評價監控機器人

簡單三步驟為您建立免費穩定安全的 App 評價機器人，即時關注使用者的最新評價。



![[ZReviewTender](https://github.com/ZhgChgLi/ZReviewTender)](assets/0095528cf875/1*k8RswW3es9L19jIgbRDLpQ.png)

[ZReviewTender](https://github.com/ZhgChgLi/ZReviewTender)
### [ZReviewTender](https://github.com/ZhgChgLi/ZReviewTender)


[![](https://repository-images.githubusercontent.com/516425682/1cc1a829-d87d-4d4a-925b-60471b912b23)](https://github.com/ZhgChgLi/ZReviewTender)


ZReviewTender — 是我在 2022/08 製作開源的 App 商城評價機器人，功能是會自動撈取 iOS App Store, Android Google Play 商城上的 App 使用者評價並轉發到指定的 Slack Channel。

另外可以指定評價撈取規則、串接 Google 翻譯、Asana、Google Sheet，也支援自訂義客製化操作。
### [Github Action](https://docs.github.com/en/actions)

Github Action 是由 Github 提供的 CI/CD 自動化集成工具，我們可以使用自己的機器做為伺服器 \(Github Runner\)亦或是直接使用 Github 提供的機器執行 CI/CD、自動化腳本。
#### 費用及限制
- 使用自己的機器 \(Github Runner\):
[無特別費用，只有最高執行數、並行上限、部分 API 短期最大請求數量限制。](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/about-self-hosted-runners#usage-limits)
- [使用 Github 提供的機器:](https://docs.github.com/en/billing/managing-billing-for-github-actions/about-billing-for-github-actions#included-storage-and-minutes)



![](assets/0095528cf875/1*QyhxZ98B20NV18-W5vKJDg.png)


GitHub Free 提供基本 500 MB Storage \(for CI/CD Artifact\)、2,000 Minutes 一個月執行分鐘數。

[**這邊要注意的是因為機器成本問題：**](https://docs.github.com/en/billing/managing-billing-for-github-actions/about-billing-for-github-actions#minute-multipliers)
- 如果使用 Github 的 Windows 機器，消耗的分鐘數等於實際分鐘數 x 2
- 如果使用 Github 的 macOS 機器，消耗的分鐘數等於實際分鐘數 x 10


詳細計價計算請參考 [官方價格計算器](https://github.com/pricing/calculator?feature=actions) 。


> [**_ZReviewTender_**](https://github.com/ZhgChgLi/ZReviewTender) **_Minutes per month 消耗：約 120 分鐘_** 
 

> _只需要跑在基礎計價的 Linux 上，每次執行約消耗 ≤ 1 分鐘，預設每 6 小時執行一次，一天花費 4 分鐘，一個月約消耗 120 分鐘，免費額度就很足夠了。_ 





> [**_ZReviewTender_**](https://github.com/ZhgChgLi/ZReviewTender) **_Storage 消耗：0_** 
 

> _無使用 Artifact 儲存資料，因此沒有 Storage 的開銷。_ 




### [Slack](https://slack.com/)

公司使用的內部通訊軟體，會建立一個 Slack App 並透過這個 Slack App 身份轉發 App 商城評價通知到指定的頻道。


![](assets/0095528cf875/1*HMMyU5jwY9iAMyiKmNgVJQ.png)

### [ZReviewTender](https://github.com/ZhgChgLi/ZReviewTender) x [Github Action](https://docs.github.com/en/actions) x [Slack](https://slack.com/)


> _我們使用 Github Action 來執行 ZReviewTender 腳本轉發結果到 Slack，Github Repo\(Action\) 只是當載體使用，因此就算您的主專案不使用 Github 託管，依然可以簡單照以下步驟完成 ZReviewTender 部署。🎉🎉🎉_ 





> **_我已經成功部署在 5 個不同公司的不同 Apps 並穩定、免費執行了至少 2 年以上。_** 




#### 優點：
- **免費** ： [ZReviewTender](https://github.com/ZhgChgLi/ZReviewTender) 是我製作的開源免費服務、部署在 [Github Action](https://docs.github.com/en/actions) 使用免費額度綽綽有餘。 
您不需要在每個月花錢買 App Review Bot 之類的月費評價機器人服務。
- **安全** ：撈取評價用的憑證、金鑰均安全存放在你的 Github Private Repo，除了你之外沒有人有權限存取。
您不需要再冒著洩漏風險把重要的憑證、金鑰上傳給第三方服務使用； [ZReviewTender](https://github.com/ZhgChgLi/ZReviewTender) 為開源專案，一切操作經的起大眾檢視。
- **可靠** ： [ZReviewTender](https://github.com/ZhgChgLi/ZReviewTender) 使用官方最新提供的 API 撈取評價資訊，相較以往其他服務使用 RSS 撈取評價，更準確、穩定可靠。

#### Buy me coffee ❤️❤️❤️


![[https://www\.buymeacoffee\.com/zhgchgli](https://www.buymeacoffee.com/zhgchgli)](assets/0095528cf875/1*QCQqlZr6doDP-cszzpaSpw.png)

[https://www\.buymeacoffee\.com/zhgchgli](https://www.buymeacoffee.com/zhgchgli)


> [**_如果這個專案有幫助到您，歡迎贊助我一杯咖啡，謝謝。_**](https://www.buymeacoffee.com/zhgchgli) 




### Quick Start\!🚀


> **_整個設定步驟約需 30 分鐘，但只需設定一次，除非憑證金鑰有更換，不然可以永久免費穩定的運作。_** 🚀🚀🚀🚀🚀 




#### Step 1\. 建立 Slack App

如果您的組織內已有建立過有 `chat:write` 之類的發訊息權限 Slack App，可以直接復用，不用建立新的。

[**前往 Slack Apps 首頁：**](https://api.slack.com/apps)


![[https://api\.slack\.com/apps](https://api.slack.com/apps)](assets/0095528cf875/1*JDaxmORRL3ipdeA0ZaHW3w.png)

[https://api\.slack\.com/apps](https://api.slack.com/apps)

點擊右上角「Create New App」。


![](assets/0095528cf875/1*sFxmX9qty4UEgMhiTglEfA.png)



![](assets/0095528cf875/1*XiqfLoEmITHyF9E-rDPjPQ.png)

1. 選擇：From scratch
2. 輸入 App Name： `ZReviewTender` 或自定義 Slack App 名稱
3. 選擇目標安裝的 Slack Workspace：請確認你選擇的 Workspace，你有新增 Slack App 的權限。
4. Create App


**新增 OAuth & Permissions Scopes：** 
Slack app 建立完成後，先到「OAuth & Permissions」頁籤設定 Scopes。


![](assets/0095528cf875/1*VjXVtAkVN8PLtCAOHocAmA.png)



![](assets/0095528cf875/1*WSNd89bJuG1xCIPM9SsLnA.png)

1. 選擇「OAuth & Permissions」
2. 下滑找到 Scopes Section
3. 依序輸入新增 ZReviewTender Slack App 必備的三個 Scopes：

```vbnet
chat:write
chat:write.public
links:write
```

**Install App** 
回到 Install App 頁籤安裝 Slack App 到 Workspace。


![](assets/0095528cf875/1*qItvJK5tZ-i8vE5bNUZIKQ.png)



![](assets/0095528cf875/1*Eevu3Sir68DhfFSrFKb1xg.png)

1. 選擇「Install App」
2. 點擊「Install to _YOUR\_WORKSPACE_ 」
3. 點擊「Allow」



![](assets/0095528cf875/1*lj8KZ5bEOG9urPgtxet-YA.png)


安裝完成後回到 Install App 頁面就會出現 `Slack App Bot User OAuth Token` ，點擊「Copy」複製， **記下來，稍後設定使用** 。

**建立預收到評價通知的頻道：**


![](assets/0095528cf875/1*vwILile0Y52PgjQAYLqGjQ.png)



![](assets/0095528cf875/1*jZwuovjXaCbQiWTixOP5Dg.png)

- Sidebar \-\> Channels \-\> Create \-\> Create channel
- Name: 輸入想要的頻道名稱



![](assets/0095528cf875/1*cK8ihh9IQPacTjGKG4GS3Q.png)


**Visibility：**
- Public：對所有人公開，無需其他動作。
- **Private：私密頻道，** ⭐️⭐️⭐️ **需要把剛剛建立的 Slack App 加入：**


**Slack App 加入頻道方式：**


![](assets/0095528cf875/1*AgCjAYb94XOmlIJ7VV6gaw.png)



![](assets/0095528cf875/1*GVqrJlBg_9MjVyGitA2g-A.png)

1. 點擊上方 \#頻道名稱
2. 點擊「Settings」
3. 點擊「Add an App」



![](assets/0095528cf875/1*KU5hdi2m46TUwZbjI-xKmg.png)

1. 搜尋你剛建立的 Slack App 名稱
2. 點擊「Add」



![](assets/0095528cf875/1*Qx2XPK8lspCrSauWE4IhXA.png)


加入成功頻道會有提示字詞。 `ZReviewTender joined.`


> **_⭐️⭐️⭐️這邊有發現一個 Slack Bug，Slack App 剛建立完可能會搜尋不到，要等一陣子才會出現；可以先使用 Public Channel，Public Channel 不需要將 Slack App 加入就能使用。_** 





**取得 Channel ID:** 
最後一步，最重要的我們要取得 Channel ID 稍後設定要使用。


![](assets/0095528cf875/1*CmQtV9QibdOb8zHuiYJS2Q.png)



![](assets/0095528cf875/1*VNmLOs0mBhF6qisDzx6Zcw.png)

1. 點擊上方 \#頻道名稱
2. About 最下方有一個 Channed ID 資訊
3. **記下 `Channel ID` ，稍後設定使用**



> **_Slack 步驟完成。_** 





— — —

**其他補充：**

**你可以在「Basic Information」\-\>「Display Information」編輯 Slack App 名稱、icon：**


![](assets/0095528cf875/1*5THTrkeWXYa5QaGCNCmzhQ.png)


修改完成後記得點右下角「Save Changes」才會儲存。

**如果 OAuth & Permissions Scopes 有新增需要點擊「reinstall your app」重新安裝才會生效：**


![](assets/0095528cf875/1*pUdxf_G1uoHcq22VGjHOzw.png)

#### Step 2\. 產生 Apple App Store Connect API & Google Play Android Developer API 身份憑證
#### Apple App Store Connect API 身份憑證

**iOS 比較容易，我們只需要從 App Store Connect 得到以下四個資訊即可：**

**Issuer ID：**


![](assets/0095528cf875/0*eHn-LMnUlS-04d70.png)

- App Store Connect \-\> Keys \-\> [App Store Connect API](https://appstoreconnect.apple.com/access/api)
- **記下 `Issuer ID` ，稍後設定使用**


**Private Key ID & Private Key：**

點擊「\+」新增按鈕：


![](assets/0095528cf875/0*MI0-cA0BTkq5XqkT.png)

- Name: `ZReviewTender`
- Access: `App Manager`



![](assets/0095528cf875/0*V0U2HjKTRfL8dl1j.png)

- `Key ID` **，稍後設定使用**
- **點擊「Download API Key」保存下載下來的「 `AuthKey_XXXXXXXXXX.p8` 」檔案，稍後設定使用。**


**App ID : \(要撈取評價的目標 App ID\)**


![](assets/0095528cf875/1*zCgRRm0-nDwvcGOv26Aprw.png)


App ID 可以在 [App Store Connect](https://appstoreconnect.apple.com/apps) \-\> App Store \-\> General \-\> App Information \-\> `App ID` 找到。
- **記下 `App ID` ，稍後設定使用**

#### Google Play Android Developer API 身份憑證

Android 較為複雜，需要先從 App 專案所屬的 Google Cloud Project 啟用 API & 建立 Service Account \(服務帳戶\) & 將服務帳戶加入 Google Play Console 並賦予 App 權限。

[**前往 Google Cloud Project：**](https://console.cloud.google.com/welcome)

選擇 App 專案所屬的 Google Cloud Project 或建立一個新 Project。

**啟用「Android Developer API」：**


![](assets/0095528cf875/1*zvWFDBuPRq9a6bizjqrx4Q.png)



![](assets/0095528cf875/1*Z0g1ezVJBptHvRkd1VlF_Q.png)

1. 搜尋「Android Developer API」點擊進入
2. 選擇「啟用」


**\[此步驟可選\] 您也可以同時啟用「Cloud Translation API」：**


![](assets/0095528cf875/1*rL-t3VHvNONNWtUlboAllg.png)



![](assets/0095528cf875/1*9CItyqjGmG5LcMMDe-6NlQ.png)

- 啟用後可以使用同一個 Service Account \(服務帳戶\) 憑證，串接評價自動翻譯功能
- **請注意：Cloud Translation API 並非免費，偵測語言、翻譯都會產生費用！**
- **請注意：Cloud Translation API 並非免費，偵測語言、翻譯都會產生費用！**
- **請注意：Cloud Translation API 並非免費，偵測語言、翻譯都會產生費用！**


**建立 Service Account \(服務帳戶\)：**


![](assets/0095528cf875/1*_WZ_lwp1TjG5cRoI1rH_7g.png)

1. 搜尋「IAM」
2. 選擇「IAM & Admin」



![](assets/0095528cf875/1*-PBkhiBsqejz8PejVhSB3A.png)

1. 選擇「服務帳戶 \(Service Account\)」
2. 選擇「建立服務帳戶 \(Service Account\)」



![](assets/0095528cf875/1*_oU-8T-qv7pyuUBmX-U64w.png)

1. 服務帳戶名稱：自行輸入，可輸入「 `ZReviewTender` 」or「 `Google Play Review Bot` 」
2. 服務帳戶 ID：自動帶入，沒特殊需求不用變更，這同時也會是你的 Service Account Email
3. 點擊「完成」


**記下這組服務帳戶 Service Account 的信箱地址：**


![](assets/0095528cf875/1*gTNjATgSPZ4Z9zrJ2caYdw.png)

- 列表頁也會顯示 Service Account Email 地址
- **記下 `Service Account Email` ，稍後設定使用**


**建立服務帳號 Service Account 金鑰憑證：**


![](assets/0095528cf875/1*MDkammdsXQQbLYrQ_eGTxQ.png)



![](assets/0095528cf875/1*Ev2pRLcJv_UGKUWfDNsSPQ.png)

1. 重整列表頁面，點擊進入剛剛創建的 服務帳號 Service Account
2. 點擊「新增金鑰」
3. 點擊「建立新的金鑰」
4. 金鑰類型選擇「JSON」
5. 點擊「建立」
6. **保存下載下來的「 `XXXX-XXXX.json` 」檔案，稍後設定使用**


**將服務帳戶加入 Google Play Console 並賦予 要撈取評價的目標 App 權限：**

[**進入到 Google Play Console 後台：**](https://play.google.com/console/)


![](assets/0095528cf875/1*Lbowza_thZaSDx5BuRWMsg.png)

1. 點擊「Users and permissions」
2. 點擊右方「Invite new users」



![](assets/0095528cf875/1*vNreKooCJL4XiRv_XTsAYg.png)

1. Email address 輸入剛剛記下來的 `Service Account Email`
2. App permissions \-\> Add app
3. 加入 要撈取評價的目標 App
4. 點擊「Invite user」 即可完成邀請，無需驗證


**取得 Google Play Console Developer ID & App ID & Package Name 資訊：**


![](assets/0095528cf875/1*-eha5rTUbdzUwJfiJTakBA.png)

1. 點擊 要撈取評價的目標 App 進入 Dashboard
2. **記下 `Package Name` ，稍後設定使用**


複製 Dashboard 網址，從網址中找到：

3\.其中 /developers/ `XXX` **就是你的 `Developer ID` ，記下這串數字 Developer ID，稍後設定使用**

4\.其中 /app/ `XXX` **就是你的 `App ID` ，記下這串數字 App ID，稍後設定使用**


> **_身份憑證設定完成。_** 




#### Step 3\. Github Action 部署、設定檔填寫

令人振奮的事是，我已經將繁瑣的 Github Repo, Github Action 設定流程打包成 Repo Template & Marketplace Github Action，您只要照以下幾個步驟就可以完成工作。

**前往： [ZReviewTender\-deploy\-with\-github\-action](https://github.com/ZhgChgLi/ZReviewTender-deploy-with-github-action) ：**


![[https://github\.com/ZhgChgLi/ZReviewTender\-deploy\-with\-github\-action](https://github.com/ZhgChgLi/ZReviewTender-deploy-with-github-action)](assets/0095528cf875/1*LXuZQnLMsH-_ULX-DEiL9w.png)

[https://github\.com/ZhgChgLi/ZReviewTender\-deploy\-with\-github\-action](https://github.com/ZhgChgLi/ZReviewTender-deploy-with-github-action)


![](assets/0095528cf875/1*IfqkNXm7cOeyuYabUo3THQ.png)

- Repository name：輸入你想要的 Repo 名稱
- **Private** ：因 Repo 會存放存取金鑰， **務必設定為 Private Repo ⭐️⭐️⭐️**
- **Private** ：因 Repo 會存放存取金鑰， **務必設定為 Private Repo ⭐️⭐️⭐️**
- **Private** ：因 Repo 會存放存取金鑰， **務必設定為 Private Repo ⭐️⭐️⭐️**
- 點擊「Create repository」



> ZReviewTender 作者、貢獻者、ZhgChgLi 並不會因為您使用 ZReviewTender 造成的任何損失負責。 





**等待 Repository 建立：**


![](assets/0095528cf875/1*oudjjgmGnL1iFHeO-VJUiA.png)


**再次確認建立的是 Private Repo：**


![](assets/0095528cf875/1*MDFXKOWXvAeE3fcUUeRWWQ.png)

- **Private** ：因 Repo 會存放存取金鑰， **務必設定為 Private Repo ⭐️⭐️⭐️**
- **Private** ：因 Repo 會存放存取金鑰， **務必設定為 Private Repo ⭐️⭐️⭐️**
- **Private** ：因 Repo 會存放存取金鑰， **務必設定為 Private Repo ⭐️⭐️⭐️**


**啟用 Github Actions 權限：** 
Repo 建立完成後，因 Github 安全設定，要先去 Repo Settings 允許 Github Actions 執行。


![](assets/0095528cf875/1*VRYwO-rh8bjJQUoaDDa2rw.png)

1. Repo \-\> Settings
2. 選擇「Actions」 \-\> 「General」
3. Actions permissions 選擇「Allow all actions and reusable workflows」
4. 點擊「Save」
5. Workflow permissions 選擇「Read repository contents and packages permissions」


**首次執行，初始化 ZReviewTender：**


![](assets/0095528cf875/1*EME0aMziInPAZO5OQCSnMg.png)

1. Repo \-\> Actions
2. 選擇「Init ZReviewTender」
3. 選擇「Run workflow」
4. 點擊「Run workflow」
5. 重整頁面


**等待** `init ZReviewTender` **Action 完成：**


![](assets/0095528cf875/1*XxopQjcyvVPOWuGwC4czyA.png)



> _如果出現 ❌ Error：請重新檢查前面提到的 Github Actions 權限設定是否正確。_ 





**初始化成功回到 Repo 首頁會出現兩個新目錄：**


![](assets/0095528cf875/1*sr69yq6hw3y4PpeHuykc5w.png)


**上傳所需的憑證檔案：**


![](assets/0095528cf875/1*2pIncX5nVRPy2BkOOf2qxg.png)



![](assets/0095528cf875/1*hZ4j_Q6GAJOwWNMv-YYQIg.png)

1. 進入 `/config` 目錄
2. 右上角「Add file」\-\> 「Upload files」



![](assets/0095528cf875/1*QEAfsc0F_3sbRjGCbsTKpQ.png)

1. 將 Step 2\. 保存下來的 GCP Service Account `XXXX-XXXX.json` \(for Android\)與 App Store Connect 保存下來的 `AuthKey_XXXXXXXXXX.p8` \(for iOS\)一同上傳。
2. 等待上傳完成
3. 選擇「Commit directly to the main branch」
4. 點擊「Commit changes」


**設定 Apple \(iOS\)：**


![](assets/0095528cf875/1*2pIncX5nVRPy2BkOOf2qxg.png)



![](assets/0095528cf875/1*qiPzFqVQXQbMlbsRCQWiqw.png)

- 進入 `config/` 目錄，點擊 `apple.yml` 檔案



![](assets/0095528cf875/1*SscBDfN9_MbAu8TbxynCLw.png)

- 點擊右上角「🖊️編輯」


**編輯 `apple.yml` ，貼上以下內容並填入前幾步記下來的資訊：**
```yaml
platform: 'apple'
appStoreConnectP8PrivateKeyFilePath: './config/AuthKey_XXXXXXXXXX.p8' # APPLE STORE CONNECT API PRIVATE .p8 KEY File Path
appStoreConnectP8PrivateKeyID: 'Private Key ID' # APPLE STORE CONNECT API PRIVATE KEY ID
appStoreConnectIssueID: 'Issuer ID' # APPLE STORE CONNECT ISSUE ID
appID: 'App ID' # APP ID
processors:
    - SlackProcessor: # Slack Processor, resend App Review to Slack.
        class: "SlackProcessor"
        enable: true # enable
        slackTimeZoneOffset: "+08:00" # Review Created Date TimeZone
        slackAttachmentGroupByNumber: "1" # 1~100, how many review message in 1 slack message.
        slackBotToken: "Slack App Bot User OAuth Token" # Slack Bot Token, send slack message throught Slack Bot.
        slackBotTargetChannel: "Target Channel ID" # Slack Bot Token, send slack message throught Slack Bot. (recommended, first priority)
        slackInCommingWebHookURL: "" # Slack In-Comming WebHook URL, Send slack message throught In-Comming WebHook, not recommended, deprecated.
```
- `appStoreConnectP8PrivateKeyFilePath` : 
輸入 `./config/AuthKey_XXXXXXXXXX.p8` \(Step 2\. App Store Connect 保存下來的 `AuthKey_XXXXXXXXXX.p8` 檔案名稱\)
- `appStoreConnectP8PrivateKeyID` : Step 2\. App Store Connect 記下來的 `Private Key ID`
- `appStoreConnectIssueID` : Step 2\. App Store Connect 記下來的 `Issuer ID`
- `appID` : Step 2\. App Store Connect 記下來的目標撈取 App 的 `App ID`
- `slackBotToken` : 輸入 Step 1\. 記下的 `Slack App Bot User OAuth Token`
- `slackBotTargetChannel` : 輸入 Step 1\. 記下的 要傳送到的 `Channel ID`



![](assets/0095528cf875/1*REBLdx4NpXH3_itfSaZg3A.png)

1. 編輯完成後點擊右上角「Commit changes…」
2. 選擇「Commit directly to the main branch」
3. 點擊「Commit changes」


**設定 Android：**


![](assets/0095528cf875/1*2pIncX5nVRPy2BkOOf2qxg.png)



![](assets/0095528cf875/1*jaKIWwtLwhwT7uAc9WmT_g.png)

- 進入 `config/` 目錄，點擊 `android.yml` 檔案



![](assets/0095528cf875/1*mylh0XXOdbmgbBNHGxB54Q.png)

- 點擊右上角「🖊️編輯」


**編輯 `android.yml` ，貼上以下內容並填入前幾步記下來的資訊：**
```yaml
platform: 'android'
packageName: 'Package Name' # Android App Package Name
keyFilePath: './config/XXXX-XXXX.json' # Google Android Publisher API Service Account Credential .json File Path
playConsoleDeveloperAccountID: 'Developer ID' # Google Console Developer Account ID
playConsoleAppID: 'App ID' # Google Console App ID
processors:
- SlackProcessor: # Slack Processor, resend App Review to Slack.
        class: "SlackProcessor"
        enable: true # enable
        slackTimeZoneOffset: "+08:00" # Review Created Date TimeZone
        slackAttachmentGroupByNumber: "1" # 1~100, how many review message in 1 slack message.
        slackBotToken: "Slack App Bot User OAuth Token" # Slack Bot Token, send slack message throught Slack Bot.
        slackBotTargetChannel: "Target Channel ID" # Slack Bot Token, send slack message throught Slack Bot. (recommended, first priority)
        slackInCommingWebHookURL: "" # Slack In-Comming WebHook URL, Send slack message throught In-Comming WebHook, not recommended, deprecated.
```
- `packageName` : Step 2\. Google Play Console 後台記下來的 `Package Name`
- `keyFilePath` : 
輸入 `./config/XXXX-XXXX.json` \(Step 2\. GCP IAM 保存下來的 `XXXX-XXXX.json` Service Account 金鑰檔案名稱\)
- `playConsoleDeveloperAccountID` : Step 2\. Google Play Console 後台記下來的 `Developer ID`
- `playConsoleAppID` : Step 2\. Google Play Console 後台記下來的 `App ID`
- `slackBotToken` : 輸入 Step 1\. 記下的 `Slack App Bot User OAuth Token`
- `slackBotTargetChannel` : 輸入 Step 1\. 記下的 要傳送到的 `Channel ID`



![](assets/0095528cf875/1*SZAslED33ZYvx7a-uyGt_w.png)

1. 編輯完成後點擊右上角「Commit changes…」
2. 選擇「Commit directly to the main branch」
3. 點擊「Commit changes」



> **_設定完成！_** 🚀🚀🚀🚀 





**驗證設定是否成功：**

我們可以手動執行一次，確認設定無誤。


![](assets/0095528cf875/1*VsBvNpXeR9yoTsG61mZ--Q.png)

1. Repo \-\> Actions
2. 選擇「ZReviewTender」
3. 選擇「Run workflow」
4. 點擊「Run workflow」
5. 重整頁面


**等待** `ReviewTender` **Action 完成：**


![](assets/0095528cf875/1*VHCX5ppMzCUf-Fxvflo7OA.png)


**驗證成功🎉🎉🎉🎉**


![](assets/0095528cf875/1*hSETSIooRcYLH1YS5ssyxA.png)



> _如果出現 ❌ Error、Slack Channel 未收到啟動訊息：請重新檢查前面設定檔案內容是否正確。_ 




#### 完成 **🎉🎉🎉**


![](assets/0095528cf875/1*HMMyU5jwY9iAMyiKmNgVJQ.png)


現在你可以依靠這個免費可靠的 App 評價機器人時刻關注使用者的最新評價了！
#### Buy me coffee ❤️❤️❤️


![[https://www\.buymeacoffee\.com/zhgchgli](https://www.buymeacoffee.com/zhgchgli)](assets/0095528cf875/1*QCQqlZr6doDP-cszzpaSpw.png)

[https://www\.buymeacoffee\.com/zhgchgli](https://www.buymeacoffee.com/zhgchgli)


> [**_如果這個專案有幫助到您，歡迎贊助我一杯咖啡，謝謝。_**](https://www.buymeacoffee.com/zhgchgli) 




### 其他設定
#### 加上過濾功能

只轉發符合條件的評價。
```yaml
    - FilterProcessor:
        class: "FilterProcessor"
        enable: true # enable
        keywordsInclude: [] # keywords you want to filter out
        ratingsInclude: [] # ratings you want to filter out
        territoriesInclude: [] # territories you want to filter out (territory for Apple e.g. TWN)
```
- 您只要在 `/config/apple.yml` 或 `/config/android.yml` 的 `processors` 區塊加上 `FilterProcessor` 設定。

#### 加上自動翻譯功能

將非您語言的評價自動使用 Google Cloud Translation API 進行翻譯 \(需消耗費用\)。
- **請先確定 Step 2\. 建立的 Service Account 所屬 GCP Project 有啟用「Cloud Translation API」**
- `apple.yml` 與 `android.yml` 設定有一些不同


`apple.yml:`
```bash
    - GoogleTranslateProcessor: # Google Translate Processor, will translate review text to your language, you can remove whole block if you don't needed it.
        class: "GoogleTranslateProcessor"
        enable: true # enable
        googleTranslateAPIKeyFilePath: './config/XXXX-XXXX.json' # Google Translate API Service Account Credential .json File Path
        googleTranslateTargetLang: 'zh-TW' # Translate to what Language
        googleTranslateTerritoriesExclude: ["TWN","CHN"] # Review origin Territory that you don't want to translate. (territory for Apple e.g. TWN)
```
- `./config/XXXX-XXXX.json` \(Step 2\. GCP IAM 保存下來的 `XXXX-XXXX.json` Service Account 金鑰檔案名稱\)


`android.yml:`
```bash
    - GoogleTranslateProcessor: # Google Translate Processor, will translate review text to your language, you can remove whole block if you don't needed it.
        class: "GoogleTranslateProcessor"
        enable: true # enable
        googleTranslateAPIKeyFilePath: './config/XXXX-XXXX.json' # Google Translate API Service Account Credential .json File Path
        googleTranslateTargetLang: 'zh-TW' # Translate to what Language
        googleTranslateTerritoriesExclude: ["zh-Hant","zh-Hans"] # Review origin Territory (language) that you don't want to translate. (language for android e.g. zh-Hant, en)
```
- `./config/XXXX-XXXX.json` \(Step 2\. GCP IAM 保存下來的 `XXXX-XXXX.json` Service Account 金鑰檔案名稱\)


**完整組合範例：**
```yaml
platform: 'android'
packageName: '' # Android App Package Name
keyFilePath: '' # Google Android Publisher API Service Account Credential .json File Path
playConsoleDeveloperAccountID: '' # Google Console Developer Account ID
playConsoleAppID: '' # Google Console App ID
processors:
    - FilterProcessor:
        class: "FilterProcessor"
        enable: true # enable
        keywordsInclude: [] # keywords you want to filter out
        ratingsInclude: [] # ratings you want to filter out
        territoriesInclude: [] # territories you want to filter out (territory for Apple e.g. TWN)
    - GoogleTranslateProcessor: # Google Translate Processor, will translate review text to your language, you can remove whole block if you don't needed it.
        class: "GoogleTranslateProcessor"
        enable: true # enable
        googleTranslateAPIKeyFilePath: '' # Google Translate API Service Account Credential .json File Path
        googleTranslateTargetLang: 'zh-TW' # Translate to what Language
        googleTranslateTerritoriesExclude: ["zh-Hant","zh-Hans"] # Review origin Territory (language) that you don't want to translate. (language for android e.g. zh-Hant, en)
    - SlackProcessor: # Slack Processor, resend App Review to Slack.
        class: "SlackProcessor"
        enable: true # enable
        slackTimeZoneOffset: "+08:00" # Review Created Date TimeZone
        slackAttachmentGroupByNumber: "1" # 1~100, how many review message in 1 slack message.
        slackBotToken: "" # Slack Bot Token, send slack message throught Slack Bot.
        slackBotTargetChannel: "" # Slack Bot Token, send slack message throught Slack Bot. (recommended, first priority)
        slackInCommingWebHookURL: "" # Slack In-Comming WebHook URL, Send slack message throught In-Comming WebHook, not recommended, deprecated.
```

**調整完畢一樣照以下步驟儲存 `.yml` ：**


![](assets/0095528cf875/1*SZAslED33ZYvx7a-uyGt_w.png)

1. 編輯完成後點擊右上角「Commit changes…」
2. 選擇「Commit directly to the main branch」
3. 點擊「Commit changes」

### 執行參數設定

您可以編輯 `ZReviewTender.yml` 檔案設定執行參數。


![](assets/0095528cf875/1*Ag0n6rrcZfylU8I-oXkfXw.png)



![](assets/0095528cf875/1*c5CGf_BDvbVpBsBtY2oqZg.png)

1. Repo \-\> Actions
2. 點擊「ZReviewTender」
3. 點擊「 `ZReviewTender.yml` 」
4. 點擊右上角「🖊️編輯」

```yaml
name: ZReviewTender
on:
  workflow_dispatch:
  schedule:
    - cron: "15 */6 * * *" #check new review every 6 hour.

jobs:
  ZReviewTender:
    runs-on: ubuntu-latest
    steps:
    - name: ZReviewTender Automatic Bot
      uses: ZhgChgLi/ZReviewTender@main
      with:
        command: '-r'
```
#### 調整檢查頻率 \(多久爬取轉發一次新評價?\)

調整 `cron: "15 */6 * * *"` 裡的設定值。

**參數使用 Crontab 表示，您可以使用 [以下網站](https://crontab.guru/) 產生想要的設定參數：**


![[https://crontab\.guru/](https://crontab.guru/)](assets/0095528cf875/1*iWYVPC8AYalzLiRiQdd_yg.png)

[https://crontab\.guru/](https://crontab.guru/)
#### 調整執行腳本

調整 `command: "-r"` 裡的設定值。
- `-r` : 同時執行 Android 和 Apple \(iOS\) 評價檢查
- `-a` : 紙執行 Apple \(iOS\) 評價檢查
- `-g` : 只執行 Android 評價檢查


**調整完畢：**


![](assets/0095528cf875/1*Jiowjmcc7HIRS3PdelBRSg.png)

1. 編輯完成後點擊右上角「Commit changes…」
2. 選擇「Commit directly to the main branch」
3. 點擊「Commit changes」

#### 暫時停止檢查


![](assets/0095528cf875/1*x3BSHmoRlK6m-gxupdJnHg.png)

1. Repo \-\> Actions
2. 選擇「ZReviewTender」
3. 點擊右方「…」
4. 選擇「Disable workflw」

### 問題回報及功能建議


[![](https://repository-images.githubusercontent.com/516425682/1cc1a829-d87d-4d4a-925b-60471b912b23)](https://github.com/ZhgChgLi/ZReviewTender)


如果您有任何功能建議或問題、Bug，請前往以上 Github Repo 建立 Issue 回報，謝謝。
### 進階使用及開發故事
- [**ZReviewTender — 免費開源的 App Reviews 監控機器人**](https://medium.com/zrealm-ios-dev/zreviewtender-%E5%85%8D%E8%B2%BB%E9%96%8B%E6%BA%90%E7%9A%84-app-reviews-%E7%9B%A3%E6%8E%A7%E6%A9%9F%E5%99%A8%E4%BA%BA-e36e48bb9265)
- [App Store Connect API 現已支援 讀取和管理 Customer Reviews](https://medium.com/zrealm-ios-dev/app-store-connect-api-%E7%8F%BE%E5%B7%B2%E6%94%AF%E6%8F%B4-%E8%AE%80%E5%8F%96%E5%92%8C%E7%AE%A1%E7%90%86-customer-reviews-f1365e51902c)
- [ZReviewsBot — Slack App Review 通知機器人](https://medium.com/zrealm-ios-dev/zreviewsbot-slack-app-review-%E9%80%9A%E7%9F%A5%E6%A9%9F%E5%99%A8%E4%BA%BA-33f6aabb744f)
- [AppStore APP’s Reviews Slack Bot 那些事](https://medium.com/zrealm-ios-dev/appstore-apps-reviews-bot-%E9%82%A3%E4%BA%9B%E4%BA%8B-cb0c68c33994)



有任何問題及指教歡迎 [與我聯絡](https://www.zhgchg.li/contact) 。



_[Post](https://medium.com/zrealm-ios-dev/quick-start-github-action-x-zreviewtender-%E5%85%8D%E8%B2%BB%E5%BF%AB%E9%80%9F%E9%83%A8%E7%BD%B2%E4%BD%A0%E7%9A%84-app-%E5%95%86%E5%9F%8E%E8%A9%95%E5%83%B9%E7%9B%A3%E6%8E%A7%E6%A9%9F%E5%99%A8%E4%BA%BA-0095528cf875) converted from Medium by [ZMediumToMarkdown](https://github.com/ZhgChgLi/ZMediumToMarkdown)._
