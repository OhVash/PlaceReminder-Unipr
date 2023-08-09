//
//  ViewController.m
//  PlaceReminder
//
//  Created by Alessandro Vascelli on 08/08/23.
//

#import "ViewController.h"

#define DEBUGLOG(a) NSLog(@"%s: %@", __FUNCTION__, a)

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelCount;
@property (strong, nonatomic) NSNumber *count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.labelCount.text = @"Count:";
}

-(void)setCount:(NSNumber *)count{
    _count = count;
    self.labelCount.text = [NSString stringWithFormat:@"Count: %d", self.count.intValue];
}

- (IBAction)buttonPressed:(id)sender {
    self.count = @(self.count.intValue+1);
}


@end
