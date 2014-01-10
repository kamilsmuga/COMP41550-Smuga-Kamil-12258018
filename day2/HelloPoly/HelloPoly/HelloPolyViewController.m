//
//  HelloPolyViewController.m
//  HelloPoly
//
//  Created by Kamil Smuga on 09/01/2014.
//  Copyright (c) 2014 UCD. All rights reserved.
//

#import "HelloPolyViewController.h"

@interface HelloPolyViewController ()
@property (weak, nonatomic) NSUserDefaults *defaults;
@end

@implementation HelloPolyViewController

-(PolygonShape *)model
{
    if (!_model)
    {
        self.defaults = [NSUserDefaults standardUserDefaults];
        NSInteger numberOfSides = [self.defaults integerForKey:@"numberOfSides"];
        if (numberOfSides == 0)
        {
            numberOfSides = 5;
        }
        _model = [PolygonShape alloc];
        _model = [_model initWithNumberOfSides:numberOfSides];
        
    }
    return _model;
}
- (void)decrease:(UIButton *)sender
{
     NSLog(@"I’m in the decrease method");
    self.model.numberOfSides--;
    [self updateUI];
}
- (void)increase:(UIButton *)sender
{
    NSLog(@"I’m in the increase method");
    self.model.numberOfSides++;
    [self updateUI];
}
-(void)viewDidLoad
{
    [self updateUI];
}
-(void)awakeFromNib
{
    NSLog(@"My polygon: %@", self.model.name);
}
-(void) updateUI
{
    self.numberOfSlidesLabel.text = [NSString stringWithFormat:@"%d", self.model.numberOfSides ];
    self.polygonName.text = self.model.name;
    [self.numberOfSlidesLabel sizeToFit];
    self.polygonView.numberOfSides = self.model.numberOfSides;
    [self.polygonView redraw];
    [self.defaults setInteger:self.model.numberOfSides forKey:@"numberOfSides"];
    [self.defaults synchronize];
}

@end
