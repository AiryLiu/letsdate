//
//  ActivityViewController.m
//  letsdate
//
//  Created by LiuX on 15/4/15.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "ActivityViewController.h"

#import "LatestVisitViewController.h"
#import "FollowMeViewController.h"

@interface ActivityViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (strong, nonatomic) NSArray *viewControllers;

@end

@implementation ActivityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    LatestVisitViewController *latestVisit = [[LatestVisitViewController alloc] initWithNibName:@"LatestVisitViewController" bundle:[NSBundle mainBundle]];
    FollowMeViewController *followMe = [[FollowMeViewController alloc] initWithNibName:@"FollowMeViewController" bundle:[NSBundle mainBundle]];
    self.viewControllers = @[latestVisit, followMe];
    
    CGRect childFrame = self.containerView.bounds;
    for (int i = 0; i < self.viewControllers.count; i++) {
        UIViewController *childVC = self.viewControllers[i];
        [self addChildViewController:childVC];
        [childVC didMoveToParentViewController:self];
        childVC.view.frame = childFrame;
    }
    
    [self didSelectSide:0];
}

- (void)didSelectSide:(NSInteger)side
{
    if (side >=0 && side < 2) {
        [self.containerView removeAllSubviews];
        [self.containerView addSubview:((UIViewController *)self.viewControllers[side]).view];
    }
}

- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender
{
    [self didSelectSide:sender.selectedSegmentIndex];
}

@end
