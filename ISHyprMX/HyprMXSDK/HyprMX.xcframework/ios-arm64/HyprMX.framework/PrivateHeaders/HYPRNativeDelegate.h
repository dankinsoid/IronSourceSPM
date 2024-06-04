//
//  HYPRNativeDelegate.h
//  HyprMX-Framework
//
#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol HYPRLaunchBrowserDelegate <JSExport>
@required
- (void)showHyprMXBrowser:(NSString *)identifier;
- (void)showPlatformBrowser:(NSString *)url;
@optional
- (void)hyprMXBrowserClosed;
@end

@protocol HYPRActivityEventDelegate <JSExport>
- (void)createCalendarEvent:(NSString *)data;
- (void)storePicture:(NSString *)url;
- (void)openOutsideApplication:(NSString *)url;
@end

@protocol HYPRAppJSEventDelegate <JSExport>
@required
- (void)showDialog:(NSString *)jsonConfiguration;
@end

@protocol HYPRStoreKitEventDelegate <JSExport>
@required
- (void)showAppStore:(NSString *)appStoreParameters;
@end


@protocol HYPRMraidNativeDelegate <JSExport>
@required
- (void)useCustomClose:(BOOL)isCustomCloseEnabled;
- (void)setOrientationProperties:(BOOL)allowOrientationChange :(NSString *)forceOrientationChange;
@end

@protocol HYPROpenMeasurementNativeDelegate <JSExport>
@required
- (void)endOMSession;
- (void)startOMSession:(NSString *)args;
@end
