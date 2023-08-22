//
//  MapViewController.h
//  PlaceReminder
//
//  Created by Alessandro Vascelli on 10/08/23.
//

#import <UIKit/UIKit.h>
#import "Poi.h"
#import "PoiManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController
- (void)addPoiToMap:(Poi *)poi;
@end

NS_ASSUME_NONNULL_END
