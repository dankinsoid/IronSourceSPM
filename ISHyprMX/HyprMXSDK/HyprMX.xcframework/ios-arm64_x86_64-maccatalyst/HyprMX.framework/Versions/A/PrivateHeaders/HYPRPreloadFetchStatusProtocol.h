//
//  HYPRPreloadFetchStatusProtocol.h
//  HyprMX-Framework
//
#import <UIKit/UIKit.h>

@protocol HYPRPreloadFetchStatusProtocol <NSObject>
@required
/**
 * Fetch the list of preloaded offers
 * @param preloadOfferID - Specific offer Id to retreive - if nil, then all offer id's returned
 * @return The list of preloaded offers
 */
- (nonnull NSArray *)fetchPreloadedOffersForId:(nullable NSString*)preloadOfferID;

@end
