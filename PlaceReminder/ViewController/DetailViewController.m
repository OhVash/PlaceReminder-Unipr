//
//  DetailViewController.m
//  PlaceReminder
//
//  Created by Alessandro Vascelli on 22/08/23.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *PoiMap;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *description_text;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.name.text = self.selectedPoi.name;
    self.address.text = self.selectedPoi.address;
    self.description_text.text = self.selectedPoi.poiDescription;
    
    // Imposta la mappa per visualizzare la posizione del Poi
      CLLocationCoordinate2D poiCoordinate = self.selectedPoi.location;
      MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(poiCoordinate, 1000, 1000);
      [self.PoiMap setRegion:region animated:YES];
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.selectedPoi.address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Geocoding error: %@", error.localizedDescription);
            return;
        }
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks.firstObject;
            CLLocation *location = placemark.location;
            
            // Ora puoi utilizzare le coordinate per posizionare l'annotazione sulla mappa
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.coordinate = location.coordinate;
            annotation.title = self.selectedPoi.name;
            annotation.subtitle = self.selectedPoi.poiDescription;
            
            [self.PoiMap addAnnotation:annotation];
            
            // Imposta la regione della mappa per visualizzare l'annotazione
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000);
            [self.PoiMap setRegion:region animated:YES];
        }
    }];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd/MM/yyyy HH:mm:ss";
        NSString *timestampString = [dateFormatter stringFromDate:self.selectedPoi.timestamp];
        self.timestampLabel.text = timestampString;

}
- (IBAction)editButton:(id)sender {
    // Salva le modifiche alle informazioni del Poi
    self.selectedPoi.name = self.name.text;
    self.selectedPoi.address = self.address.text;
    self.selectedPoi.poiDescription = self.description_text.text;
    
    // Aggiorna il timestamp
    self.selectedPoi.timestamp = [NSDate date];
    // Invia una notifica di aggiornamento dati
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PoiDataUpdatedNotification" object:nil];

    // Torna alla schermata precedente
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end