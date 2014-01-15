//
//  HelloPolyViewController.m
//  HelloPoly
//
//  Created by Kamil Smuga on 09/01/2014.
//  Copyright (c) 2014 UCD. All rights reserved.
//

#import "HelloPolyViewController.h"

@interface HelloPolyViewController ()
@property (strong, nonatomic) NSUserDefaults *defaults;
@end

@implementation HelloPolyViewController

-(PolygonShape *)model
{
    if (!_model)
    {
        _model = [PolygonShape new];
        
    }
    return _model;
}
- (void)decrease:(UIButton *)sender
{
     NSLog(@"I’m in the decrease method");
    self.model.numberOfSides--;
    [self updateUI];
    [self updateDefaults];
}
- (void)increase:(UIButton *)sender
{
    NSLog(@"I’m in the increase method");
    self.model.numberOfSides++;
    [self updateUI];
    [self updateDefaults];
}
-(void)viewDidLoad
{
    [self updateUI];
    [self.polygonView setUserInteractionEnabled:YES];
    [self setPanGestureForView:self.polygonView];
}
-(void)awakeFromNib
{
    NSLog(@"My polygon: %@", self.model.name);
    self.defaults = [NSUserDefaults standardUserDefaults];
    NSInteger numberOfSides = [self.defaults integerForKey:@"numberOfSides"];
    self.model.numberOfSides = numberOfSides;
}
-(void)updateDefaults
{
    [self.defaults setInteger:self.model.numberOfSides forKey:@"numberOfSides"];
    [self.defaults synchronize];
}
-(void) updateUI
{
    self.numberOfSlidesLabel.text = [NSString stringWithFormat:@"%d", self.model.numberOfSides ];
    self.polygonName.text = self.model.name;
    [self.numberOfSlidesLabel sizeToFit];
    self.polygonView.numberOfSides = self.model.numberOfSides;
    [self.polygonView redraw];
}

-(void)setPanGestureForView:(UIView *)panView
{

    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
   
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.polygonView addGestureRecognizer:swipeLeft];
    [self.polygonView addGestureRecognizer:swipeRight];

    
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe {
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        self.model.numberOfSides++;
        [self updateUI];
        [self updateDefaults];
        
    }
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        self.model.numberOfSides--;
        [self updateUI];
        [self updateDefaults];
        
    }
}


@end
