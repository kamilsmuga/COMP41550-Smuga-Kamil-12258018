//
//  PolygonView.h
//  HelloPoly
//
//  Created by Kamil Smuga on 09/01/2014.
//  Copyright (c) 2014 UCD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PolygonView : UIView
@property (assign, nonatomic) int numberOfSides;
- (void)redraw;
@end
