//
//  PoiManager.h
//  PlaceReminder
//
//  Created by Alessandro Vascelli on 15/08/23.
//

#import <Foundation/Foundation.h>
#import "Poi.h"
#import "MapViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface PoiManager : NSObject

@property (nonatomic, strong) NSMutableArray<Poi *> *poiList; // Lista dei segnaposti
+ (instancetype)sharedManager; // Metodo per ottenere l'istanza condivisa

- (void)savePoi:(Poi *)poi; // Aggiunge un segnaposto alla lista
- (void)removePoiAtIndex:(NSUInteger)index; // Rimuove un segnaposto dalla lista
- (NSMutableArray<Poi *> *)getAllPoi; // Restituisce tutti i segnaposti
@end

NS_ASSUME_NONNULL_END
