//
//  HelloPolyViewController.m
//  HelloPoly
//
//  Created by Kamil Smuga on 09/01/2014.
//  Copyright (c) 2014 UCD. All rights reserved.
//

#import "HelloPolyViewController.h"

@interface HelloPolyViewController ()
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

@end

@implementation HelloPolyViewController

- (IBAction)decreaseSize:(id)sender {
    NSLog(@"decrease");
}
- (IBAction)increaseSize:(id)sender {
    NSLog(@"increase");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
