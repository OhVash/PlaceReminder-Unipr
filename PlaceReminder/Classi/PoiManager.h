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

@property (nonatomic, strong) NSMutableArray<Poi *> *poiList; // Lista dei poi
+ (instancetype)sharedManager; // Metodo per ottenere l'istanza condivisa

- (void)savePoi:(Poi *)poi; // Aggiunge un poi alla lista
- (void)removePoi:(Poi *)poi; // Rimuove poi dalla lista
- (NSMutableArray<Poi *> *)getAllPoi; // Restituisce tutti i poi
@end

NS_ASSUME_NONNULL_END
