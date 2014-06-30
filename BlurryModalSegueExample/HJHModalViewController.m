//
//  HJHModalViewController.m
//  BlurryModalSegueExample
//
//  Created by Jonghwan Hyeon on 7/1/14.
//  Copyright (c) 2014 Jonghwan Hyeon. All rights reserved.
//

#import "HJHModalViewController.h"

@interface HJHModalViewController ()

@property (weak, nonatomic) IBOutlet UILabel *segueIdentifierLabel;

@end

@implementation HJHModalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.segueIdentifierLabel.text = [NSString stringWithFormat:@"Segue Identifier: %@", self.segueIdentifier];
}

@end
