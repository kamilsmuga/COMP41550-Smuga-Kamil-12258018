//
//  PhotoVC.m
//  FlickrBrowser
//
//  Created by comp41550 on 18/03/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import "PhotoVC.h"
#import "FlickrFetcher.h"
#import "Photo+Flickr.h"
#import "AppDelegate.h"

@interface PhotoVC ()
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@end

@implementation PhotoVC


- (IBAction)addToFavorites:(UIBarButtonItem *)sender {
    NSManagedObjectContext *context = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
    [Photo photoWithDict:self.dict inManagedObjectContext:context];
    [((AppDelegate *)[UIApplication sharedApplication].delegate) saveContext];
}


- (void)setPhotoURL:(NSURL *)photoURL
{
    _photoURL = photoURL;
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    UIBarButtonItem *button = self.navigationItem.rightBarButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    
    [FlickrFetcher startFlickrFetch:_photoURL completion:^(NSData *data) {
        if (data)
        {
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = image;
                [spinner stopAnimating];
                self.navigationItem.rightBarButtonItem = button;
            });
        }
    }];
}

@end
