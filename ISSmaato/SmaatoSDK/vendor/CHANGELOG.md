# Changelog for Open Measurement SDK on iOS

## 1.4.2 - 2022-11-11
- Reset injection ID after script runs for native sessions.

## 1.4.1 - 2022-10-25
- Fix layout constraints in tvOS Demo App.
- Update License for Native-App Measurement, V 1.1
- Update docs for video ad impression. 

## 1.4.0 - 2022-09-30
OM SDK 1.4.0 is a significant update. It adds support for CTV.
[Implement CTV-related features](https://iabtechlab.com/wp-content/uploads/2022/08/OMSDK_What-is-new-in-1.4_master.pdf)

### CTV Update
- Update iOS SDK to support tvOS SDK.
- Add Device Category to iOS SDK.
- Add Last Activity Tracking for tvOS.
- Support outputDeviceStatus on iOS/tvOS.
- Activate OM SDK on launch in OM-tvOS-TestApp.
- Include tvOS SDK and app in iOS SDK export.
- Update documentation for OM SDK for CTV.
### Other Update
- Add initial E2E test using OM-TestApp.
- Fix verification parameters for native-type ad sessions.

## 1.3.37 - 2022-08-22
- Update OCMock to 3.9.1 / Clean up tests.
- Update verificationScriptURL and ad reference urls. 

## 1.3.36 - 2022-07-15
- Remove assertions on window container.
- Throttle JSTimer to one second intervals in the background.

## 1.3.34 - 2022-05-03
- Update version to match JS SDK; no changes from 1.3.33

## 1.3.33 - 2022-04-27
- Update version to match JS SDK; no changes from 1.3.32

## 1.3.32 - 2022-04-19
- Update version to match JS SDK; no changes from 1.3.31 

## 1.3.31 - 2022-03-01
- Update version to match JS and Android SDKs; no changes from 1.3.30 

## 1.3.30 - 2022-02-18
- Fix potential crash when loading JavaScript resources in native display and video sessions.

## 1.3.29 - 2022-01-24
- Update version to match JS and Android SDKs; no changes from 1.3.28

## 1.3.28 - 2021-12-14
- Update version to match Android SDK; no changes from 1.3.27

## 1.3.27 - 2021-11-17
- Update version to match JS Service; no changes from 1.3.26

## 1.3.26 - 2021-10-22
- Update version to match JS Service; no changes from 1.3.25

## 1.3.25 - 2021-09-24
- Update version to match JS Service; no changes from 1.3.24

## 1.3.24 - 2021-09-16
- Update version to match JS and Android SDKs; no changes from 1.3.23

## 1.3.23 - 2021-08-18
- Fixed crash with invalid script.

## 1.3.22 - 2021-07-23
- Update validation doc.

## 1.3.21 - 2021-06-24
- Refine caching policies in OMIDLoadTask

## 1.3.20 - 2021-05-25
- Update version to match JS Service; no changes from 1.3.19

## 1.3.19 - 2021-05-07
### Update
- Update Simulator to iPhone 11 and iOS 14.2

## 1.3.18 - 2021-04-14 
### Fixed
- Fix Dynamic Framework's CFBundleIdentifier to be namespaced

## 1.3.17 - 2021-03-10 
- Add static XCFramework integration option

## 1.3.16 - 2021-02-04
- Fix missing support for i386 & armv7 architectures

## 1.3.15 - 2020-12-18
- Add xcframework integration option to distribution archive
- Utilize new xcframework integration option in OM-Demo
- Include omsdk-v1.js by default in OM-Demo

## 1.3.13 - 2020-11-04
- Update version to match JS and Android SDKs; no changes from 1.3.12

## 1.3.12 - 2020-10-06
- Update version to match JS and Android SDKs; no changes from 1.3.11


## 1.3.11 - 2020-09-24
- Update version to match JS and Android SDKs; no changes from 1.3.10


## 1.3.10 - 2020-08-12
- Update version to match JS and Android SDKs; no changes from 1.3.9

## 1.3.9 - 2020-07-31
### Update
- Add Javascript ad session to reference app
- Increase WebView size to show complete HTML content

## 1.3.8 - 2020-07-16
### Update
- Enforce calling addFriendlyObstruction:purpose:detailedReason:error: on the main thread via returning an error

## 1.3.7 - 2020-06-30
### Update
- Reference app now uses HTML creatives from hosted links

## 1.3.6 - 2020-06-04
### Fixed
- Fix obstruction reporting on iPadOS when multitasking

## 1.3.5 - 2020-05-07
### Fixed
- Foreground/background state detection on iPadOS when multitasking

## 1.3.4 - 2020-04-23
### Removed
- `UIWebView` internal support has been removed. 
- `OMIDAdSessionContext` initializers are now constrained to `WKWebView`.

The following features changed their API from OM SDK 1.2 to 1.3.  The old 1.2 APIs have been removed from this release.

- Method `-[OMIDSDK activateWithOMIDAPIVersion:error:]` replaced by `-[OMIDSDK activate]`.
- Method `-[OMIDSDK isCompatibleWithOMIDAPIVersion:]` is no longer needed.
- Method `-[OMIDAdSessionContext initWithPartner:script:resources:customReferenceIdentifier:error:]` replaced by `-[OMIDAdSessionContext initWithPartner:script:resources:contentUrl:customReferenceIdentifier:error:]`.
- Method `-[OMIDAdSessionContext initWithPartner:webView:customReferenceIdentifier:error:]` replaced by `-[OMIDAdSessionContext initWithPartner:webView:contentUrl:customReferenceIdentifier:error:`.
- Methods `-[OMIDAdSessionConfiguration initWithImpressionOwner:videoEventsOwner:isolateVerificationScripts:error:]` and `-[OMIDAdSessionConfiguration initWithImpressionOwner:videoEventsOwner:error:]` replaced by `-[OMIDAdSessionConfiguration initWithCreativeType:impressionType:impressionOwner:mediaEventsOwner:isolateVerificationScripts:]`.
- Method `-[OMIDAdSession addFriendlyObstruction:]` replaced by `-[OMIDAdSession addFriendlyObstruction:purpose:detailedReason:error:]`.
- Methods `[OMIDMediaEvents loadedWithVastProperties:error:]` and `[OMIDVideoEvents loadedWithVastProperties:error:]` replaced by `[OMIDAdEvents loadedWithVastProperties:error:]`.
- Class `OMIDVideoEvents` replaced by `OMIDMediaEvents`.

## 1.3.3 - 2020-04-15
### Fixed
- Prevent crash with JS timers in native ad session by ensuring all JS operations occur on a single GCD queue.

## 1.3.2 - 2020-04-02
### Deprecated
The following features changed their API from OM SDK 1.2 to 1.3.  The old 1.2 APIs are still functional but are deprecated in this release; they will be removed in 1.3.4.

- Method `-[OMIDSDK activateWithOMIDAPIVersion:error:]` replaced by `-[OMIDSDK activate]`.
- Method `-[OMIDSDK isCompatibleWithOMIDAPIVersion:]` is no longer needed.
- Method `-[OMIDAdSessionContext initWithPartner:script:resources:customReferenceIdentifier:error:]` replaced by `-[OMIDAdSessionContext initWithPartner:script:resources:contentUrl:customReferenceIdentifier:error:]`.
- Method `-[OMIDAdSessionContext initWithPartner:webView:customReferenceIdentifier:error:]` replaced by `-[OMIDAdSessionContext initWithPartner:webView:contentUrl:customReferenceIdentifier:error:`.
- Method `-[OMIDAdSessionConfiguration initWithImpressionOwner:videoEventsOwner:isolateVerificationScripts:error:]` replaced by `-[OMIDAdSessionConfiguration initWithCreativeType:impressionType:impressionOwner:mediaEventsOwner:isolateVerificationScripts:]`.
- Method `-[OMIDAdSession addFriendlyObstruction:]` replaced by `-[OMIDAdSession addFriendlyObstruction:purpose:detailedReason:error:]`.
- Methods `[OMIDMediaEvents loadedWithVastProperties:error:]` and `[OMIDVideoEvents loadedWithVastProperties:error:]` replaced by `[OMIDAdEvents loadedWithVastProperties:error:]`.
- Class `OMIDVideoEvents` replaced by `OMIDMediaEvents`.

### Obsolete
- Passing UIWebView to OMIDAdSessionContext initializers is obsolete but still functional.
   All support for UIWebView will removed in version 1.3.4.

### iOS Reference App
- The iOS reference app sample code is now included in the SDK distribution archive (see README for details).
- New "HTML Video" example for webview video player integration.
- The Open Measurement iOS Reference App github repo will no longer be updated.

## 1.3.1 - 2020-01-09
### Changed
- Remove static references to deprecated UIWebView class.

## 1.3.0 - 2019-12-17
OM SDK 1.3 is a signficant update.  It adds support for some key new use cases for OMID 1.3 while allowing scripts using OMID 1.2 to run correctly.  Integrations (apps and SDKs) using OM SDK will need to make code changes.  See the [Migration Guide](docs/migration.md) for details.

### Changed
The following features changed their API from OM SDK 1.2 to 1.3.  The old 1.2 APIs are still functional but obsolete in this release; they will be deprecated in OM SDK 1.3.2 and removed in 1.3.4.

- Method `-[OMIDSDK activateWithOMIDAPIVersion:error:]` replaced by `-[OMIDSDK activate]`
- Method `-[OMIDAdSessionContext initWithPartner:script:resources:customReferenceIdentifier:error:]` replaced by `-[OMIDAdSessionContext initWithPartner:script:resources:contentUrl:customReferenceIdentifier:error:]`
- Method `-[OMIDAdSessionContext initWithPartner:webView:customReferenceIdentifier:error:]` replaced by `-[OMIDAdSessionContext initWithPartner:webView:contentUrl:customReferenceIdentifier:error:`
- Method `-[OMIDAdSessionConfiguration initWithImpressionOwner:videoEventsOwner:isolateVerificationScripts:error:]` replaced by `-[OMIDAdSessionConfiguration initWithCreativeType:impressionType:impressionOwner:mediaEventsOwner:isolateVerificationScripts:]`
- Method `-[OMIDAdSession addFriendlyObstruction:]` replaced by `-[OMIDAdSession addFriendlyObstruction:purpose:detailedReason:error:]`
- Method `[OMIDVideoEvents loadedWithVastProperties:error:]` replaced by `[OMIDAdEvents loadedWithVastProperties:error:]`
- Class `OMIDVideoEvents` replaced by `OMIDMediaEvents`

### Added
- Method `[OMIDAdSessionContext initWithPartner:javaScriptWebView:customReferenceIdentifier:error:]`
- Method `[OMIDAdEvents loadedWithError:]`

### Obsolete
The following feature is still present but obsolete in OM SDK 1.3.0.  It will be deprecated in OM SDK 1.3.2 and removed in 1.3.4.

- Method `-[OMIDSDK isCompatibleWithOMIDAPIVersion:]`

## 1.2.22 - 2019-12-01 
- Native changes for JS fix to handle resource level access mode properly

## 1.2.21 - 2019-11-11
- Refactor async tests using XCTestExpectation

## 1.2.20 - 2019-09-30
- Update version to match JS and Android SDKs; no changes from 1.2.19

## 1.2.19 - 2019-09-10
- Update to accurately report 'hidden' or 'notFound' for non visible ad views and include geometry.
- Must use with OMSDK JS 1.2.18 or above.	
- Remove static references to deprecated UIWebView class.  
- OM SDK continues to support integrations that use UIWebView, and it does so
  in a way that doesn't trigger App Store warnings for integrations that use
  only WKWebView.

## 1.2.18 - 2019-08-29
- Update version to match JS and Android SDKs; no changes from 1.2.17

## 1.2.17 - 2019-07-22
- Update version to match JS and Android SDKs; no changes from 1.2.16

## 1.2.16 - 2019-06-24
- Update version to match JS and Android SDKs; no changes from 1.2.15

## 1.2.15 - 2019-05-24
### Fixed
-Ensure xcode version and iOS version are compatible for CI tests

## 1.2.14 - 2019-04-22

### Fixed
- Prevent crash when bad values are sent to JavaScript service.

## 1.2.13 - 2019-03-22
### Fixed
- Wrap error parameters in quotes

## 1.2.12 - 2019-02-13
### Fixed
- Updated headers and internals to remove duplication of property declarations

## 1.2.11 - 2019-01-23
### Fixed
- Code quality improvements: replace uses of __unsafe_unretained and casts from pointer to integer.

## 1.2.8 - 2018-11-30
### Fixed
- Fix crash during iteration over array of active sessions.
- Minor reformatting of methods to match coding guidelines, and addition of file generated by Xcode 9.4.

## 1.2.7 - 2018-11-27
### Fixed
- Assign copies of mutable objects to properties
- Replace property calls in init methods with direct access to fields
- Use [NSDictionary objectForKey:] instead of [NSKeyValueCoding valueForKey:]

## 1.2.6 - 2018-11-01
### Fixed
- Detect visibility of ads after dismissing Airplay options view.
- Method 'activateWithOMIDAPIVersion:error:' no longer checks compatibility with API version passed as parameter.

### Changed
- Named all dispatch queues to help integrators debug.

## 1.2.5 - 2018-10-10
- Update version to match JS and Android SDKs; no changes from 1.2.4

## 1.2.4 - 2018-08-29
- Update version to match JS and Android SDKs; no changes from 1.2.3

## 1.2.3 - 2018-08-17
- Update version to match JS and Android SDKs; no changes from 1.2.2

## 1.2.2 - 2018-08-02
- Update version to match JS and Android SDKs; no changes from 1.2.1

## 1.2.1 - 2018-07-18
- Update version to match JS and Android SDKs; no changes from 1.2.0

## 1.2.0 - 2018-07-03
### Removed
- Remove restriction that impression event must be sent before other events can be sent.

## 1.1.4 - 2018-06-20
- Update version to match JS and Android SDKs; no changes from 1.1.3.

## 1.1.3 - 2018-05-30

### Update
- Update iOS docs with information on potential side-effects of the API.

### Fixed
- Fix update-version-number script to work on OSX and Linux.

## 1.1.2 - 2018-05-08
- Update version to match JS and Android SDKs; no changes from 1.1.1.

## 1.1.1 - 2018-04-24
- Update version to match JS and Android SDKs; no changes from 1.1.0.

## 1.1.0 - 2018-03-29
- First General Availability release of OM SDK for iOS.
