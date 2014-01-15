//
//  HelloPolyViewController.h
//  HelloPoly
//
//  Created by Kamil Smuga on 09/01/2014.
//  Copyright (c) 2014 UCD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolygonShape.h"
#import "PolygonView.h"

@interface HelloPolyViewController : UIViewController
@property (strong, nonatomic) IBOutlet PolygonShape *model;
@property (weak, nonatomic) IBOutlet UILabel *numberOfSlidesLabel;
@property (weak, nonatomic) IBOutlet UILabel *polygonName;
- (IBAction)increase:(UIButton *)sender;
- (IBAction)decrease:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet PolygonView *polygonView;

@end
