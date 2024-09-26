![ZReviewTender](https://user-images.githubusercontent.com/33706588/184416535-7085e6be-65a1-4bfd-af86-40ec77b0a709.png)

ZReviewTender is a tool for fetching app reviews from the App Store and Google Play Console using the brand new official Stability API, and seamlessly integrating them into your workflow.

- [中文 - 免費開源的 App Reviews 監控機器人](https://medium.com/p/e36e48bb9265)

[![ZReviewTender](https://badge.fury.io/rb/ZReviewTender.svg)](https://rubygems.org/gems/ZReviewTender)

# Features
- [x] Supports fetching App Store reviews for iOS apps and Mac OS apps
- [x] Supports fetching Google Play Console reviews for Android apps
- [x] Resends the newest reviews to a specified Slack channel
- [x] Supports auto-translating review content to your language using Google Translate
- [x] Supports auto-logging reviews to Google Sheets or Asana task
- [x] Offers flexible extensions so you can develop your own processor (a.k.a. plugin) to suit your workflow
- [x] Provides a lightweight implementation that only logs the latest review timestamp, rather than saving all reviews in local storage
- [x] Supports filtering, allowing you to add custom filter conditions to filter out the reviews you don't need
- [x] Based on official APIs (AndroidpublisherV3 and the brand new AppStoreConnect API), eliminating the need for workarounds or dealing with session expired problems
- [x] Quickly deployable with the Github Repo Template/Github Action
- [x] 100% Ruby@RubyGem

# Result
![1_wlGNbHopjPwFsP8j9LpKcw](https://user-images.githubusercontent.com/33706588/183830615-60f5ab30-0e61-4725-be6e-f917fb9589f8.jpeg)

# Compare with similar services
|                                      | ZReviewTender                | Appreviewbot.com | Reviewbot.io                     | Aappbot.co                       | Appfollow.io                    | Appfigures.com |
|--------------------------------------|------------------------------|------------------|----------------------------------|----------------------------------|---------------------------------|----------------|
| Pricing for 2 Apps (Android & iOS)   | Forever Free No limit        | $11.99/month     | $5/month                         | $39/month                        | $0                              | $7.99/month    |
| Service Type                         | PaaS                         | SaaS             | SaaS                             | SaaS                             | SaaS                            | SaaS           |
| Stability & Immediacy                | High                         | High             | untested                         | untested                         | Low                             | untested       |
| Countries/Languages Limit            | No limit                     | No limit         | 5                                | No limit                         | No limit                        | No limit       |
| Reviews Monitoring (resend to Slack) | ✅                            | ✅                | ✅                                | ✅                                | ✅                               | ✅              |
| Reviews Auto-Translation             | ✅ Powered by GoogleTranslate | ✅                | ❌ (not available for basic plan) | ✅ (300 Reviews/month)            | ❌ (not available for free plan) | ✅              |
| Reviews Monitoring Customized Filter | ✅                            | ❌                | ❌                                | ❌                                | ❌                               | ❌              |
| Customized Integration               | ✅                            | ❌                | ❌                                | ❌                                | ❌                               | ❌              |
| Reply to reviews                     | ❌                            | ✅                | ❌                                | ❌ (not available for small plan) | ❌ (not available for free plan) | ✅              |
| Reviews Analytics or Reporting       | ❌                            | ❌                | ❌ (not available for basic plan) | ✅                                | ✅                               | ✅              |

# Setup - Only need Default Proceesor(Slack/Filter/Google Translate)

# [Quick Start! 🚀](./quickstart.md)


- [👉👉👉 Click here to view the complete Quick Start configuration steps document (2024 Latest Edition).](./quickstart.md)
- [👉👉👉 Click here to view the complete Quick Start configuration steps document (2024 Latest Edition).](./quickstart.md)
- [👉👉👉 Click here to view the complete Quick Start configuration steps document (2024 Latest Edition).](./quickstart.md)

[The entire setup process takes about 30 minutes, but only needs to be set up once. Unless the credentials and keys are changed, it can run stably and for free forever. 🚀🚀🚀🚀🚀](./quickstart.md)

---

# Buy me coffee ❤️❤️❤️

<a href="https://www.buymeacoffee.com/zhgchgli" target="_blank"><img width="545" alt="bmc-button" src="https://github.com/user-attachments/assets/5983bfc9-27fd-49e0-a7f4-eb07657c6e31"></a>

[**If this project has helped you, feel free to sponsor me a cup of coffee, thank you.**](https://www.buymeacoffee.com/zhgchgli)

---


## Deploy With Github Action

[![image](https://user-images.githubusercontent.com/33706588/184472064-1cd36b40-9e6f-481a-bce3-164dfb379771.png)](https://github.com/ZhgChgLi/ZReviewTender-deploy-with-github-action)


[Deploy with Gitub Repo Template](https://github.com/ZhgChgLi/ZReviewTender-deploy-with-github-action) 🚀🚀🚀

- no need host/server ✅
- no need environment requirement ✅
- no engineering background knowledge ✅
- only need configuration ✅
- total free ✅

Github Action Proivde 2,000+ mins/month for free.
ZReviewTender will cost ~= 30s per time, default run every 6 hours will cost 4 times/day * 30s/per time * 30days = 60 mins/month

⚠️️️️️ MUST CREATE PRIVATE REPO, TO KEEP YOUR CREDENTIAL FILES SAFE. ⚠️️️️️

## Docker
1. make sure has [Docker](https://www.docker.com/products/docker-desktop/) on your system.
2. git clone this repo `git clone https://github.com/ZhgChgLi/ZReviewTender`
3. `cd /ZReviewTender`
4. build docker image `docker build -t zreviewtender:latest --build-arg CRON_SETTING="*/30 * * * *" --build-arg ZREVIEWTENDER_COMMAND="-r" .`
   - CRON_SETTING = crontab schedule setting
   - ZREVIEWTENDER_COMMAND = ZReviewTender Command (Refer to the configuration block down below.)
6. Refer to the configuration block down below and finish the configuration.
7. run docker `docker run -v ./:/usr/src/app zreviewtender`
8. have fun!

## Using Gem
### If you are familiar with ruby:
1. make sure you have Ruby in your environment (I use `2.6.5p114`)
2. make sure you have Bundle in your environment (I use `2.3.13`)
3. type `gem install ZReviewTender` in terminal

#### If you are **NOT** familiar with ruby:
1. MacOS comes with a System Ruby pre-installed, but we are **NOT** Recommend to use that, using rvm/rbenv's Ruby instead.
2. install [rbenv](https://github.com/rbenv/rbenv) or [rvm](https://rvm.io/) to manage Ruby environment
3. install Ruby through rbenv/rym (you can install ruby version `2.6.X`)
4. change the systme ruby to rbenv/rvm's Ruby
5. type `which ruby` in terminal to make sure current Ruby is **NOT** `/usr/bin/ruby`
6. type `gem install ZReviewTender` in terminal

# Setup - Manually(You can create your own Processor)
1. Clone this repo
2. Setup ruby environment
3. run `bundle install`
4. execute with `bundle exec bin/ZReviewTender`

# Configuration
ZReviewTender uses yaml file to config Apple/Google Review Bot Setting.

[Recommended] use `ZReviewTender -i` generator apple.yml & android.yml config yml files.

## Apple (iOS/macOS App)

1. Reference the [apple.example.yml](https://github.com/ZhgChgLi/ZReviewTender/blob/main/config/apple.example.yml) example config yaml file.
(Please rename `apple.example.yml` to `apple.yml` if you've downloaded from reference.)
2. fill configuration in yaml file:

Go to App Store Connect -> Keys -> [App Store Connect API](https://appstoreconnect.apple.com/access/api)

**appStoreConnectIssueID：**

![1_FsgHMeCGLVbuetBC4gIP_w](https://user-images.githubusercontent.com/33706588/183832148-538d0077-45c0-47d1-939b-bea9b9a67f0c.png)

**appStoreConnectP8PrivateKeyID & appStoreConnectP8PrivateKeyFilePath：**

Create a new API Key:

![1_xBtkRFEKO2xHU26TMdXJZQ](https://user-images.githubusercontent.com/33706588/183832320-f809668a-2d13-40a3-bc81-a3d3c1fd9a3c.png)

- Name: `ZReviewTender`
- Access: `App Manager`

![1_DvjiO3IkHEiPXp0M_dnnww](https://user-images.githubusercontent.com/33706588/183832422-32d5a41b-6f2e-4395-858d-258afe657b51.png)

- appStoreConnectP8PrivateKeyID: `Key ID`
- appStoreConnectP8PrivateKeyFilePath: `/AuthKey_XXXXXXXXXX.p8`, Download API Key and placed it to /config/ folder (releated path with config yml file)

**appID:**

![1_Ov2pyW9anRVqNCpbxhHtJQ](https://user-images.githubusercontent.com/33706588/183832690-c4fe2e2b-d184-48e6-add4-740b018256b4.png)

appID: [App Store Connect](https://appstoreconnect.apple.com/apps) -> App Store -> General -> App Information -> Apple ID

3. after filled out configuration in yaml file, rename `apple.example.yml` to `apple.yml`

## Use Authenticating as a service accountAuthenticating as a service account for Google Releated Service

- follow the steps of [Creating a service account](https://cloud.google.com/docs/authentication/production#create_service_account) in offcial documentation, to create a service account of GCP and download the **GCP JSON Private Key**.
- make sure the service account have the right access you need (e.g. Google Translate/Google Ancdroid Publisher API/Google Sheet...)

## Google Play Console (Android App)

1. Download the [android.example.yml](https://github.com/ZhgChgLi/ZReviewTender/blob/main/config/android.example.yml) config yaml file. (Please rename `android.example.yml` to `android.yml` if you've downloaded from reference.)
2. fill configuration in yaml file:

**packageName:**

![1_XRzKNGhVbBef7Hl9XPcaWw](https://user-images.githubusercontent.com/33706588/183833107-5fa58cd2-3901-411d-91a1-a4ccdcda57dc.png)

packageName: find Android App packageName in [Google Play Console](https://play.google.com/console/) -> Dashboard -> App

**playConsoleDeveloperAccountID & playConsoleAppID:**

find in [Google Play Console](https://play.google.com/console/) -> Dashboard -> App -> Page URL:

https://play.google.com/console/developers/**playConsoleDeveloperAccountID**/app/**playConsoleAppID**/app-dashboard

**keyFilePath:**

Follow the [GCP Started Document](https://developers.google.com/android-publisher/getting_started) to created a Google Cloud Project Service Account and linked it to your Google Play Console, enable Google Play Android Developer API in Google Play Console -> Setup -> API Access.

![1_yQhAVOuF_CvM49Vayl40zA](https://user-images.githubusercontent.com/33706588/183833645-b2071d6b-d3c5-4841-8293-ce6c07a69098.png)

![1_-AKvlk9P6R0YkuZwsXJaLA](https://user-images.githubusercontent.com/33706588/183833654-b0889e82-c8d0-4b2b-92ab-0f8f953d5c5b.png)

- make sure the service account have the right access

keyFilePath: `/gcp_key.json` the key path of GCP JSON Private Key, placed it to /config/ folder (releated path with config yml file).

## Default Processor
### FilterProcessor
- class: `FilterProcessor`, no need to chane, it's point to lib/Processors/`FilterProcessor`.rb
- enable: true/false enable this Processor or Not
- keywordsInclude: ["KEYWORD1","KEYWORD2"…] filter out the Review that contains those keywords
- ratingsInclude: [1,2…] 1~5 filter out the Review that contains rating
- territoriesInclude: ["zh-hant","TWN"…] filter out the Review that from those territories (Territor(TWN/JPN...) for Apple / Language(zh-hant,en...) For Android)

### GoogleTranslateProcessor
- class: `GoogleTranslateProcessor`, no need to chane, it's point to lib/Processors/`GoogleTranslateProcessor`.rb
- enable: true/false enable this Processor or Not
- googleTranslateAPIKeyFilePath: `/gcp_key.json` Google Translate GCP Service Account JSON Private Key File Path `*.json`,placed it to /config/ folder (releated path with config yml file)
- make sure the service account have the right access(Google Translate API)
- googleTranslateTargetLang: `zh-TW` Target translated language
- googleTranslateTerritoriesExclude: ["zh-hant","TWN"…] (Territor(TWN/JPN...) for Apple or Language(zh-hant,en...) For Android review that didn't need to translate.

### SlackProcessor
- class: `SlackProcessor`, no need to chane, it's point to lib/Processors/`SlackProcessor`.rb
- enable: true/false enable this Processor or Not
- slackTimeZoneOffset: `+08:00` timezone of display review created time
- slackAttachmentGroupByNumber: `1` specify how many Reviews will group by in same Slack Message (in Attacment)
- slackBotToken: `xoxb-xxxx-xxxx-xxxx` [Slack Bot](https://slack.com/help/articles/115005265703-Create-a-bot-for-your-workspace) Token
- slackBotTargetChannel: `CXXXXXX` Channel ID (Not Channel Name), and you need to add Slack Bot to this Channel
- slackInCommingWebHookURL: `https://hooks.slack.com/services/XXXXX` the old send message to slack way, will deprecated.
```
Please note, this is a legacy custom integration - an outdated way for teams to integrate with Slack. These integrations lack newer features and they will be deprecated and possibly removed in the future. We do not recommend their use. Instead, we suggest that you check out their replacement: Slack apps.
```
ZReviewTender will use slackBotToken by default.

![1_D1kt_6jH0UaJo2kvf9l5Qw (1)](https://user-images.githubusercontent.com/33706588/183836286-2a8d8bce-432e-4962-a24c-d6e09e6601ea.png)

![1_UjE_LxtZ0adwS6tr2-vgbw](https://user-images.githubusercontent.com/33706588/183836304-a968b42a-c9ed-4edc-a8f1-34e458d5ab26.png)

### GoogleSheetProcessor
- class: `GoogleSheetProcessor`, no need to chane, it's point to lib/Processors/`GoogleSheetProcessor`.rb
- enable: true/false enable this Processor or Not
- googleSheetAPIKeyFilePath: `/gcp_key.json` Google Sheet GCP Service Account JSON Private Key File Path `*.json`,placed it to /config/ folder (releated path with config yml file)
- make sure the service account have the right access(Google Translate API)
- googleSheetTimeZoneOffset: `+08:00` timezone of display review created time
- googleSheetInsertStyle.type: "append" # Google Sheet Insert type, append or insert
- googleSheetInsertStyle.at: 0 # required if type is insert, where index should insert at
- googleSheetInsertStyle.sheetID: null # required if type is insert, the sheet ID, you can get it on google sheet url: e.g. https://docs.google.com/spreadsheets/d/googleSpreadsheetID/edit#gid=sheetID
- googleSheetInsertStyle.sheetName: "Sheet1" # required if type is append, a.k.a google sheet tab name
- values: [] # Columns Data you can uses magic variable below to compose string.
```
%TITLE% for review's title
%BODY% for review's content
%RATING% for review's rating 1~5
%PLATFORM% for review's platform Apple or Android
%ID% for review's ID
%USERNAME% for review's reviewer username
%URL% for link to review
%TERRITORY% for review's territory (language for android e.g. zh-Hant, en)
%APPVERSION% for review's reviewer app version
%CREATEDDATE% for review's created date
```
- keywordsInclude: ["KEYWORD1","KEYWORD2"…] filter out the Review that contains those keywords you want's log to google sheet
- ratingsInclude: [1,2…] 1~5 filter out the Review that contains rating you want's log to google sheet
- territoriesInclude: ["zh-hant","TWN"…] filter out the Review that from those territories you want's log to google sheet (Territor(TWN/JPN...) for Apple / Language(zh-hant,en...) For Android)

*make sure you have add service account to your google sheet collaborate with edit permission.

### Custom Processor
1. Clone this repo project (due to ZReviewTedner is a completely Gem, you can't modify it dynamically)
2. Reference [Processor.rb](https://github.com/ZhgChgLi/ZReviewTender/blob/main/lib/Processors/ProcessorTemplate.rb), make a copy and devlop the feature you want

`initialize`
- `config`: config yml parameter
- `configFilePath`: config yml file path
- `baseExecutePath` the path that user execute ZReviewTender

`processReviews(reviews, platform)`
- Input Function 
- you will receive latest reviews list, you can decide what you want to do, e.g. transform or filter...
- Review Struct: [lib/Models/Review.rb](https://github.com/ZhgChgLi/ZReviewTender/blob/main/lib/Models/Review.rb)
- Remember return the result reviews, for next Processor uses

3. Add your Processor & Processor Parameter needed to config.yml, `processors:` section
4. Test & Run!
5. Done!

*processors are data flow chain and sort sensitive.

### If you don't need Some Processor (like Google Translate Processor)

- set `enable` to `false` or just remove that Processor Setting Block in config yml

# Usage

if you're not install with Gems, you should use `bundle exec ruby bin/ZReviewTender` to excute.

**Generate config yml file**
```
ZReviewTender -i
```
will generate apple.yml and android.yml in config/ folder.

**Check Both Apple & Android App's latest Reviews**
```
ZReviewTender -r
```
will uses `apple.yml` and `android.yml` in `config` folder.

**Check Both Apple & Android App's latest Reviews, specify Config YAML file path**
```
ZReviewTender --run=CONFIG_FOLDER
```

**Check Apple App's latest Reviews**
```
ZReviewTender -a
```
will uses `apple.yml` in `config` folder.

**Check Apple App's latest Reviews, specify Config YAML file path**
```
ZReviewTender --apple=PATH_TO_APPLE_CONFIG_YAML_FILE
```

**Check Android App's latest Reviews**
```
ZReviewTender -g
```
will uses `android.yml` in `config` folder.

**Check Android App's latest Reviews, specify Config YAML file path**
```
ZReviewTender --googleAndroid=PATH_TO_ANDROID_CONFIG_YAML_FILE
```

**Clean last check timestamp log(back to init state)**
```
ZReviewTender -d
```

**Show current ZReviewTender version**
```
ZReviewTender -v
```

**Upgrade ZReviewTender to latest release version(only RubyGem)**
```
ZReviewTender -n
```

## Init (first time execute)

![1_62VO8mbJWxXHSeFo3fEUog](https://user-images.githubusercontent.com/33706588/183838813-4f8f3caa-b62d-42a1-a1e2-945a758de8a9.png)

you will received an init success message in your Slack Channel!


### latestCheckTimestamp folder & execute.log:

![1_U8vjWSHvY2RzUBcUbQoBvQ](https://user-images.githubusercontent.com/33706588/183839283-bd836917-f4a9-467e-97ff-238d947c2fad.png)

ZReviewTender will also created latestCheckTimestamp/Apple, latestCheckTimestamp/Android to log ZReviewTender latest checked Review Timestamp and created execute.log for log excute error.

![image](https://user-images.githubusercontent.com/33706588/184472442-3bc390d2-c4c0-4eec-8dc2-f8061124e870.png)


## Setup a crontab schedule job to excute(Check latest Review & Process) periodicity
- You could use crontab or any schedule service to execute ZReviewTender periodicity
- e.g. in crontab: `15 */6 * * * ZReviewTender -r`
- please note that, google api only allow retrieve the reviews that users have created or modified within the last week, so could not set the time period more than one week.

[![image](https://user-images.githubusercontent.com/33706588/185638179-39d9fc09-e0c7-4164-864a-0f13e1b7df3f.png)](https://github.com/marketplace/actions/zreviewtender-app-reviews-automatic-bot)

## Github Action
![image](https://user-images.githubusercontent.com/33706588/185739638-25f145b8-e2a8-4146-9b4d-688c7ddc75ac.png)

[ZReviewTender App Reviews Automatic Bot](https://github.com/marketplace/actions/zreviewtender-app-reviews-automatic-bot)

```
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
you can change command to others ZReviewTender's command.

# ⚠️️️️️ Attention
⚠️️️️️ MUST KEEP YOUR CREDENTIAL FILES SAFE, DO NOT EXPOSE ON THE INTERNET. ⚠️️️️️

## Disclaimer
This repository is for research purposes only, the use of this code is your responsibility.

- Code authors take NO responsibility and/or liability for how you choose to use any of the source code available here.
- By using any of the files available in this repository, you understand that you are AGREEING TO USE AT YOUR OWN RISK.
- ALL files available here are for EDUCATION and/or RESEARCH purposes ONLY.


## Who is using
[![pinkoi](https://user-images.githubusercontent.com/33706588/221343295-3e3831e6-f76d-430a-87e3-4daf9815297d.jpg)](https://en.pinkoi.com)

[Pinkoi.com](https://en.pinkoi.com) is Asia's leading online marketplace for original design goods, digital creations, and workshop experiences.

## About
- [ZhgChg.Li](https://zhgchg.li/)
- [ZhgChgLi's Medium](https://blog.zhgchg.li/)

## Other works
### Swift Libraries
- [ZMarkupParser](https://github.com/ZhgChgLi/ZMarkupParser) is a pure-Swift library that helps you to convert HTML strings to NSAttributedString with customized style and tags.
- [ZPlayerCacher](https://github.com/ZhgChgLi/ZPlayerCacher) is a lightweight implementation of the AVAssetResourceLoaderDelegate protocol that enables AVPlayerItem to support caching streaming files.
- [ZNSTextAttachment](https://github.com/ZhgChgLi/ZNSTextAttachment) enables NSTextAttachment to download images from remote URLs, support both UITextView and UILabel.

### Integration Tools
- [ZReviewTender](https://github.com/ZhgChgLi/ZReviewTender) is a tool for fetching app reviews from the App Store and Google Play Console and integrating them into your workflow.
- [ZMediumToMarkdown](https://github.com/ZhgChgLi/ZMediumToMarkdown) is a powerful tool that allows you to effortlessly download and convert your Medium posts to Markdown format.

# Donate

[![Buy Me A Coffe](https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20beer!&emoji=%F0%9F%8D%BA&slug=zhgchgli&button_colour=FFDD00&font_colour=000000&font_family=Bree&outline_colour=000000&coffee_colour=ffffff)](https://www.buymeacoffee.com/zhgchgli)

If you find this library helpful, please consider starring the repo or recommending it to your friends.

Feel free to open an issue or submit a fix/contribution via pull request. :)
