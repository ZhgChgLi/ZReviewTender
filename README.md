![ZReviewTender](https://user-images.githubusercontent.com/33706588/183299972-7d546eae-b7be-4006-974c-b878c5b46935.jpg)

# Features
- [x] Support fetch App Store (iOS App/Mac OS App...) Reviews
- [x] Support Google Console (Android App) Reviews
- [x] Support Filter, you can add custom filter condition to filter out which reviews you need
- [x] Base on Official API(`AndroidpublisherV3`, `AppStoreConnect API`), no more workaround or [session expired](https://docs.fastlane.tools/getting-started/ios/authentication/)
- [x] Flexible extension, you can develop your own Processor(a.k.a plugin) for suit your workflow.
- [x] Resend latest Review to your Slack Channel automatically.
- [x] Google Translate API Support, translate Review to your language automatically. (By Default)
- [x] Lightweight implementation, no local storage.

# To Do
- [ ] Documentation for How to create App Store Private Key & Google Console `android_publisher_key.json`
- [ ] Documentation for How to create custom Processor

# Result
![ZhgChgLi_2022-08-07_21-02-30](https://user-images.githubusercontent.com/33706588/183293375-c426d865-fedf-4ff9-9740-222e71dbda6b.jpg)

# Setup

## Strongly Recommended

- [\[FREE\] Deploy with Gitub Action](https://github.com/ZhgChgLi/ZReviewTender-deploy-with-github-action)

### Using Gem
#### If you are familiar with ruby:
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

### Manually
1. Clone this repo
2. Setup ruby environment
3. run `bundle install`
4. execute with `bundle exec bin/ZReviewTender`

# Configuration
1. Create a `config` folder
2. Download the [apple.example.yml](https://github.com/ZhgChgLi/ZReviewTender/blob/main/config/apple.example.yml) for Apple(iOS App/Mac OS App...) example config yaml file.
3. Download the [android.example.yml](https://github.com/ZhgChgLi/ZReviewTender/blob/main/config/android.example.yml) for Android App example config yaml file.
4. Fullfill the config value in config yaml file.
5. Place the dependency credentials file to `config` folder and use relative path to point path in config yaml file. e.g. `keyFilePath: '/android_publisher_key.json'`
6. Rename `android.example.yml` to `android.yml` and `apple.example.yml` to `apple.yml`
7. init ZReviewTender by execute `ZReviewTender -r`

⚠️ MAKE SURE KEE YOUR `config` folder contains credentials file (config.yml/private key..) SAFE, won't upload to the internet ⚠️

## Remove Google Translate Processor
If your don't need Google Translate Processor, you can remove it!

![image](https://user-images.githubusercontent.com/33706588/183294084-65b1fe12-f4c1-4713-94f9-512c87d41ebe.png)

just remove the Google Translate Processor code block, like above.

## Send Message to Slack Channel through Slack Bot or In-Comming WebHook?

Strongly Recommended **use Slack Bot** instead of In-Comming WebHook:
```
Please note, this is a legacy custom integration - an outdated way for teams to integrate with Slack.
These integrations lack newer features and they will be deprecated and possibly removed in the future.
We do not recommend their use.
Instead, we suggest that you check out their replacement: Slack apps.
```
message from [Slack](https://api.slack.com/messaging/webhooks#posting_with_webhooks).

System will detect if you've specify slack bot token, than it's ignore In-Comming WebHook.

#### Usage

**Check Both Apple & Android App's latest Reviews**
```
bundle exec ruby bin/ZReviewTender -r
```

**Check Apple App's latest Reviews**
```
bundle exec ruby bin/ZReviewTender -a
```

**Check Apple App's latest Reviews [Specify Config YAML File Path]**
```
bundle exec ruby bin/ZReviewTender --apple=PATH_TO_APPLE_CONFIG_YAML_FILE
```

**Check Android App's latest Reviews**
```
bundle exec ruby bin/ZReviewTender -g
```

**Check Android App's latest Reviews [Specify Config YAML File Path]**
```
bundle exec ruby bin/ZReviewTender --googleAndroid=PATH_TO_ANDROID_CONFIG_YAML_FILE
```

## Develop your custom Processor
- Manually this project (clone & install & modify)
- Copy [Processor.rb](https://github.com/ZhgChgLi/ZReviewTender/blob/main/lib/Processors/ProcessorTemplate.rb) and modify to the feature you want.
- Add your Processor to config.yml, insert in `processors:` section
- Test & Release!

*processors are sort sensitive.

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
