//
//  FavoritesTVC.m
//  FlickrBrowser
//
//  Created by Kamil Smuga on 3/29/14.
//  Copyright (c) 2014 kamilsmuga. All rights reserved.
//

#import "FavoritesTVC.h"
#import "Photo.h"
#import "AppDelegate.h"
#import "FlickrFetcher.h"
#import "PhotoVC.h"


@interface FavoritesTVC ()
@property (nonatomic, strong) NSManagedObjectContext *context;
@end

@implementation FavoritesTVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSManagedObjectContext *)context
{
    if (!_context)
    {
        _context = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
    }
    return _context;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.debug = YES;
    [self setupFetchedResultsController];
    
}

- (void)setupFetchedResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.context sectionNameKeyPath:nil cacheName:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = photo.title;
    cell.detailTextLabel.text = photo.subtitle;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(cell.contentView.frame.size.height, cell.contentView.frame.size.height), NO, 0.0);
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIGraphicsEndImageContext();
    
    NSURL *url = [NSURL alloc];
    if (photo.imageURL) {
        url = [url initWithString:photo.imageURL];
    
        [FlickrFetcher startFlickrFetch:url completion:^(NSData *jsonData) {
            if (jsonData)
            {
                UIImage *thumbnailImage = [UIImage imageWithData:jsonData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.imageView.image = thumbnailImage;
                });
            }
        }];
    }
    
    return cell;

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show PhotoVC"])
    {
        UITableViewCell *cell =  (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
        NSURL *url = [NSURL alloc];
        url = [url initWithString:photo.imageURL];
        [segue.destinationViewController setPhotoURL:url];
        [segue.destinationViewController navigationItem].title = cell.textLabel.text;
        PhotoVC *pvc = [segue destinationViewController];
        NSDictionary *dict = [[NSDictionary alloc ]initWithObjectsAndKeys:photo.unique,FLICKR_PHOTO_ID, nil];
      //  [dict setValue:[NSString ]photo.unique forKey:@"FLICKR_PHOTO_ID"];
        pvc.dict = dict;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
