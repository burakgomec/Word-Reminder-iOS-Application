# Word-Reminder-iOS-Application
**Word reminder is an open source learn languages & reminder translation application.**\
**Get notified of your saved words and translations with Word Reminder.**<br/><br/>
Translations between the following languages are supported: 
Turkish, English, German, French, French-Canada, Hindi, Hebrew, Portuguese, Traditional Chinese, Croatian, Hungarian, Montenegrin, Indonesian, Italian, Simplified Chinese, Japanese, Dutch, Finnish, Irish, Gujarati, Polish, Danish, Lithuanian, Latvian, Ukrainian, Urdu, Malayalam, Malay, Maltese, Greek, Spanish, Estonian, Norwegian, Vietnamese, Nepali, Romanian, Russian, Bulgarian, Bengali, Bosnian, Slovakian, Slovenian, Serbian, Korean, Swedish, Tamil, Czech, Telugu, Thai, Welsh, Catalan, Basque


## App Store Link
https://apps.apple.com/app/id1579382430

## Requirements
- iOS 13.4+
- iPhone, iPad and iPod touch Require iOS 13.4 or later.
- Mac Requires macOS 11.0 or later and a Mac with Apple M1 chip.

## 3rd Party Libraries(Pods)
**-pod 'IBMWatsonLanguageTranslatorV3', '~> 4.1.0**

## Usage
**It is powered by IBM Watson.**

**Firstly, you can view usage to API from https://cloud.ibm.com/apidocs/language-translator** 

**Then you can get a free(limited) API key from https://www.ibm.com/watson/services/language-translator**

**After that create a Keys.swift file at Utilities/Constants and it should looks like:**

```swift
class Keys{
    static let apiKey = "Your API Key"
    static let serviceURL = "Your Service URL"
    private init() {}
}
```

## Used Design Patterns
- Singleton: Used in CoreDataController, WebService, NotificationController classes
- Delegate: Two protocols created: LanguageDelegate, UpdatesDelegate. Search VC and Saved VC implement this protocols.

## Application's Mockups(iPhone 6.5" - iPad 12.9")

## Licence
[MIT](https://github.com/burakgomec/Word-Reminder-iOS-Application/blob/main/LICENSE)


