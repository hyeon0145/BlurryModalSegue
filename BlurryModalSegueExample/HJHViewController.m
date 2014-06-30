//
//  HJHViewController.m
//  BlurryModalSegueExample
//
//  Created by Jonghwan Hyeon on 7/1/14.
//  Copyright (c) 2014 Jonghwan Hyeon. All rights reserved.
//

#import "HJHViewController.h"
#import "HJHModalViewController.h"

@interface HJHViewController ()

@end

@implementation HJHViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id effectiveDestinationViewController = segue.destinationViewController;
    if ([effectiveDestinationViewController isKindOfClass:[UINavigationController class]]) {
        effectiveDestinationViewController = [[effectiveDestinationViewController viewControllers] firstObject];
    }
    
    [effectiveDestinationViewController setSegueIdentifier:segue.identifier];
}

- (IBAction)unwind:(UIStoryboardSegue *)segue
{
    
}

@end
