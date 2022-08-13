![ZReviewTender](https://user-images.githubusercontent.com/33706588/184416535-7085e6be-65a1-4bfd-af86-40ec77b0a709.png)

ZReviewTender uses brand new App Store & Google Play API to fetch App reviews and integration your workflow.

- [\[CH Readme\] ZReviewTender - 免費開源的 App Reviews 監控機器人](https://medium.com/p/e36e48bb9265)

[![ZReviewTender](https://badge.fury.io/rb/ZReviewTender.svg)](https://rubygems.org/gems/ZReviewTender)
[![ZReviewTender](https://ruby-gem-downloads-badge.herokuapp.com/ZReviewTender?color=green&type=total&total_label=Total-downloads&label=ZReviewTender@RubyGem)](https://rubygems.org/gems/ZReviewTender)

# Features
- [x] Support fetch App Store (iOS App/Mac OS App...) Reviews
- [x] [Default Processor] Resend newst Reviews to specify Slack Channel
- [x] [Default Processor] Auto-translate Review's content to your language by Google Translate
- [x] Flexible extension, you can develop your own Processor(a.k.a plugin) for suit your workflow.
- [x] Lightweight implementation, only log latest review timestamp, not save all reviews in local storage.
- [x] Support Filter, you can add custom filter condition to filter out which reviews you need
- [x] Based on Official API(AndroidpublisherV3 & [Brand New AppStoreConnect API](https://developer.apple.com/news/?id=yqf4kgwb)), no more workaround or [session expired](https://docs.fastlane.tools/getting-started/ios/authentication/)
- [x] Quick depoly with Github Repo Template/Github Action
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

## Strongly Recommended

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

Follow the [GCP Started Document](https://developers.google.com/android-publisher/getting_started) to created a Google Cloud Project and linked it to your Google Play Console, enable Google Play Android Developer API in Google Play Console -> Setup -> API Access.

![1_yQhAVOuF_CvM49Vayl40zA](https://user-images.githubusercontent.com/33706588/183833645-b2071d6b-d3c5-4841-8293-ce6c07a69098.png)

![1_-AKvlk9P6R0YkuZwsXJaLA](https://user-images.githubusercontent.com/33706588/183833654-b0889e82-c8d0-4b2b-92ab-0f8f953d5c5b.png)

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
- googleTranslateAPIKeyFilePath: `/gcp_key.json` Google Translate GCP JSON Private Key File Path `*.json`,placed it to /config/ folder (releated path with config yml file)
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

### \[Demo Custom Processor\] LogAppIssueProcessor

#### /lib/Processors/LogAppIssueProcessor.rb:

Goal: log review that rating is less than 5 to google sheet.

```ruby
#$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "Models/Review"
require "Models/Processor"
require "Helper"
require "ZLogger"

require "pathname"
require "google_drive"


class LogAppIssueProcessor < Processor

    attr_accessor :client, :googleSheetIndex, :timeZoneOffset

    def initialize(config, configFilePath, baseExecutePath)
        # init Processor
        # get paraemter from config e.g. config["parameter1"]
        # configFilePath: file path of config file (apple.yml/android.yml)
        # baseExecutePath: user excute path


        keyFilePath = Helper.unwrapRequiredParameter(config, "googleSheetAPIKeyFilePath")
        googleSheetKey = Helper.unwrapRequiredParameter(config, "googleSheetID")
        
        if Pathname.new(keyFilePath).absolute?
            configDir = File.dirname(configFilePath)
            keyFilePath = "#{configDir}#{keyFilePath}"
        end
        
        @timeZoneOffset = Helper.unwrapRequiredParameter(config, "googleSheetTimeZoneOffset")
        @googleSheetIndex = Helper.unwrapRequiredParameter(config, "googleSheetIndex")
        @client = GoogleDrive::Session.from_service_account_key(keyFilePath).spreadsheet_by_key(googleSheetKey)
    end

    def processReviews(reviews, platform)
        if reviews.length < 1
            return reviews
        end
        
        sheet = client.worksheets[googleSheetIndex]
    
        if !sheet.nil?
            lowReviews = reviews.select{ |review| review.rating < 5 }.reverse()
            rows = []
            lowReviews.each do |review|
                rows.append(["商城評價",review.rating,"#{review.title}\n#{review.body}",review.appVersion,Time.at(review.createdDateTimestamp).getlocal(timeZoneOffset)])
                # 商城評價, 3, 評價標題-評價內容, 4.5.0, 2022-08-08 10:00:05
            end
            
            if rows.length > 0
                sheet.insert_rows(0, rows)
                sheet.save
            end
        end

        return reviews
    end
end
```

#### apple/android.yml:

```ruby
platform: 'apple'
appStoreConnectP8PrivateKeyFilePath: '/AuthKey_XXXXXX.p8'
appStoreConnectP8PrivateKeyID: 'XXXXXX'
appStoreConnectIssueID: 'XXXXXX-XXXXXX-XXXXXX-XXXXXX-XXXXXX'
appID: 'XXXXXX'
processors:
    - FilterProcessor:
        class: "FilterProcessor"
        enable: true
        keywordsInclude: []
        ratingsInclude: []
        territoriesInclude: []
    - GoogleTranslateProcessor:
        class: "GoogleTranslateProcessor"
        enable: true
        googleTranslateAPIKeyFilePath: '/gcp_key.json'
        googleTranslateTargetLang: 'zh-TW'
        googleTranslateTerritoriesExclude: ["TWN","CHN"]
    - SlackProcessor:
        class: "SlackProcessor"
        enable: true
        slackTimeZoneOffset: "+08:00"
        slackAttachmentGroupByNumber: "1"
        slackBotToken: "xoxb-XXXXXX-XXXXXX-XXXXXX"
        slackBotTargetChannel: "CXXXXXX"
        slackInCommingWebHookURL: null
    - LogAppIssueProcessor:
        class: "LogAppIssueProcessor"
        enable: true
        googleSheetAPIKeyFilePath: '/gcp_key.json'
        googleSheetID: 'XXXXXX'
        googleSheetIndex: 0
        googleSheetTimeZoneOffset: "+08:00"
```

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


## latestCheckTimestamp folder & execute.log

![1_U8vjWSHvY2RzUBcUbQoBvQ](https://user-images.githubusercontent.com/33706588/183839283-bd836917-f4a9-467e-97ff-238d947c2fad.png)

ZReviewTender will also created latestCheckTimestamp/Apple, latestCheckTimestamp/Android to log ZReviewTender latest checked Review Timestamp and created execute.log for log excute error.

![image](https://user-images.githubusercontent.com/33706588/184472442-3bc390d2-c4c0-4eec-8dc2-f8061124e870.png)

# ⚠️️️️️ Attention
⚠️️️️️ MUST KEEP YOUR CREDENTIAL FILES SAFE, DO NOT EXPOSE ON THE INTERNET. ⚠️️️️️

## Disclaimer
This repository is for research purposes only, the use of this code is your responsibility.

- Code authors take NO responsibility and/or liability for how you choose to use any of the source code available here.
- By using any of the files available in this repository, you understand that you are AGREEING TO USE AT YOUR OWN RISK.
- ALL files available here are for EDUCATION and/or RESEARCH purposes ONLY.


## List of companies that use ZReviewTender
[![ZhgChgLi_2022-08-07_22-09-59](https://user-images.githubusercontent.com/33706588/183295003-6ba388d3-86a3-4dd1-a1ed-a122deebda0e.jpg)](https://www.pinkoi.com)

## More Tools
- [ZMediumToMarkdown](https://github.com/ZhgChgLi/ZMediumToMarkdown) lets you download Medium post and convert it to markdown format easily.

## Made In Taiwan 🇹🇼🇹🇼🇹🇼
- [ZhgChg.Li (CH)](https://zhgchg.li/)
- [ZhgChgLi's Medium (CH)](https://blog.zhgchg.li/)


[![Buy Me A Coffe](https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20beer!&emoji=%F0%9F%8D%BA&slug=zhgchgli&button_colour=FFDD00&font_colour=000000&font_family=Bree&outline_colour=000000&coffee_colour=ffffff)](https://www.buymeacoffee.com/zhgchgli)

If this is helpful, please help to star the repo or recommend it to your friends.

Please feel free to open an Issue or submit a fix/contribution via Pull Request. :)
