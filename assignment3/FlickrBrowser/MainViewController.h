//
//  MainViewController.h
//  FlickrBrowser
//
//  Created by Kamil Smuga on 3/24/14.
//  Copyright (c) 2014 kamilsmuga. All rights reserved.
//

#import "FlipsideViewController.h"

#import <CoreData/CoreData.h>

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
