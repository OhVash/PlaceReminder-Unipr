//
//  DetailViewController.h
//  PlaceReminder
//
//  Created by Alessandro Vascelli on 22/08/23.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Poi.h"
#import "ListViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (nonatomic, strong) Poi *selectedPoi;
@property (nonatomic, assign) NSUInteger poiIndex;

- (void)setupDetails;

@end

NS_ASSUME_NONNULL_END
