//
//  ListViewController.h
//  PlaceReminder
//
//  Created by Alessandro Vascelli on 15/08/23.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "Poi.h"
#import "PoiManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
    
@property (nonatomic, strong) Poi *selectedPoi;

-(void) setupNotification;
-(void) updateData;

@end

NS_ASSUME_NONNULL_END
