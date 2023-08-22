//
//  Poi.m
//  PlaceReminder
//
//  Created by Alessandro Vascelli on 15/08/23.
//

#import "Poi.h"

@implementation Poi

- (instancetype)initWithName:(NSString *)name
                     address:(NSString *)address
                 description:(NSString *)poiDescription
                    location:(CLLocationCoordinate2D)location
                   timestamp:(NSDate *)timestamp {
                        self = [super init];
                        if (self) {
                            _name = [name copy];
                            _address = [address copy];
                            _poiDescription = [poiDescription copy];
                            _location = location;
                            _timestamp = [timestamp copy];
                        }
                        return self;
}
@end
