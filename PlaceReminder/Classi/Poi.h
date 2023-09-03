//
//  Poi.h
//  PlaceReminder
//
//  Created by Alessandro Vascelli on 15/08/23.
//

#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Poi : NSObject
/*campi che identificano il punto di interesse
 * address = indirizzo sia in coordinate gps che via, civico, città ...
 * name = nome con il quale il poi è salvato
 * description = descrizione opzionale
 + timestamp = tiene conto di data e ora dell'ultima modifica (per ordinamento)
 */
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *poiDescription;
@property (nonatomic, strong) NSDate *timestamp;

// metodo per creare ed inizializzare un Poi
- (instancetype)initWithName:(NSString *)name
                     address:(NSString *)address
                 description:(NSString *)poiDescription
                   timestamp:(NSDate *)timestamp;

@end

NS_ASSUME_NONNULL_END
