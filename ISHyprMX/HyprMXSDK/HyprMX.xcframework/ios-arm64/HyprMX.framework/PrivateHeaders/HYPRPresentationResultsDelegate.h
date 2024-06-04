//
//  HYPRPresentationResultsDelegate.h
//  HyprMX-Framework
//
#import <UIKit/UIKit.h>
@class HYPRRequiredInformationCollectionViewController;
@protocol HYPRPresentationResultsDelegate <NSObject>

@required
- (void)adPresentationStartedForViewController:(UIViewController *)viewController;
- (void)controllerHasDeallocated:(UIViewController *)viewController;
- (void)viewControllerDidCancel:(UIViewController *)viewController;
- (void)viewControllerDidFinish:(UIViewController *)viewController;
- (void)adForViewController:(UIViewController *)viewController rewarded:(BOOL)isRewarded;
- (void)requiredInfoController:(UIViewController *)requiredInfoController didCompleteAnswers:(NSDictionary *)answerDictionary;
- (void)requiredInfoControllerDidCancel:(UIViewController *)requiredInfoController;
@end
