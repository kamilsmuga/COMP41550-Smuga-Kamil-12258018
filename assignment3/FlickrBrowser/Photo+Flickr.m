//
//  Photo+Flickr.m
//  FlickrBrowser
//
//  Created by comp41550 on 18/03/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import "Photo+Flickr.h"
#import "FlickrFetcher.h"
#import "AppDelegate.h"


@implementation Photo (Flickr)


+ (Photo *)photoWithDict:(NSDictionary *)dict inManagedObjectContext:(NSManagedObjectContext *)context
{
    Photo *photo = nil;
    
    NSString *unique = dict[FLICKR_PHOTO_ID];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.predicate = [NSPredicate predicateWithFormat:@"unique = %@", unique];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || error || ([matches count] > 1)) {
        NSLog(@"Error inside Photo+Flickr that does not suppose to happen!");
        // handle error
    } else if ([matches count]) {
        photo = [matches firstObject];
        NSLog(@"Cool, we found a match in DB!");
    } else {
        photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
        photo.unique = unique;
        photo.title = [dict valueForKeyPath:FLICKR_PHOTO_TITLE];
        photo.subtitle = [dict valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
        photo.thumbnail = [dict valueForKey:@"thumbnail"];
        photo.owner = [dict valueForKey:FLICKR_PHOTO_OWNER];
        photo.imageURL = [[FlickrFetcher urlForPhoto:dict format:FlickrPhotoFormatLarge] absoluteString];
        NSLog(@"This willl be a new photo in a DB!");
    }
    return photo;
}

+(BOOL)existsInDB:(NSString *)unique inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.predicate = [NSPredicate predicateWithFormat:@"unique = %@", unique];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || error || ([matches count] > 1)) {
        NSLog(@"Error inside Photo+Flickr that does not suppose to happen!");
        return NO;
    }
    else if ([matches count] == 0) {
        return NO;
    }
    
    return TRUE;

}


@end
