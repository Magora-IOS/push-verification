
<p align="center" ><img src="readme/logo.png" title="Logo" float=left></p>

# push-verification

### Overview

`push-verification` is an iOS application to test push notifications.

![Preview](readme/preview.gif)

### Features
* Display device token
* Share device token using standard Sharing dialog
* Display received notifications
   * Payload
   * Date
* Keep notifications between application restarts


### Localization

Localization is located in [Google Sheet](https://goo.gl/k3Bgx9) and
generated by [sheet-localization](https://github.com/Magora-IOS/sheet-localization).

### Build

**Note**: the application uses NSPersistentContainer, which is only avaiable since iOS 10.

The build is tailored for Magora team:
* run `fastlane` in the project directory
* select `qa` to build for QA (the only option)

If you added a new device at Apple Developer portal, you need to regenerate QA profiles:
* run `fastlane` in the project directory
* select `prof_qa` to regenerate profiles

