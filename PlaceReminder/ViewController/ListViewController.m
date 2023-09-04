//
//  ListViewController.m
//  PlaceReminder
//
//  Created by Alessandro Vascelli on 15/08/23.
//

#import "ListViewController.h"

@interface ListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) Poi *selectedPoi;

@end

@implementation ListViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNotification];
    self.title=@"Your Saved Locations";
    // implementa metodi di UITableView
    self.tableView.dataSource = self;
    // gestisce eventi all'interno della lista
    self.tableView.delegate = self;
    
    // Register the cell class or nib with the appropriate identifier
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetailSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *detailViewController = (DetailViewController *)segue.destinationViewController;
        detailViewController.selectedPoi = PoiManager.sharedManager.poiList[indexPath.row];
        detailViewController.poiIndex = indexPath.row; // Passa l'indice al DetailViewController
    }
}

#pragma mark - UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
       Poi *poi = PoiManager.sharedManager.getAllPoi[indexPath.row];
       cell.textLabel.text = poi.name;
       return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return PoiManager.sharedManager.poiList.count;
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Poi *selectedPoi = PoiManager.sharedManager.getAllPoi[indexPath.row];
       
    DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailViewController.selectedPoi = selectedPoi;
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

#pragma mark - Notification on Updates

-(void) setupNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateData)
                                                 name:@"PoiDataUpdatedNotification"
                                               object:nil];
}

- (void)updateData {
    [self.tableView reloadData];
}

@end
