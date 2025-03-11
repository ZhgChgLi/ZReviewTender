![ZReviewTender](https://user-images.githubusercontent.com/33706588/184416535-7085e6be-65a1-4bfd-af86-40ec77b0a709.png)

ZReviewTender retrieves app reviews from the App Store and Google Play Console using the new Stability API, then sends them to Slack or integrates seamlessly into your workflow.

- [中文 - 免費開源的 App Reviews 監控機器人](https://medium.com/p/e36e48bb9265)

[![ZReviewTender](https://badge.fury.io/rb/ZReviewTender.svg)](https://rubygems.org/gems/ZReviewTender)

# Features
- [x] Fetches App Store reviews for both iOS and macOS apps
- [x] Retrieves Google Play Console reviews for Android apps
- [x] Sends the latest reviews to a designated Slack channel
- [x] Automatically translates review content into your preferred language using Google Translate
- [x] Logs reviews to Google Sheets or Asana tasks automatically
- [x] Offers flexible extensions, allowing you to create your own processors (plugins) tailored to your workflow
- [x] Lightweight implementation that only logs the latest review timestamp, avoiding the need to store all reviews locally
- [x] Supports filtering, enabling you to set custom conditions to exclude unwanted reviews
- [x] Built on official APIs (AndroidpublisherV3 and the new AppStoreConnect API), eliminating workarounds and session expiration issues
- [x] Easily deployable using the GitHub Repo Template/GitHub Action
- [x] 100% Ruby@RubyGem

# Result
![1_wlGNbHopjPwFsP8j9LpKcw](https://user-images.githubusercontent.com/33706588/183830615-60f5ab30-0e61-4725-be6e-f917fb9589f8.jpeg)

# Compare with Similar Services
|                                      | ZReviewTender                | Appreviewbot.com | Reviewbot.io                     | Aappbot.co                       | Appfollow.io                    | Appfigures.com |
|--------------------------------------|------------------------------|------------------|----------------------------------|----------------------------------|---------------------------------|----------------|
| Pricing for 2 Apps (Android & iOS)   | Forever Free, No Limit       | $11.99/month     | $5/month                         | $39/month                        | $0                              | $7.99/month    |
| Service Type                         | PaaS                         | SaaS             | SaaS                             | SaaS                             | SaaS                            | SaaS           |
| Stability & Immediacy                | High                         | High             | Untested                         | Untested                         | Low                             | Untested       |
| Countries/Languages Limit            | No Limit                     | No Limit         | 5                                | No Limit                         | No Limit                        | No Limit       |
| Reviews Monitoring (resend to Slack) | ✅                            | ✅                | ✅                                | ✅                                | ✅                               | ✅              |
| Reviews Auto-Translation             | ✅ Powered by Google Translate | ✅                | ❌ (not available for basic plan) | ✅ (300 Reviews/month)            | ❌ (not available for free plan) | ✅              |
| Customized Review Filtering           | ✅                            | ❌                | ❌                                | ❌                                | ❌                               | ❌              |
| Customized Integration                | ✅                            | ❌                | ❌                                | ❌                                | ❌                               | ❌              |
| Reply to Reviews                     | ❌                            | ✅                | ❌                                | ❌ (not available for small plan) | ❌ (not available for free plan) | ✅              |
| Reviews Analytics or Reporting       | ❌                            | ❌                | ❌ (not available for basic plan) | ✅                                | ✅                               | ✅              |

# Setup - Only Need Default Processor (Slack/Filter/Google Translate)

# [Quick Start! 🚀](./quickstart.md)

- [👉👉👉 Click here to view the complete Quick Start configuration steps document (2024 Latest Edition).](./quickstart.md)
- [👉👉👉 Click here to view the complete Quick Start configuration steps document (2024 Latest Edition).](./quickstart.md)
- [👉👉👉 Click here to view the complete Quick Start configuration steps document (2024 Latest Edition).](./quickstart.md)

[The entire setup process takes about 30 minutes, but it only needs to be done once. As long as your credentials and keys remain unchanged, it can run stably and for free forever. 🚀🚀🚀🚀🚀](./quickstart.md)

---

# Buy Me a Coffee ❤️❤️❤️

<a href="https://www.buymeacoffee.com/zhgchgli" target="_blank"><img width="545" alt="bmc-button" src="https://github.com/user-attachments/assets/5983bfc9-27fd-49e0-a7f4-eb07657c6e31"></a>

[**If this project has been helpful to you, feel free to buy me a cup of coffee. Thank you!**](https://www.buymeacoffee.com/zhgchgli)

---

## Deploy with GitHub Action

[![image](https://user-images.githubusercontent.com/33706588/184472064-1cd36b40-9e6f-481a-bce3-164dfb379771.png)](https://github.com/ZhgChgLi/ZReviewTender-deploy-with-github-action)

[Deploy with GitHub Repo Template](https://github.com/ZhgChgLi/ZReviewTender-deploy-with-github-action) 🚀🚀🚀

- No need for hosting/server ✅
- No environment requirements ✅
- No engineering background knowledge required ✅
- Only configuration needed ✅
- Completely free ✅

GitHub Action provides 2,000+ minutes/month for free.
ZReviewTender will take approximately 30 seconds per run; with a default schedule of every 6 hours, it will cost about 60 minutes/month.

⚠️️️️️ **MUST CREATE A PRIVATE REPO TO KEEP YOUR CREDENTIAL FILES SAFE.** ⚠️️️️️

## Docker
1. Ensure you have [Docker](https://www.docker.com/products/docker-desktop/) installed on your system.
2. Clone this repo: `git clone https://github.com/ZhgChgLi/ZReviewTender`
3. Navigate to the directory: `cd /ZReviewTender`
4. Build the Docker image: `docker build -t zreviewtender:latest --build-arg CRON_SETTING="*/30 * * * *" --build-arg ZREVIEWTENDER_COMMAND="-r" .`
   - `CRON_SETTING` = crontab schedule setting
   - `ZREVIEWTENDER_COMMAND` = ZReviewTender Command (Refer to the configuration block below.)
6. Refer to the configuration block below to complete the setup.
7. Run Docker: `docker run -v ./:/usr/src/app zreviewtender`
8. Enjoy!

## Using Gem
### If you are familiar with Ruby:
1. Ensure Ruby is installed in your environment (I use `2.6.5p114`).
2. Ensure Bundler is installed in your environment (I use `2.3.13`).
3. Type `gem install ZReviewTender` in the terminal.

#### If you are **NOT** familiar with Ruby:
1. MacOS comes with a system Ruby pre-installed, but we **DO NOT** recommend using that; instead, use Ruby from rvm/rbenv.
2. Install [rbenv](https://github.com/rbenv/rbenv) or [rvm](https://rvm.io/) to manage your Ruby environment.
3. Install Ruby through rbenv/rvm (you can install Ruby version `2.6.X`).
4. Switch the system Ruby to the Ruby from rbenv/rvm.
5. Type `which ruby` in the terminal to ensure the current Ruby is **NOT** `/usr/bin/ruby`.
6. Type `gem install ZReviewTender` in the terminal.

# Setup - Manually (You Can Create Your Own Processor)
1. Clone this repo.
2. Set up the Ruby environment.
3. Run `bundle install`.
4. Execute with `bundle exec bin/ZReviewTender`.

# Configuration
ZReviewTender uses a YAML file to configure the Apple/Google Review Bot settings.

[Recommended] Use `ZReviewTender -i` to generate `apple.yml` & `android.yml` config files.

## Apple (iOS/macOS App)

1. Refer to the [apple.example.yml](https://github.com/ZhgChgLi/ZReviewTender/blob/main/config/apple.example.yml) example config YAML file.
(Please rename `apple.example.yml` to `apple.yml` if you've downloaded it from the reference.)
2. Fill in the configuration in the YAML file:

Go to App Store Connect -> Keys -> [App Store Connect API](https://appstoreconnect.apple.com/access/api)

**appStoreConnectIssueID:**

![1_FsgHMeCGLVbuetBC4gIP_w](https://user-images.githubusercontent.com/33706588/183832148-538d0077-45c0-47d1-939b-bea9b9a67f0c.png)

**appStoreConnectP8PrivateKeyID & appStoreConnectP8PrivateKeyFilePath:**

Create a new API Key:

![1_xBtkRFEKO2xHU26TMdXJZQ](https://user-images.githubusercontent.com/33706588/183832320-f809668a-2d13-40a3-bc81-a3d3c1fd9a3c.png)

- Name: `ZReviewTender`
- Access: `App Manager`

![1_DvjiO3IkHEiPXp0M_dnnww](https://user-images.githubusercontent.com/33706588/183832422-32d5a41b-6f2e-4395-858d-258afe657b51.png)

- `appStoreConnectP8PrivateKeyID`: `Key ID`
- `appStoreConnectP8PrivateKeyFilePath`: `/AuthKey_XXXXXXXXXX.p8`, download the API Key and place it in the `/config/` folder (relative path to the config YAML file).

**appID:**

![1_Ov2pyW9anRVqNCpbxhHtJQ](https://user-images.githubusercontent.com/33706588/183832690-c4fe2e2b-d184-48e6-add4-740b018256b4.png)

`appID`: [App Store Connect](https://appstoreconnect.apple.com/apps) -> App Store -> General -> App Information -> Apple ID

3. After filling out the configuration in the YAML file, rename `apple.example.yml` to `apple.yml`.

## Authenticating as a Service Account for Google-Related Services

- Follow the steps in [Creating a Service Account](https://cloud.google.com/docs/authentication/production#create_service_account) in the official documentation to create a GCP service account and download the **GCP JSON Private Key**.
- Ensure the service account has the necessary access (e.g., Google Translate/Google Android Publisher API/Google Sheets...).

## Google Play Console (Android App)

1. Download the [android.example.yml](https://github.com/ZhgChgLi/ZReviewTender/blob/main/config/android.example.yml) config YAML file. (Please rename `android.example.yml` to `android.yml` if you've downloaded it from the reference.)
2. Fill in the configuration in the YAML file:

**packageName:**

![1_XRzKNGhVbBef7Hl9XPcaWw](https://user-images.githubusercontent.com/33706588/183833107-5fa58cd2-3901-411d-91a1-a4ccdcda57dc.png)

`packageName`: Find the Android App package name in [Google Play Console](https://play.google.com/console/) -> Dashboard -> App.

**playConsoleDeveloperAccountID & playConsoleAppID:**

Find in [Google Play Console](https://play.google.com/console/) -> Dashboard -> App -> Page URL:

https://play.google.com/console/developers/**playConsoleDeveloperAccountID**/app/**playConsoleAppID**/app-dashboard

**keyFilePath:**

Follow the [GCP Getting Started Document](https://developers.google.com/android-publisher/getting_started) to create a Google Cloud Project Service Account and link it to your Google Play Console. Enable the Google Play Android Developer API in Google Play Console -> Setup -> API Access.

![1_yQhAVOuF_CvM49Vayl40zA](https://user-images.githubusercontent.com/33706588/183833645-b2071d6b-d3c5-4841-8293-ce6c07a69098.png)

![1_-AKvlk9P6R0YkuZwsXJaLA](https://user-images.githubusercontent.com/33706588/183833654-b0889e82-c8d0-4b2b-92ab-0f8f953d5c5b.png)

- Ensure the service account has the necessary access.

`keyFilePath`: `/gcp_key.json`, the path to the GCP JSON Private Key, placed in the `/config/` folder (relative path to the config YAML file).

## Default Processor
### FilterProcessor
- class: `FilterProcessor`, no need to change, it points to `lib/Processors/FilterProcessor.rb`
- enable: true/false to enable this Processor or not
- keywordsInclude: ["KEYWORD1","KEYWORD2"...] filter out reviews that contain these keywords
- ratingsInclude: [1,2...] 1~5 filter out reviews that contain specific ratings
- territoriesInclude: ["zh-hant","TWN"...] filter out reviews from these territories (Territory (TWN/JPN...) for Apple / Language (zh-hant, en...) for Android)

### GoogleTranslateProcessor
- class: `GoogleTranslateProcessor`, no need to change, it points to `lib/Processors/GoogleTranslateProcessor.rb`
- enable: true/false to enable this Processor or not
- googleTranslateAPIKeyFilePath: `/gcp_key.json` Google Translate GCP Service Account JSON Private Key File Path `*.json`, placed in the `/config/` folder (relative path to the config YAML file)
- Ensure the service account has the necessary access (Google Translate API)
- googleTranslateTargetLang: `zh-TW` Target translated language
- googleTranslateTerritoriesExclude: ["zh-hant","TWN"...] (Territory (TWN/JPN...) for Apple or Language (zh-hant, en...) for Android reviews that don't need translation.)

### SlackProcessor
- class: `SlackProcessor`, no need to change, it points to `lib/Processors/SlackProcessor.rb`
- enable: true/false to enable this Processor or not
- slackTimeZoneOffset: `+08:00` timezone for displaying review creation time
- slackAttachmentGroupByNumber: `1` specify how many reviews will be grouped in the same Slack message (in Attachment)
- slackBotToken: `xoxb-xxxx-xxxx-xxxx` [Slack Bot](https://slack.com/help/articles/115005265703-Create-a-bot-for-your-workspace) Token
- slackBotTargetChannel: `CXXXXXX` Channel ID (not channel name), and you need to add the Slack Bot to this channel
- slackInCommingWebHookURL: `https://hooks.slack.com/services/XXXXX` the old method for sending messages to Slack, which will be deprecated.
```
Please note, this is a legacy custom integration - an outdated way for teams to integrate with Slack. These integrations lack newer features and will be deprecated and possibly removed in the future. We do not recommend their use. Instead, we suggest that you check out their replacement: Slack apps.
```
ZReviewTender will use `slackBotToken` by default.

![1_D1kt_6jH0UaJo2kvf9l5Qw (1)](https://user-images.githubusercontent.com/33706588/183836286-2a8d8bce-432e-4962-a24c-d6e09e6601ea.png)

![1_UjE_LxtZ0adwS6tr2-vgbw](https://user-images.githubusercontent.com/33706588/183836304-a968b42a-c9ed-4edc-a8f1-34e458d5ab26.png)

### GoogleSheetProcessor
- class: `GoogleSheetProcessor`, no need to change, it points to `lib/Processors/GoogleSheetProcessor.rb`
- enable: true/false to enable this Processor or not
- googleSheetAPIKeyFilePath: `/gcp_key.json` Google Sheet GCP Service Account JSON Private Key File Path `*.json`, placed in the `/config/` folder (relative path to the config YAML file)
- Ensure the service account has the necessary access (Google Sheets API)
- googleSheetTimeZoneOffset: `+08:00` timezone for displaying review creation time
- googleSheetInsertStyle.type: "append" # Google Sheet Insert type, append or insert
- googleSheetInsertStyle.at: 0 # required if type is insert, where the index should be inserted
- googleSheetInsertStyle.sheetID: null # required if type is insert, the sheet ID, which you can find in the Google Sheet URL: e.g. https://docs.google.com/spreadsheets/d/googleSpreadsheetID/edit#gid=sheetID
- googleSheetInsertStyle.sheetName: "Sheet1" # required if type is append, i.e., Google Sheet tab name
- values: [] # Column data you can use magic variables below to compose strings.
```
%TITLE% for review's title
%BODY% for review's content
%RATING% for review's rating 1~5
%PLATFORM% for review's platform (Apple or Android)
%ID% for review's ID
%USERNAME% for review's reviewer username
%URL% for link to review
%TERRITORY% for review's territory (language for Android, e.g., zh-Hant, en)
%APPVERSION% for review's reviewer app version
%CREATEDDATE% for review's creation date
```
- keywordsInclude: ["KEYWORD1","KEYWORD2"...] filter out reviews that contain these keywords you want to log to Google Sheets
- ratingsInclude: [1,2...] 1~5 filter out reviews that contain specific ratings you want to log to Google Sheets
- territoriesInclude: ["zh-hant","TWN"...] filter out reviews from these territories you want to log to Google Sheets (Territory (TWN/JPN...) for Apple / Language (zh-hant, en...) for Android)

*Make sure you add the service account to your Google Sheet with edit permissions.

### Custom Processor
1. Clone this project (since ZReviewTender is a complete Gem, you can't modify it dynamically).
2. Refer to [Processor.rb](https://github.com/ZhgChgLi/ZReviewTender/blob/main/lib/Processors/ProcessorTemplate.rb), make a copy, and develop the features you want.

`initialize`
- `config`: config YAML parameters
- `configFilePath`: config YAML file path
- `baseExecutePath`: the path from which the user executes ZReviewTender

`processReviews(reviews, platform)`
- Input Function 
- You will receive the latest reviews list, and you can decide what to do with it, e.g., transform or filter...
- Review Struct: [lib/Models/Review.rb](https://github.com/ZhgChgLi/ZReviewTender/blob/main/lib/Models/Review.rb)
- Remember to return the resulting reviews for the next Processor to use.

3. Add your Processor & any necessary Processor parameters to the `config.yml` in the `processors:` section.
4. Test & Run!
5. Done!

*Processors are sensitive to data flow chain and order.

### If You Don't Need Some Processors (like Google Translate Processor)

- Set `enable` to `false` or simply remove that Processor Setting Block in the config YAML.

# Usage

If you haven't installed with Gems, you should use `bundle exec ruby bin/ZReviewTender` to execute.

**Generate config YAML file**
```
ZReviewTender -i
```
This will generate `apple.yml` and `android.yml` in the `config/` folder.

**Check Both Apple & Android App's Latest Reviews**
```
ZReviewTender -r
```
This will use `apple.yml` and `android.yml` in the `config` folder.

**Check Both Apple & Android App's Latest Reviews, Specify Config YAML File Path**
```
ZReviewTender --run=CONFIG_FOLDER
```

**Check Apple App's Latest Reviews**
```
ZReviewTender -a
```
This will use `apple.yml` in the `config` folder.

**Check Apple App's Latest Reviews, Specify Config YAML File Path**
```
ZReviewTender --apple=PATH_TO_APPLE_CONFIG_YAML_FILE
```

**Check Android App's Latest Reviews**
```
ZReviewTender -g
```
This will use `android.yml` in the `config` folder.

**Check Android App's Latest Reviews, Specify Config YAML File Path**
```
ZReviewTender --googleAndroid=PATH_TO_ANDROID_CONFIG_YAML_FILE
```

**Clean Last Check Timestamp Log (Back to Initial State)**
```
ZReviewTender -d
```

**Show Current ZReviewTender Version**
```
ZReviewTender -v
```

**Upgrade ZReviewTender to the Latest Release Version (only RubyGem)**
```
ZReviewTender -n
```

## Init (First Time Execution)

![1_62VO8mbJWxXHSeFo3fEUog](https://user-images.githubusercontent.com/33706588/183838813-4f8f3caa-b62d-42a1-a1e2-945a758de8a9.png)

You will receive an initialization success message in your Slack Channel!

### Latest Check Timestamp Folder & Execute Log:

![1_U8vjWSHvY2RzUBcUbQoBvQ](https://user-images.githubusercontent.com/33706588/183839283-bd836917-f4a9-467e-97ff-238d947c2fad.png)

ZReviewTender will also create `latestCheckTimestamp/Apple` and `latestCheckTimestamp/Android` to log the latest checked review timestamps and create `execute.log` for logging execution errors.

![image](https://user-images.githubusercontent.com/33706588/184472442-3bc390d2-c4c0-4eec-8dc2-f8061124e870.png)

## Set Up a Crontab Schedule Job to Execute (Check Latest Review & Process) Periodically
- You can use crontab or any scheduling service to execute ZReviewTender periodically.
- For example, in crontab: `15 */6 * * * ZReviewTender -r`
- Please note that Google API only allows retrieving reviews that users have created or modified within the last week, so you cannot set the time period to more than one week.

[![image](https://user-images.githubusercontent.com/33706588/185638179-39d9fc09-e0c7-4164-864a-0f13e1b7df3f.png)](https://github.com/marketplace/actions/zreviewtender-app-reviews-automatic-bot)

## GitHub Action
![image](https://user-images.githubusercontent.com/33706588/185739638-25f145b8-e2a8-4146-9b4d-688c7ddc75ac.png)

[ZReviewTender App Reviews Automatic Bot](https://github.com/marketplace/actions/zreviewtender-app-reviews-automatic-bot)

```
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
You can change the command to any other ZReviewTender command.

# ⚠️️️️️ Attention
⚠️️️️️ **MUST KEEP YOUR CREDENTIAL FILES SAFE; DO NOT EXPOSE THEM ON THE INTERNET.** ⚠️️️️️

## Disclaimer
This repository is for research purposes only; the use of this code is your responsibility.

- Code authors take NO responsibility and/or liability for how you choose to use any of the source code available here.
- By using any of the files available in this repository, you understand that you are AGREEING TO USE AT YOUR OWN RISK.
- ALL files available here are for EDUCATION and/or RESEARCH purposes ONLY.

## Who is Using It
[![pinkoi](https://user-images.githubusercontent.com/33706588/221343295-3e3831e6-f76d-430a-87e3-4daf9815297d.jpg)](https://en.pinkoi.com)

[Pinkoi.com](https://en.pinkoi.com) is Asia's leading online marketplace for original design goods, digital creations, and workshop experiences.

## About
- [ZhgChg.Li](https://zhgchg.li/)
- [ZhgChgLi's Medium](https://blog.zhgchg.li/)

## Other Works
### Swift Libraries
- [ZMarkupParser](https://github.com/ZhgChgLi/ZMarkupParser) is a pure Swift library that helps you convert HTML strings to NSAttributedString with customized styles and tags.
- [ZPlayerCacher](https://github.com/ZhgChgLi/ZPlayerCacher) is a lightweight implementation of the AVAssetResourceLoaderDelegate protocol that enables AVPlayerItem to support caching streaming files.

### Integration Tools
- [XCFolder](https://github.com/ZhgChgLi/XCFolder) is a powerful command-line tool that converts Xcode virtual groups into actual directories, reorganizing your project structure to align with Xcode groups and enabling seamless integration with modern Xcode project generation tools like Tuist and XcodeGen.
- [ZReviewTender](https://github.com/ZhgChgLi/ZReviewTender) is a tool for fetching app reviews from the App Store and Google Play Console and integrating them into your workflow.
- [ZMediumToMarkdown](https://github.com/ZhgChgLi/ZMediumToMarkdown) is a powerful tool that allows you to effortlessly download and convert your Medium posts to Markdown format.
- [linkyee](https://github.com/ZhgChgLi/linkyee) is a fully customized, open-source LinkTree alternative deployed directly on GitHub Pages.

# Donate

[![Buy Me A Coffee](https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20beer!&emoji=%F0%9F%8D%BA&slug=zhgchgli&button_colour=FFDD00&font_colour=000000&font_family=Bree&outline_colour=000000&coffee_colour=ffffff)](https://www.buymeacoffee.com/zhgchgli)

If you find this library useful, please consider giving the repo a star or sharing it with your friends.

Don't hesitate to open an issue or submit a fix or contribution through a pull request. :)