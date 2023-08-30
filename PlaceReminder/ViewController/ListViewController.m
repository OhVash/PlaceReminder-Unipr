//
//  ListViewController.m
//  PlaceReminder
//
//  Created by Alessandro Vascelli on 15/08/23.
//

#import "ListViewController.h"
#import "Poi.h"
#import "PoiManager.h"

@interface ListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<Poi *> *poiList;
@property (nonatomic, strong) Poi *selectedPoi;

@end

@implementation ListViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNotification];
    self.title=@"Your Saved Locations";
    
    // Carica i dati
    self.poiList = [[PoiManager sharedManager] getAllPoi];
    self.tableView.dataSource = self;
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
        detailViewController.selectedPoi = self.poiList[indexPath.row];
        detailViewController.poiIndex = indexPath.row; // Passa l'indice all DetailViewController
    }
}

#pragma mark - UITableView

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
       Poi *poi = self.poiList[indexPath.row];
       cell.textLabel.text = poi.name;
       return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.poiList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
       
    Poi *selectedPoi = self.poiList[indexPath.row];
       
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
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deleteData)
                                                     name:@"PoiDataDeletedNotification"
                                                   object:nil];
}

- (void)updateData {
    self.poiList = [[PoiManager sharedManager] getAllPoi];
    [self.tableView reloadData];
}

- (void)deleteData {
    // Aggiorna l'array dei Poi e la tabella
    [[PoiManager sharedManager] removePoi:self.selectedPoi];
    [self.tableView reloadData];
}
@end
