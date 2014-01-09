//
//  HelloPolyViewController.m
//  HelloPoly
//
//  Created by Kamil Smuga on 09/01/2014.
//  Copyright (c) 2014 UCD. All rights reserved.
//

#import "HelloPolyViewController.h"

@interface HelloPolyViewController ()

@end

@implementation HelloPolyViewController

-(PolygonShape *)model
{
    if (!_model)
    {
        _model = [[PolygonShape init] alloc];
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
}
@end
