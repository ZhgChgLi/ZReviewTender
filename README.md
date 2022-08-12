![ZReviewTender](https://user-images.githubusercontent.com/33706588/183299972-7d546eae-b7be-4006-974c-b878c5b46935.jpg)
ZReviewTender uses brand new App Store & Google Play API to fetch App reviews and integration your workflow.

- [\[CH Readme\] ZReviewTender - 免費開源的 App Reviews 監控機器人](https://medium.com/p/e36e48bb9265)

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

# Setup - Only need Default Proceesor(Slack/Filter/Google Translate)

## Strongly Recommended

- [Deploy with Gitub Repo Template](https://github.com/ZhgChgLi/ZReviewTender-deploy-with-github-action)

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

[Recommended] First, create a `config` folder to place all config releated files.

## Apple (iOS/macOS App)

1. Reference the [apple.example.yml](https://github.com/ZhgChgLi/ZReviewTender/blob/main/config/apple.example.yml) example config yaml file.
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

1. Download the [android.example.yml](https://github.com/ZhgChgLi/ZReviewTender/blob/main/config/android.example.yml) config yaml file.
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

### If you don't need Some Processor (like Google Translate Processor)

- set `enable` to `false` or just remove that Processor Setting Block in config yml

# Usage

if you're not install with Gems, you should use `bundle exec ruby bin/ZReviewTender` to excute.

**Check Both Apple & Android App's latest Reviews**
```
ZReviewTender -r
```
will uses `apple.yml` and `android.yml` in `config` folder.

**Check Apple App's latest Reviews**
```
bundle exec ruby bin/ZReviewTender -a
```
will uses `apple.yml` in `config` folder.

**Check Apple App's latest Reviews, specify Config YAML file path**
```
bundle exec ruby bin/ZReviewTender --apple=PATH_TO_APPLE_CONFIG_YAML_FILE
```

**Check Android App's latest Reviews**
```
bundle exec ruby bin/ZReviewTender -g
```
will uses `android.yml` in `config` folder.

**Check Android App's latest Reviews, specify Config YAML file path**
```
bundle exec ruby bin/ZReviewTender --googleAndroid=PATH_TO_ANDROID_CONFIG_YAML_FILE
```

## Init (first time execute)

![1_62VO8mbJWxXHSeFo3fEUog](https://user-images.githubusercontent.com/33706588/183838813-4f8f3caa-b62d-42a1-a1e2-945a758de8a9.png)

you will received an init success message in your Slack Channel!


## latestCheckTimestamp folder & execute.log

![1_U8vjWSHvY2RzUBcUbQoBvQ](https://user-images.githubusercontent.com/33706588/183839283-bd836917-f4a9-467e-97ff-238d947c2fad.png)

ZReviewTender will also created latestCheckTimestamp/Apple, latestCheckTimestamp/Android to log ZReviewTender latest checked Review Timestamp and created execute.log for log excute error.

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
