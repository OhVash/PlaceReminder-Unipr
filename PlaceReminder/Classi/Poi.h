//
//  Poi.h
//  PlaceReminder
//
//  Created by Alessandro Vascelli on 15/08/23.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Poi : NSObject

@property (nonatomic, assign) CLLocationCoordinate2D location;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *poiDescription;
@property (nonatomic, strong) NSDate *timestamp;

- (instancetype)initWithName:(NSString *)name
                     address:(NSString *)address
                 description:(NSString *)poiDescription
                    location:(CLLocationCoordinate2D)location
                   timestamp:(NSDate *)timestamp;

@end

NS_ASSUME_NONNULL_END
