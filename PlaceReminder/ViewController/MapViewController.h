//
//  MapViewController.h
//  PlaceReminder
//
//  Created by Alessandro Vascelli on 10/08/23.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import "Poi.h"
#import "PoiManager.h"
#import "HomeViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
- (void)addPoiToMap:(Poi *)poi;
@end

NS_ASSUME_NONNULL_END
