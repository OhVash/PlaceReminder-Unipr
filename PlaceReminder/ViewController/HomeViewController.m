//
//  HomeViewController.m
//  PlaceReminder
//
//  Created by Alessandro Vascelli on 10/08/23.
//

#import "HomeViewController.h"
#import "MapViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)showMapButton:(id)sender {
    [self performSegueWithIdentifier:@"segueShowMap" sender:nil];
}





// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"segueShowMap"]) {
           // Esegui azioni o passa dati alla Map View Controller, se necessario
           // Ad esempio:
           MapViewController *mapViewController = segue.destinationViewController;
           // Configura la Map View Controller con eventuali dati
       }
}


@end
