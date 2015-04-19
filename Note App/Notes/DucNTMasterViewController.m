

#import "DucNTMasterViewController.h"

#import "DucNTDetailViewController.h"

#import "DucNTNoteDataController.h"

#import "DucNTNote.h"
#import <iAd/iAd.h>

@implementation DucNTMasterViewController{
    BOOL _bannerIsVisible;
    ADBannerView *_adBanner;
}

@synthesize dataController = _dataController;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.locationManager startUpdatingLocation];
    [[self tableView] reloadData];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.locationManager stopUpdatingLocation];
}

- (CLLocationManager *)getLocationManager {
    return self.locationManager;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tblTable.frame = CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height - 150);
    
    if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusNotDetermined) {
        self.locationManager = [CLLocationManager new];
    }
    
    if([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorized || [CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined)) {
        
        if (self.locationManager == nil) {
            self.locationManager = [CLLocationManager new];
            
        }
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter  = 2000;
        
        [self.locationManager startUpdatingLocation];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Services" message:@"Please ensure that location services is on and enabled for Notes." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
  _adBanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 70)];
  _adBanner.delegate = self;
    
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
/*
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataController countOfList];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NoteCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    DucNTNote *noteAtIndex = [self.dataController objectInListAtIndex:indexPath.row];
    [[cell textLabel] setText:noteAtIndex.title];
    [[cell detailTextLabel] setText:noteAtIndex.date];
    return cell;

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataController removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return NO;
}




- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!_bannerIsVisible)
    {
        // If banner isn't part of view hierarchy, add it
        if (_adBanner.superview == nil)
        {
            [self.view addSubview:_adBanner];
        }
        
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        
        // Assumes the banner view is just off the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        
        [UIView commitAnimations];
        
        _bannerIsVisible = YES;
    }
}


- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Failed to retrieve ad");
    
    if (_bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        
        // Assumes the banner view is placed at the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        
        [UIView commitAnimations];
        
        _bannerIsVisible = NO;
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showNoteDetails"]) {
        DucNTDetailViewController *detailViewController = [segue destinationViewController];
        
        detailViewController.note = [self.dataController objectInListAtIndex:[self.tableView indexPathForSelectedRow].row];
    } else if ([[segue identifier] isEqualToString:@"showNewNoteDetails"]) {
        
        self.location = self.locationManager.location;
        
        if(self.location) {
            CLGeocoder *geocoder = [CLGeocoder new];
            [geocoder reverseGeocodeLocation:self.location completionHandler:^(NSArray *placemarks, NSError *error) {
                if(!error && placemarks && placemarks.count > 0) {
                    CLPlacemark *result = [placemarks objectAtIndex:0];
                    self.locationString = [result name];
                    
                    [self.dataController addNoteWithLocation:self.location locationString:self.locationString];
                    DucNTDetailViewController *detailViewController = [segue destinationViewController];
                    
                    detailViewController.note = [self.dataController objectInListAtIndex:([self.dataController countOfList]-1)];

                    
                } else {
                    float latDeg = self.location.coordinate.latitude;
                    NSString *latDirection = latDeg >= 0 ? @"N" : @"S";
                    float latD = floorf(abs(latDeg));
                    float latM = (latDeg - latD)*60;
                    float latS = (latM - floor(latM)) * 60;
                    NSString *lat = [NSString stringWithFormat:@"%i°%i'%i\"%@", (int)latD, (int)latM, (int)latS, latDirection];
                    
                    float lonDeg = self.location.coordinate.longitude;
                    NSString *lonDirection = lonDeg >= 0 ? @"E" : @"W";
                    float lonD = floorf(abs(lonDeg));
                    float lonM = (lonDeg - lonD)*60;
                    float lonS = (lonM - floor(lonM)) * 60;
                    NSString *lon = [NSString stringWithFormat:@"%i°%i'%i\"%@", (int)lonD, (int)lonM, (int)lonS, lonDirection];
                    
                    self.locationString = [NSString stringWithFormat:@"%@ %@", lat, lon];
                    
                    [self.dataController addNoteWithLocation:self.location locationString:self.locationString];
                    DucNTDetailViewController *detailViewController = [segue destinationViewController];
                    
                    detailViewController.note = [self.dataController objectInListAtIndex:([self.dataController countOfList]-1)];

                }
            }];
        } else {
            self.locationString = @"";
            [self.dataController addNoteWithLocation:self.location locationString:self.locationString];
            DucNTDetailViewController *detailViewController = [segue destinationViewController];
            
            detailViewController.note = [self.dataController objectInListAtIndex:([self.dataController countOfList]-1)];

        }
        
        
        [[self tableView] reloadData];
    }
}
@end
