//
//  DetailViewController.m
//  PlaceReminder
//
//  Created by Alessandro Vascelli on 22/08/23.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *poiMap;
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
    [self setupDetails];
}

- (void)setupDetails {
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
            
            [self.poiMap addAnnotation:annotation];
            
            // Imposta la regione della mappa per visualizzare l'annotazione
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000);
            [self.poiMap setRegion:region animated:NO];
            self.poiMap.showsUserLocation = YES;
        }
    }];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd/MM/yyyy HH:mm:ss";
        NSString *timestampString = [dateFormatter stringFromDate:self.selectedPoi.timestamp];
        self.timestampLabel.text = timestampString;
}

#pragma mark - Buttons

- (IBAction)deleteButton:(id)sender {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Conferma Eliminazione"
                                                                       message:@"Are you sure you want to delete this Poi?"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Confirm"
                                                               style:UIAlertActionStyleDestructive
                                                             handler:^(UIAlertAction * _Nonnull action) {
            // Rimuovi il Poi dal PoiManager
            [[PoiManager sharedManager] removePoi:self.selectedPoi];
            
            // Rimuovo il pin dalla mappa
            for (id<MKAnnotation> annotation in self.poiMap.annotations) {
                if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
                        [self.poiMap removeAnnotation:annotation];
                        break;
                    }
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PoiDataUpdatedNotification"
                                                                object:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        [alert addAction:cancelAction];
        [alert addAction:deleteAction];
        [self presentViewController:alert
                           animated:YES
                         completion:nil];
    }
                

- (IBAction)editButton:(id)sender {
    UIAlertController *confirmationAlert = [UIAlertController alertControllerWithTitle:@"Confirm Changes"
                                                                               message:@"Are you sure you want to save the changes?"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
        
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
        // Salva le modifiche alle informazioni del Poi
        self.selectedPoi.name = self.name.text;
        self.selectedPoi.address = self.address.text;
        self.selectedPoi.poiDescription = self.description_text.text;
            
        // Aggiorna il timestamp
        self.selectedPoi.timestamp = [NSDate date];
        // Invia una notifica di aggiornamento dati
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PoiDataUpdatedNotification"
                                                            object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }];
        
    [confirmationAlert addAction:cancelAction];
    [confirmationAlert addAction:confirmAction];
    [self presentViewController:confirmationAlert
                       animated:YES
                     completion:nil];
}

@end
