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
@property (nonatomic, strong) NSMutableArray<Poi *> *Pois;
@property (nonatomic, strong) Poi *selectedPoi;


@end

@implementation ListViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateData)
                                                 name:@"PoiDataUpdatedNotification"
                                               object:nil];

    // Register the cell class or nib with the appropriate identifier
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    // ... Other setup code ...

    // Carica inizialmente i dati
    self.Pois = [[PoiManager sharedManager] getAllPoi];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}
- (void)updateData {
    self.Pois = [[PoiManager sharedManager] getAllPoi];
    [self.tableView reloadData];
}

- (void)detailViewControllerDidDeletePoi:(Poi *)poi {
    // Rimuovi il Poi dall'array e aggiorna la tabella
        [self.Pois removeObject:poi];
        [self.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
    }



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetailSegue"]) {
           NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
           DetailViewController *detailViewController = (DetailViewController *)segue.destinationViewController;
           detailViewController.selectedPoi = self.Pois[indexPath.row];
           detailViewController.poiIndex = indexPath.row; // Passa l'indice all DetailViewController
       }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
       Poi *poi = self.Pois[indexPath.row];
       cell.textLabel.text = poi.name;
           
       return cell;
   }


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.Pois.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
       
       Poi *selectedPoi = self.Pois[indexPath.row];
       
       DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
       detailViewController.selectedPoi = selectedPoi;
       [self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PoiManager *poiManager = [PoiManager sharedManager];
        [poiManager removePoiAtIndex:indexPath.row];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

    }
}

/*
- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    <#code#>
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    <#code#>
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    <#code#>
}

 - (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    <#code#>
}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    <#code#>
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    <#code#>
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    <#code#>
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    <#code#>
}

- (void)setNeedsFocusUpdate {
    <#code#>
}

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
    <#code#>

}

- (void)updateFocusIfNeeded {
    <#code#>
}
 */
@end
