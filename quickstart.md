# [Quick Start!] Github Action x ZReviewTender: Fast and Free Deployment of Your App Store Review Monitoring Bot

Create a free, stable, and secure app review bot in just three simple steps to monitor the latest user reviews in real-time.

- [👉👉👉 Click here for the Chinese version: Quick Start! Github Action x ZReviewTender 免费快速部署你的 App 商城评价监控机器人](https://medium.com/zrealm-ios-dev/quick-start-github-action-x-zreviewtender-%E5%85%8D%E8%B2%BB%E5%BF%AB%E9%80%9F%E9%83%A8%E7%BD%B2%E4%BD%A0%E7%9A%84-app-%E5%95%86%E5%9F%8E%E8%A9%95%E5%83%B9%E7%9B%A3%E6%8E%A7%E6%A9%9F%E5%99%A8%E4%BA%BA-0095528cf875)

![](https://github.com/ZhgChgLi/ZReviewTender/assets/0095528cf875/1*k8RswW3es9L19jIgbRDLpQ.png)

## [ZReviewTender](https://github.com/ZhgChgLi/ZReviewTender)

ZReviewTender is an open-source app store review bot I developed in August 2022. It automatically retrieves user reviews from the iOS App Store and Android Google Play Store, forwarding them to a designated Slack channel.

Additionally, it allows you to set review fetching rules, integrate with Google Translate, Asana, Google Sheets, and supports custom operations.

## [Github Action](https://docs.github.com/en/actions)

Github Action is a CI/CD automation integration tool provided by GitHub. You can use your own machines as servers (Github Runner) or utilize the machines provided by GitHub to execute CI/CD and automation scripts.

### Costs and Limitations
- Using your own machines (Github Runner):
[No special costs, only maximum execution numbers, concurrency limits, and some API short-term maximum request limits.](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/about-self-hosted-runners#usage-limits)
- [Using GitHub-provided machines:](https://docs.github.com/en/billing/managing-billing-for-github-actions/about-billing-for-github-actions#included-storage-and-minutes)

![](assets/0095528cf875/1*QyhxZ98B20NV18-W5vKJDg.png)

GitHub Free provides basic 500 MB storage (for CI/CD artifacts) and 2,000 minutes of execution time per month.

[**Note regarding machine costs:**](https://docs.github.com/en/billing/managing-billing-for-github-actions/about-billing-for-github-actions#minute-multipliers)
- If using GitHub's Windows machines, the consumed minutes equal actual minutes x 2.
- If using GitHub's macOS machines, the consumed minutes equal actual minutes x 10.

For detailed pricing calculations, please refer to the [official pricing calculator](https://github.com/pricing/calculator?feature=actions).

> [**_ZReviewTender_**](https://github.com/ZhgChgLi/ZReviewTender) **_Monthly minutes consumption: approximately 120 minutes_**

> _It only needs to run on basic billing Linux, with each execution taking about ≤ 1 minute. By default, it runs every 6 hours, spending 4 minutes a day, totaling approximately 120 minutes a month, which is well within the free quota._

> [**_ZReviewTender_**](https://github.com/ZhgChgLi/ZReviewTender) **_Storage consumption: 0_**

> _No use of artifact storage, so there are no storage costs._

## [Slack](https://slack.com/)

Slack is the internal communication software used by the company. A Slack app will be created, and through this app's identity, the App Store review notifications will be forwarded to the designated channel.

![](assets/0095528cf875/1*HMMyU5jwY9iAMyiKmNgVJQ.png)

## [ZReviewTender](https://github.com/ZhgChgLi/ZReviewTender) x [Github Action](https://docs.github.com/en/actions) x [Slack](https://slack.com/)

> _We use Github Action to execute the ZReviewTender script and forward the results to Slack. The GitHub repository (Action) serves merely as a carrier, so even if your main project isn't hosted on GitHub, you can still easily complete the ZReviewTender deployment by following the steps below. 🎉🎉🎉_

> **_I have successfully deployed it across five different apps from various companies, and it has been running stably and for free for at least two years._**

### Advantages:
- **Free**: [ZReviewTender](https://github.com/ZhgChgLi/ZReviewTender) is an open-source service I created, deployed on [Github Action](https://docs.github.com/en/actions) using the free quota, which is more than sufficient. You won't need to spend money every month on app review bots or similar services.
- **Secure**: The credentials and keys used to fetch reviews are securely stored in your GitHub private repository, ensuring that no one else has access to them. You won't have to risk leaking important credentials by uploading them to third-party services; [ZReviewTender](https://github.com/ZhgChgLi/ZReviewTender) is an open-source project, and all operations can withstand public scrutiny.
- **Reliable**: [ZReviewTender](https://github.com/ZhgChgLi/ZReviewTender) uses the latest official API to fetch review information, making it more accurate, stable, and reliable compared to other services that previously fetched reviews via RSS.

# Buy me a coffee ❤️❤️❤️

<a href="https://www.buymeacoffee.com/zhgchgli" target="_blank"><img width="545" alt="bmc-button" src="https://github.com/user-attachments/assets/5983bfc9-27fd-49e0-a7f4-eb07657c6e31"></a>

[**If this project has helped you, feel free to sponsor me a cup of coffee. Thank you!**](https://www.buymeacoffee.com/zhgchgli)

# Quick Start! 🚀

> **_The entire setup process takes about 30 minutes, but it only needs to be set up once. Unless the credentials and keys change, it can run stably and for free forever._** 🚀🚀🚀🚀🚀

## Step 1. Create a Slack App

If your organization already has a Slack app with `chat:write` or similar message-sending permissions, you can reuse it without creating a new one.

### [**Go to the Slack Apps homepage:**](https://api.slack.com/apps)

![](https://api.slack.com/apps)

Click "Create New App" in the upper right corner.

![](assets/0095528cf875/1*sFxmX9qty4UEgMhiTglEfA.png)

![](assets/0095528cf875/1*XiqfLoEmITHyF9E-rDPjPQ.png)

1. Select: From scratch
2. Enter App Name: `ZReviewTender` or customize the Slack app name
3. Select the target Slack Workspace: Ensure you have permission to add a Slack app in the chosen workspace.
4. Create App

### **Add OAuth & Permissions Scopes:**
After creating the Slack app, go to the "OAuth & Permissions" tab to set up scopes.

![](assets/0095528cf875/1*VjXVtAkVN8PLtCAOHocAmA.png)

![](assets/0095528cf875/1*WSNd89bJuG1xCIPM9SsLnA.png)

1. Select "OAuth & Permissions"
2. Scroll down to find the Scopes section
3. Sequentially add the three necessary scopes for the ZReviewTender Slack app:

```vbnet
chat:write
chat:write.public
links:write
```

### **Install App**
Return to the Install App tab to install the Slack app into the workspace.

![](assets/0095528cf875/1*qItvJK5tZ-i8vE5bNUZIKQ.png)

![](assets/0095528cf875/1*Eevu3Sir68DhfFSrFKb1xg.png)

1. Select "Install App"
2. Click "Install to _YOUR_WORKSPACE_"
3. Click "Allow"

![](assets/0095528cf875/1*lj8KZ5bEOG9urPgtxet-YA.png)

After installation, return to the Install App page to find the `Slack App Bot User OAuth Token`. Click "Copy" to copy it, and **note it down for later use**.

### **Create a channel to receive review notifications:**

![](assets/0095528cf875/1*vwILile0Y52PgjQAYLqGjQ.png)

![](assets/0095528cf875/1*jZwuovjXaCbQiWTixOP5Dg.png)

- Sidebar -> Channels -> Create -> Create channel
- Name: Enter the desired channel name

![](assets/0095528cf875/1*cK8ihh9IQPacTjGKG4GS3Q.png)

**Visibility:**
- Public: Open to everyone, no further action needed.
- **Private: Private channel,** ⭐️⭐️⭐️ **you need to add the newly created Slack app:**

#### **How to add Slack App to the channel:**

![](assets/0095528cf875/1*AgCjAYb94XOmlIJ7VV6gaw.png)

![](assets/0095528cf875/1*GVqrJlBg_9MjVyGitA2g-A.png)

1. Click on the top \#channel name
2. Click "Settings"
3. Click "Add an App"

![](assets/0095528cf875/1*KU5hdi2m46TUwZbjI-xKmg.png)

1. Search for the name of the Slack app you just created
2. Click "Add"

![](assets/0095528cf875/1*Qx2XPK8lspCrSauWE4IhXA.png)

A prompt will appear in the channel indicating success: `ZReviewTender joined.`

> **_⭐️⭐️⭐️ There is a known Slack bug here. The newly created Slack app might not appear in the search immediately; you may need to wait a while. You can use a public channel first, as public channels do not require adding the Slack app to function._**

### **Get Channel ID:**
The final and most important step is to get the Channel ID for later configuration.

![](assets/0095528cf875/1*CmQtV9QibdOb8zHuiYJS2Q.png)

![](assets/0095528cf875/1*VNmLOs0mBhF6qisDzx6Zcw.png)

1. Click on the top \#channel name
2. At the bottom of About, you will find the Channel ID information
3. **Note down the `Channel ID` for later configuration**

> **_Slack steps completed._**

— — —

### **Additional Information:**

**You can edit the Slack app name and icon in "Basic Information" -> "Display Information":**

![](assets/0095528cf875/1*5THTrkeWXYa5QaGCNCmzhQ.png)

Remember to click "Save Changes" at the bottom right corner to save your changes.

**If there are new additions to OAuth & Permissions Scopes, you need to click "reinstall your app" to reinstall it for the changes to take effect:**

![](assets/0095528cf875/1*pUdxf_G1uoHcq22VGjHOzw.png)

## Step 2. Generate Apple App Store Connect API & Google Play Android Developer API credentials
### Apple App Store Connect API credentials

**iOS is relatively easier; we only need to gather the following four pieces of information from App Store Connect:**

#### **Issuer ID:**

![](assets/0095528cf875/0*eHn-LMnUlS-04d70.png)

- App Store Connect -> Keys -> [App Store Connect API](https://appstoreconnect.apple.com/access/api)
- **Note down the `Issuer ID` for later configuration**

#### **Private Key ID & Private Key:**

Click the "+" button to add:

![](assets/0095528cf875/0*MI0-cA0BTkq5XqkT.png)

- Name: `ZReviewTender`
- Access: `App Manager`

![](assets/0095528cf875/0*V0U2HjKTRfL8dl1j.png)

- `Key ID` **for later configuration**
- **Click "Download API Key" to save and download the "AuthKey_XXXXXXXXXX.p8" file for later configuration.**

#### **App ID: (The target App ID for fetching reviews)**

![](assets/0095528cf875/1*zCgRRm0-nDwvcGOv26Aprw.png)

App ID can be found in [App Store Connect](https://appstoreconnect.apple.com/apps) -> App Store -> General -> App Information -> `App ID`.
- **Note down the `App ID` for later configuration**

### Google Play Android Developer API credentials

Android is more complex, requiring you to first enable the API and create a Service Account in the Google Cloud Project associated with the app project, and then add the Service Account to Google Play Console and grant app permissions.

[**Go to Google Cloud Project:**](https://console.cloud.google.com/welcome)

Select the Google Cloud Project associated with the app project or create a new project.

#### **Enable "Android Developer API":**

![](assets/0095528cf875/1*zvWFDBuPRq9a6bizjqrx4Q.png)

![](assets/0095528cf875/1*Z0g1ezVJBptHvRkd1VlF_Q.png)

1. Search for "Android Developer API" and click to enter
2. Select "Enable"

**\[Optional\] You can also enable "Cloud Translation API":**

![](assets/0095528cf875/1*rL-t3VHvNONNWtUlboAllg.png)

![](assets/0095528cf875/1*9CItyqjGmG5LcMMDe-6NlQ.png)

- After enabling, you can use the same Service Account credentials to integrate the review auto-translation feature.
- **Please note: Cloud Translation API is not free, and there will be charges for language detection and translation!**
- **Please note: Cloud Translation API is not free, and there will be charges for language detection and translation!**
- **Please note: Cloud Translation API is not free, and there will be charges for language detection and translation!**

#### **Create Service Account:**

![](assets/0095528cf875/1*_WZ_lwp1TjG5cRoI1rH_7g.png)

1. Search for "IAM"
2. Select "IAM & Admin"

![](assets/0095528cf875/1*-PBkhiBsqejz8PejVhSB3A.png)

1. Select "Service Account"
2. Select "Create Service Account"

![](assets/0095528cf875/1*_oU-8T-qv7pyuUBmX-U64w.png)

1. Service Account Name: Enter a name, such as "ZReviewTender" or "Google Play Review Bot"
2. Service Account ID: Auto-filled, no need to change unless necessary. This will also be your Service Account Email.
3. Click "Done"

**Note down the Service Account Email address:**

![](assets/0095528cf875/1*gTNjATgSPZ4Z9zrJ2caYdw.png)

- The list page will also display the Service Account Email address.
- **Note down the `Service Account Email` for later use.**

**Create Service Account Key:**

![](assets/0095528cf875/1*MDkammdsXQQbLYrQ_eGTxQ.png)

![](assets/0095528cf875/1*Ev2pRLcJv_UGKUWfDNsSPQ.png)

1. Refresh the list page and click on the newly created Service Account.
2. Click "Add Key"
3. Click "Create new key"
4. Select "JSON" as the key type.
5. Click "Create"
6. **Save the downloaded `XXXX-XXXX.json` file for later use.**

#### **Add the Service Account to Google Play Console and grant permissions to the target app:**

[**Go to Google Play Console:**](https://play.google.com/console/)

![](assets/0095528cf875/1*Lbowza_thZaSDx5BuRWMsg.png)

1. Click "Users and permissions"
2. Click "Invite new users" on the right

![](assets/0095528cf875/1*vNreKooCJL4XiRv_XTsAYg.png)

1. Enter the `Service Account Email` noted earlier in the Email address field.
2. App permissions -> Add app
3. Add the target app for fetching reviews.
4. Click "Invite user" to complete the invitation; no verification needed.

**Obtain Google Play Console Developer ID & App ID & Package Name:**

![](assets/0095528cf875/1*-eha5rTUbdzUwJfiJTakBA.png)

1. Click on the target app to enter the Dashboard.
2. **Note down the `Package Name` for later use.**

Copy the Dashboard URL and find:

3. In the URL, /developers/ `XXX` **is your `Developer ID`. Note down this number for later use.**

4. In the URL, /app/ `XXX` **is your `App ID`. Note down this number for later use.**

> **_Credential setup complete._**

## Step 3. Github Action Deployment and Configuration

The exciting news is that I have packaged the tedious GitHub Repo and GitHub Action setup process into a Repo Template & Marketplace GitHub Action. You can complete the work by following these steps.

### **Go to: [ZReviewTender-deploy-with-github-action](https://github.com/ZhgChgLi/ZReviewTender-deploy-with-github-action):**

![](https://github.com/ZhgChgLi/ZReviewTender-deploy-with-github-action)

![](assets/0095528cf875/1*IfqkNXm7cOeyuYabUo3THQ.png)

- Repository name: Enter the repo name you want.
- **Private**: Since the repo will store access keys, **be sure to set it as a Private Repo ⭐️⭐️⭐️**
- Click "Create repository"

> The author, contributors, and ZhgChgLi of ZReviewTender are not responsible for any loss caused by your use of ZReviewTender.

**Wait for the repository to be created:**

![](assets/0095528cf875/1*oudjjgmGnL1iFHeO-VJUiA.png)

**Confirm again that it is a Private Repo:**

![](assets/0095528cf875/1*MDFXKOWXvAeE3fcUUeRWWQ.png)

- **Private**: Since the repo will store access keys, **be sure to set it as a Private Repo ⭐️⭐️⭐️**

### **Enable GitHub Actions permissions:**
After the repo is created, due to GitHub security settings, you need to go to Repo Settings to allow GitHub Actions to execute.

![](assets/0095528cf875/1*VRYwO-rh8bjJQUoaDDa2rw.png)

1. Repo -> Settings
2. Select "Actions" -> "General"
3. Actions permissions select "Allow all actions and reusable workflows"
4. Click "Save"
5. Workflow permissions select "Read repository contents and packages permissions"

**First run, initialize ZReviewTender:**

![](assets/0095528cf875/1*EME0aMziInPAZO5OQCSnMg.png)

1. Repo -> Actions
2. Select "Init ZReviewTender"
3. Select "Run workflow"
4. Click "Run workflow"
5. Refresh the page

### **Wait for** `init ZReviewTender` **Action to complete:**

![](assets/0095528cf875/1*XxopQjcyvVPOWuGwC4czyA.png)

> _If an ❌ Error appears: Please recheck the GitHub Actions permissions settings mentioned earlier._

**After successful initialization, two new directories will appear on the Repo homepage:**

![](assets/0095528cf875/1*sr69yq6hw3y4PpeHuykc5w.png)

### **Upload the required certificate files:**

![](assets/0095528cf875/1*2pIncX5nVRPy2BkOOf2qxg.png)

![](assets/0095528cf875/1*hZ4j_Q6GAJOwWNMv-YYQIg.png)

1. Enter the `/config` directory.
2. Top right corner "Add file" -> "Upload files"

![](assets/0095528cf875/1*QEAfsc0F_3sbRjGCbsTKpQ.png)

1. Upload the GCP Service Account `XXXX-XXXX.json` (for Android) and the App Store Connect `AuthKey_XXXXXXXXXX.p8` (for iOS) saved in Step 2 together.
2. Wait for the upload to complete.
3. Select "Commit directly to the main branch."
4. Click "Commit changes."

### **Setting Apple (iOS):**

![](assets/0095528cf875/1*2pIncX5nVRPy2BkOOf2qxg.png)

![](assets/0095528cf875/1*qiPzFqVQXQbMlbsRCQWiqw.png)

- Enter the `config/` directory, click on the `apple.yml` file.

![](assets/0095528cf875/1*SscBDfN9_MbAu8TbxynCLw.png)

- Click on the top right "🖊️ Edit."

**Edit `apple.yml`, paste the following content, and fill in the information noted down in the previous steps:**
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
        slackAttachmentGroupByNumber: "1" # 1~100, how many review messages in 1 slack message.
        slackBotToken: "Slack App Bot User OAuth Token" # Slack Bot Token, send slack message through Slack Bot.
        slackBotTargetChannel: "Target Channel ID" # Slack Bot Token, send slack message through Slack Bot. (recommended, first priority)
        slackInCommingWebHookURL: "" # Slack In-Coming WebHook URL, Send slack message through In-Coming WebHook, not recommended, deprecated.
```
- `appStoreConnectP8PrivateKeyFilePath`: 
Enter `./config/AuthKey_XXXXXXXXXX.p8` (Step 2. App Store Connect saved `AuthKey_XXXXXXXXXX.p8` file name).
- `appStoreConnectP8PrivateKeyID`: Step 2. App Store Connect noted `Private Key ID`.
- `appStoreConnectIssueID`: Step 2. App Store Connect noted `Issuer ID`.
- `appID`: Step 2. App Store Connect noted target app's `App ID`.
- `slackBotToken`: Enter Step 1. noted `Slack App Bot User OAuth Token`.
- `slackBotTargetChannel`: Enter Step 1. noted target `Channel ID`.

![](assets/0095528cf875/1*REBLdx4NpXH3_itfSaZg3A.png)

1. After editing, click on the top right "Commit changes…"
2. Select "Commit directly to the main branch."
3. Click "Commit changes."

### **Setting Android:**

![](assets/0095528cf875/1*2pIncX5nVRPy2BkOOf2qxg.png)

![](assets/0095528cf875/1*jaKIWwtLwhwT7uAc9WmT_g.png)

- Enter the `config/` directory and click on the `android.yml` file.

![](assets/0095528cf875/1*mylh0XXOdbmgbBNHGxB54Q.png)

- Click on the "🖊️ Edit" button in the upper right corner.

**Edit `android.yml`, paste the following content, and fill in the information noted down from the previous steps:**
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
        slackAttachmentGroupByNumber: "1" # 1~100, how many review messages in 1 slack message.
        slackBotToken: "Slack App Bot User OAuth Token" # Slack Bot Token, send slack message through Slack Bot.
        slackBotTargetChannel: "Target Channel ID" # Slack Bot Token, send slack message through Slack Bot. (recommended, first priority)
        slackInCommingWebHookURL: "" # Slack In-Coming WebHook URL, Send slack message through In-Coming WebHook, not recommended, deprecated.
```
- `packageName`: Step 2. Google Play Console backend noted `Package Name`.
- `keyFilePath`: Enter `./config/XXXX-XXXX.json` (Step 2. GCP IAM saved `XXXX-XXXX.json` Service Account key file name).
- `playConsoleDeveloperAccountID`: Step 2. Google Play Console backend noted `Developer ID`.
- `playConsoleAppID`: Step 2. Google Play Console backend noted `App ID`.
- `slackBotToken`: Enter Step 1. noted `Slack App Bot User OAuth Token`.
- `slackBotTargetChannel`: Enter Step 1. noted `Channel ID` to send to.

![](assets/0095528cf875/1*SZAslED33ZYvx7a-uyGt_w.png)

1. After editing, click on the "Commit changes…" button in the upper right corner.
2. Choose "Commit directly to the main branch."
3. Click "Commit changes."

> **_Setup complete!_** 🚀🚀🚀🚀

## **Verify if the setup is successful:**

We can manually run it once to confirm the setup is correct.

![](assets/0095528cf875/1*VsBvNpXeR9yoTsG61mZ--Q.png)

1. Repo -> Actions
2. Select "ZReviewTender"
3. Select "Run workflow"
4. Click "Run workflow"
5. Refresh the page

**Waiting** for `ReviewTender` **Action to complete:**

![](assets/0095528cf875/1*VHCX5ppMzCUf-Fxvflo7OA.png)

### **Verification successful 🎉🎉🎉🎉**

![](assets/0095528cf875/1*hSETSIooRcYLH1YS5ssyxA.png)

> _If ❌ Error occurs, or the Slack channel does not receive the activation message: please recheck the previous configuration file content for correctness._

## Completed **🎉🎉🎉**

![](assets/0095528cf875/1*HMMyU5jwY9iAMyiKmNgVJQ.png)

Now you can rely on this free and reliable app review bot to keep track of the latest user reviews at all times!

# Buy me a coffee ❤️❤️❤️

<a href="https://www.buymeacoffee.com/zhgchgli" target="_blank"><img width="545" alt="bmc-button" src="https://github.com/user-attachments/assets/5983bfc9-27fd-49e0-a7f4-eb07657c6e31"></a>

[**If this project has helped you, feel free to sponsor me a cup of coffee. Thank you!**](https://www.buymeacoffee.com/zhgchgli)

## Other Settings
### Adding Filter Function

```yaml
    - FilterProcessor:
        class: "FilterProcessor"
        enable: true # enable
        keywordsInclude: [] # keywords you want to filter out
        ratingsInclude: [] # ratings you want to filter out
        territoriesInclude: [] # territories you want to filter out (territory for Apple e.g. TWN)
```
- Simply add the `FilterProcessor` settings to the `processors` section of either `/config/apple.yml` or `/config/android.yml`.

### Adding Auto-Translation Function

Automatically translate reviews that are not in your preferred language using the Google Cloud Translation API (note that costs may apply).
- **Make sure that the GCP Project linked to the Service Account created in Step 2 has the "Cloud Translation API" enabled.**
- The settings for `apple.yml` and `android.yml` differ slightly.

`apple.yml:`
```bash
    - GoogleTranslateProcessor: # Google Translate Processor, which translates review text to your language. You can remove this entire block if you don't need it.
        class: "GoogleTranslateProcessor"
        enable: true # enable
        googleTranslateAPIKeyFilePath: './config/XXXX-XXXX.json' # Path to the Google Translate API Service Account Credential .json file
        googleTranslateTargetLang: 'zh-TW' # Target language for translation
        googleTranslateTerritoriesExclude: ["TWN","CHN"] # Territories of review origin that you don't want to translate (territory for Apple e.g. TWN)
```
- `./config/XXXX-XXXX.json` (Step 2. GCP IAM saved `XXXX-XXXX.json` Service Account key file name)

`android.yml:`
```bash
    - GoogleTranslateProcessor: # Google Translate Processor, which translates review text to your language. You can remove this entire block if you don't need it.
        class: "GoogleTranslateProcessor"
        enable: true # enable
        googleTranslateAPIKeyFilePath: './config/XXXX-XXXX.json' # Path to the Google Translate API Service Account Credential .json file
        googleTranslateTargetLang: 'zh-TW' # Target language for translation
        googleTranslateTerritoriesExclude: ["zh-Hant","zh-Hans"] # Territories of review origin (language) that you don't want to translate (language for Android e.g. zh-Hant, en)
```
- `./config/XXXX-XXXX.json` (Step 2. GCP IAM saved `XXXX-XXXX.json` Service Account key file name)

#### **Complete Combination Example:**
```yaml
platform: 'android'
packageName: '' # Android App Package Name
keyFilePath: '' # Path to the Google Android Publisher API Service Account Credential .json file
playConsoleDeveloperAccountID: '' # Google Console Developer Account ID
playConsoleAppID: '' # Google Console App ID
processors:
    - FilterProcessor:
        class: "FilterProcessor"
        enable: true # enable
        keywordsInclude: [] # keywords you want to filter out
        ratingsInclude: [] # ratings you want to filter out
        territoriesInclude: [] # territories you want to filter out (territory for Apple e.g. TWN)
    - GoogleTranslateProcessor: # Google Translate Processor, which translates review text to your language. You can remove this entire block if you don't need it.
        class: "GoogleTranslateProcessor"
        enable: true # enable
        googleTranslateAPIKeyFilePath: '' # Path to the Google Translate API Service Account Credential .json file
        googleTranslateTargetLang: 'zh-TW' # Target language for translation
        googleTranslateTerritoriesExclude: ["zh-Hant","zh-Hans"] # Territories of review origin (language) that you don't want to translate (language for Android e.g. zh-Hant, en)
    - SlackProcessor: # Slack Processor, which sends App Reviews to Slack.
        class: "SlackProcessor"
        enable: true # enable
        slackTimeZoneOffset: "+08:00" # Review Created Date TimeZone
        slackAttachmentGroupByNumber: "1" # 1~100, number of review messages in one Slack message.
        slackBotToken: "" # Slack Bot Token, used to send messages through the Slack Bot.
        slackBotTargetChannel: "" # Slack Bot Token, used to send messages through the Slack Bot. (recommended, first priority)
        slackInCommingWebHookURL: "" # Slack Incoming WebHook URL, used to send messages through Incoming WebHook, not recommended, deprecated.
```

**Save the adjusted file as `.yml` by following these steps:**

![](assets/0095528cf875/1*SZAslED33ZYvx7a-uyGt_w.png)

1. After editing, click "Commit changes…" in the upper right corner.
2. Select "Commit directly to the main branch."
3. Click "Commit changes."

### Execution Parameter Settings

You can modify the `ZReviewTender.yml` file to set execution parameters.

![](assets/0095528cf875/1*Ag0n6rrcZfylU8I-oXkfXw.png)

![](assets/0095528cf875/1*c5CGf_BDvbVpBsBtY2oqZg.png)

1. Repo -> Actions
2. Click "ZReviewTender"
3. Click "`ZReviewTender.yml`"
4. Click the top right "🖊️ Edit"

```yaml
name: ZReviewTender
on:
  workflow_dispatch:
  schedule:
    - cron: "15 */6 * * *" # Check for new reviews every 6 hours.

jobs:
  ZReviewTender:
    runs-on: ubuntu-latest
    steps:
    - name: ZReviewTender Automatic Bot
      uses: ZhgChgLi/ZReviewTender@main
      with:
        command: '-r'
```
#### Adjust the Check Frequency (How often to fetch new reviews?)

Modify the settings in `cron: "15 */6 * * *"`.

**Parameters use Crontab notation; you can use [this website](https://crontab.guru/) to generate the desired settings:**

![[https://crontab.guru/](https://crontab.guru/)](assets/0095528cf875/1*iWYVPC8AYalzLiRiQdd_yg.png)

[https://crontab.guru/](https://crontab.guru/)
#### Adjust the Execution Script

Modify the settings in `command: "-r"`.
- `-r`: Check reviews for both Android and Apple (iOS)
- `-a`: Only check reviews for Apple (iOS)
- `-g`: Only check reviews for Android

**After adjustments:**

![](assets/0095528cf875/1*Jiowjmcc7HIRS3PdelBRSg.png)

1. After editing, click the top right "Commit changes…"
2. Select "Commit directly to the main branch."
3. Click "Commit changes."

#### Temporarily Stop Checking

![](assets/0095528cf875/1*x3BSHmoRlK6m-gxupdJnHg.png)

1. Repo -> Actions
2. Select "ZReviewTender"
3. Click the right "…"
4. Select "Disable workflow."

### Issue Reporting and Feature Suggestions

[![](https://repository-images.githubusercontent.com/516425682/1cc1a829-d87d-4d4a-925b-60471b912b23)](https://github.com/ZhgChgLi/ZReviewTender)

If you have any feature suggestions or encounter issues, please visit the GitHub repository linked above to create an issue report. Thank you!