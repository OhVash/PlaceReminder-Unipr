//
//  MapViewController.m
//  PlaceReminder
//
//  Created by Alessandro Vascelli on 10/08/23.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSArray<Poi *> *poiList;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureMapView];
    self.mapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation]; // Inizia a monitorare la posizione dell'utente
}

- (void)configureMapView {
    // Imposta la regione per mostrare l'Italia intera
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(41.9028, 12.4964);
    MKCoordinateSpan span = MKCoordinateSpanMake(15.0, 15.0);
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, span);
    [self.mapView setRegion:region animated:YES];
    self.mapView.showsUserLocation = YES;
    // Aggiungo i Poi salvati alla mappa
    self.poiList = [PoiManager.sharedManager getAllPoi];
    for (Poi *poi in self.poiList) {
        [self addPoiToMap:poi];
        [self startMonitoringGeofenceForPoi:poi];
    } 
}

- (void)addPoiToMap:(Poi *)poi {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:poi.address
                 completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Geocoding error: %@", error.localizedDescription);
            return;
        }
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks.firstObject;
            CLLocation *location = placemark.location;
            
            // Aggiungi un pin per il Poi
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.coordinate = location.coordinate;
            annotation.title = poi.name; // Imposta il nome del poi come titolo del pin
            annotation.subtitle = poi.poiDescription;
            [self.mapView addAnnotation:annotation];
        }
    }];
}

- (void)startMonitoringGeofenceForPoi:(Poi *)poi {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:poi.address
                 completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Geocoding error: %@", error.localizedDescription);
            return;
        }
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks.firstObject;
            CLLocationCoordinate2D poiLocation = placemark.location.coordinate;
            
            CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:poiLocation
                                                                         radius:100
                                                                     identifier:poi.name]; // Ad esempio, usa il nome del Poi come identifier
            region.notifyOnEntry = YES;
            [self.locationManager startMonitoringForRegion:region];
        }
    }];
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view.annotation isKindOfClass:[MKPointAnnotation class]]) {
        MKPointAnnotation *selectedAnnotation = (MKPointAnnotation *)view.annotation;
        
    // Cerca il Poi corrispondente al pin selezionato
    for (Poi *poi in self.poiList) {
        if ([poi.name isEqualToString:selectedAnnotation.title]) {
            // Crea un'istanza della DetailViewController e passa il Poi
            DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
            detailViewController.selectedPoi = poi;
            [self.navigationController pushViewController:detailViewController animated:YES];
            break; // Esci dal ciclo una volta trovato il Poi corrispondente
        }
    }
        
    // Deseleziona l'annotazione per evitare che rimanga selezionata
    [self.mapView deselectAnnotation:selectedAnnotation animated:NO];
        
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
    if (pinView == nil) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
        pinView.animatesDrop = YES;
        pinView.canShowCallout = NO; // Disabilita il callout predefinito
        
        // Aggiungi una sottoview personalizzata per il nome del POI
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(-70, -20, 150, 20)]; // Regola la posizione come preferisci
        titleLabel.text = annotation.title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [pinView addSubview:titleLabel];
    } else {
        pinView.annotation = annotation;
    }
    
    return pinView;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    if ([region isKindOfClass:[CLCircularRegion class]]) {
        CLCircularRegion *circularRegion = (CLCircularRegion *)region;
        
        // Crea una notifica locale
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = [NSString localizedUserNotificationStringForKey:@"Promemoria Attivo" arguments:nil];
        content.body = [NSString stringWithFormat:@"Sei vicino a %@", circularRegion.identifier];
        content.sound = [UNNotificationSound defaultSound];
        
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:circularRegion.identifier content:content trigger:nil];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:nil];
    }
}

@end




