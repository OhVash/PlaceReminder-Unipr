//
//  MapViewController.m
//  PlaceReminder
//
//  Created by Alessandro Vascelli on 10/08/23.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Configura la mappa, aggiungi marcatori, ecc.
    [self configureMapView];
}

- (void)configureMapView {
    // Imposta le coordinate iniziali della mappa
    CLLocationCoordinate2D initialCoordinate = CLLocationCoordinate2DMake(37.7749, -122.4194);
    MKCoordinateRegion initialRegion = MKCoordinateRegionMakeWithDistance(initialCoordinate, 10000, 10000);
    [self.mapView setRegion:initialRegion animated:YES];
    
    // Aggiungi un marcatori alla mappa
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = initialCoordinate;
    annotation.title = @"Segnaposto";
    [self.mapView addAnnotation:annotation];
}

@end

