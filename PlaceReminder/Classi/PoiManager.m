//
//  PoiManager.m
//  PlaceReminder
//
//  Created by Alessandro Vascelli on 15/08/23.
//

#import "PoiManager.h"

@implementation PoiManager

+ (instancetype)sharedManager {
    static PoiManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PoiManager alloc] init];
        sharedInstance.poiList = [NSMutableArray array]; // Inizializza la lista dei segnaposti
    });
    return sharedInstance;
}

- (void)savePoi:(Poi *)poi {
    [self.poiList addObject:poi];
}

- (void)removePoiAtIndex:(NSUInteger)index {
    if (index < self.poiList.count) {
        [self.poiList removeObjectAtIndex:index];
    }
}

- (NSArray<Poi *> *)getAllPoi {
        NSArray<Poi *> *sortedPoiArray = [self.poiList sortedArrayUsingComparator:^NSComparisonResult(Poi *poi1, Poi *poi2) {
            return [poi2.timestamp compare:poi1.timestamp]; // Ordina dal più recente al meno recente
        }];
        
        return sortedPoiArray;
    }
@end
