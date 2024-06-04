//
//  HYPRPresentationControllerResultDelegate.h
//  HyprMX-Framework
//
@class HyprMXPlacement;

@protocol HYPRPresentationControllerResultDelegate
- (void)rewardPlacement:(NSString *)placementName rewardName:(NSString *)rewardName rewardValue:(NSInteger)rewardValue;
- (void)finishPlacementPresentation:(HyprMXPlacement *)placement didFinish:(BOOL)finished;
- (void)adPresentationStartedForPlacement:(HyprMXPlacement *)placement;
- (void)adDisplayFailedForPlacement:(NSString *)placementName error:(NSString *)error;
@optional
- (void)completionOfRequiredInfoFormWithAnswers:(NSDictionary *)answers
                                      completion:(void (^)(NSDictionary *))completion;
@end
