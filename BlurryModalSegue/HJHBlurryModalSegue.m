//
//  HJHBlurryModalSegue.m
//  HJHBlurryModalSegue
//
//  Created by Jonghwan Hyeon on 6/30/14.
//  Copyright (c) 2014 Jonghwan Hyeon. All rights reserved.
//

#import "HJHBlurryModalSegue.h"
#import "UIImage+ImageEffects.h"

@interface HJHBlurryModalSegue ()

@property (readonly, nonatomic) UIViewController *sourceViewController;
@property (readonly, nonatomic) UIViewController *destinationViewController;
@property (readonly, nonatomic) UIViewController *effectiveDestinationViewController;

@end

@implementation HJHBlurryModalSegue

- (id)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination
{
    NSArray *components = [self parseIdentifier:identifier];
    
    self = [super initWithIdentifier:components[0] source:source destination:destination];
    if ([components[1] isEqualToString:@"CoverVertical"]) {
        self.destinationViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    } else if ([components[1] isEqualToString:@"FlipHorizontal"]) {
        self.destinationViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    } else if([components[1] isEqualToString:@"CrossDissolve"]) {
        self.destinationViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    } else if ([components[1] isEqualToString:@"PartialCurl"]) {
        self.destinationViewController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    }
    
    return self;
}

- (void)perform
{
    UIImage *backgroundImage = [self imageOfView:self.sourceViewController.view];
    backgroundImage = [backgroundImage applyLightEffect];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
    [self.effectiveDestinationViewController.view addSubview:backgroundImageView];
    [self.effectiveDestinationViewController.view sendSubviewToBack:backgroundImageView];
    
    [self.sourceViewController presentViewController:self.destinationViewController animated:YES completion:nil];
    
    if (self.destinationViewController.modalTransitionStyle == UIModalTransitionStyleCoverVertical) {
        backgroundImageView.contentMode = UIViewContentModeBottom;
        backgroundImageView.frame = CGRectMake(0.0, 0.0, backgroundImage.size.width, 0.0);
        
        [self.sourceViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            backgroundImageView.frame = CGRectMake(0.0, 0.0, backgroundImage.size.width, backgroundImage.size.height);
        } completion:nil];
    }
}

- (UIImage *)imageOfView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.frame.size);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIViewController *)effectiveDestinationViewController
{
    id effectiveDestinationViewController = self.destinationViewController;
    if ([effectiveDestinationViewController isKindOfClass:[UINavigationController class]]) {
        effectiveDestinationViewController = [[effectiveDestinationViewController viewControllers] firstObject];
    }
    
    return effectiveDestinationViewController;
}

- (NSArray *)parseIdentifier:(NSString *)identifier {
    NSArray *components = [identifier componentsSeparatedByString:@"|"];
    if (components.count == 1) {
        components = @[components[0], @"CrossDisolve"];
    }
    
    return components;
}

@end
