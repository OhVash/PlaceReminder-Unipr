//
//  HomeViewController.m
//  PlaceReminder
//
//  Created by Alessandro Vascelli on 10/08/23.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization]; // richiesta localizzazione
    // Richiesta autorizzazione alle notifiche
    UNUserNotificationCenter *nc = [UNUserNotificationCenter currentNotificationCenter];
    [nc requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
                        completionHandler:^(BOOL granted, NSError * _Nullable error){}];
    [self.locationManager startUpdatingLocation]; // Inizia a monitorare la posizione dell'utente
}

- (IBAction)showMapButton:(id)sender {
    [self performSegueWithIdentifier:@"segueShowMap" sender:nil];
}

- (IBAction)showListButton:(id)sender {
    [self performSegueWithIdentifier:@"segueListMap" sender:nil];
}
- (IBAction)saveButton:(id)sender {
    NSString *name = self.nameTextField.text;
    NSString *address = self.addressTextField.text;
    // Verifica se nome e indirizzo sono vuoti
    if (name.length == 0 || address.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:@"Name and address cannot be blank"
                                                                preferredStyle:UIAlertControllerStyleAlert];
            
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        return; // Esce dalla funzione senza salvare il Poi
        }
    
    NSString *poiDescription = self.descriptionTextField.text;
    NSDate *timestamp = [NSDate date];
    
    
    // Creazione del Poi con gli elementi inseriti
    Poi *newPoi = [[Poi alloc] initWithName:name
                                     address:address
                                 description:poiDescription
                                   timestamp:timestamp];
    // aggiungo il Poi alla lista condivisa
    PoiManager *poiManager = [PoiManager sharedManager];
    [poiManager savePoi:newPoi];
    
    // Ripristino le textField
    self.nameTextField.text = @"";
    self.addressTextField.text = @"";
    self.descriptionTextField.text = @"";
}

// Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueShowMap"]) {
        [self performSegueWithIdentifier:@"segueShowMap" sender:self];
    } else if ([segue.identifier isEqualToString:@"segueShowList"]) {
        [self performSegueWithIdentifier:@"segueShowList" sender:self];
    }
}

@end
