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
@property (nonatomic, strong) CLLocation *currentLocation;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
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
    NSString *poiDescription = self.descriptionTextField.text;
    CLLocationCoordinate2D location = self.currentLocation.coordinate;
    NSDate *timestamp = [NSDate date];
    
    Poi *newPoi = [[Poi alloc] initWithName:name
                                     address:address
                               description:poiDescription
                                  location:location
                                 timestamp:timestamp];
       
       PoiManager *poiManager = [PoiManager sharedManager];
       [poiManager savePoi:newPoi];
       
       // Aggiungi il nuovo Poi alla mappa nel MapViewController
       MapViewController *mapViewController = (MapViewController *)self.tabBarController.viewControllers[1];
       [mapViewController addPoiToMap:newPoi];
    
    // Svuota le text view
       self.nameTextField.text = @"";
       self.addressTextField.text = @"";
       self.descriptionTextField.text = @"";
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"segueShowMap"]) {
           MapViewController *mapViewController = segue.destinationViewController;
    } else if ([segue.identifier isEqualToString:@"segueShowList"]) {
        ListViewController *listViewController = segue.destinationViewController;
    }
    
}


@end
