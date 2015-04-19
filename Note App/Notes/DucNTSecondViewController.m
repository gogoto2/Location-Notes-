

#import "DucNTSecondViewController.h"
#import "DucNTNoteDataController.h"
#import "DucNTNote.h"

//@interface BTKSecondViewController ()

//@end

@implementation DucNTSecondViewController

@synthesize dataController = _dataController;

- (void)viewDidAppear:(BOOL)animated {
    MKPointAnnotation* annot = [[MKPointAnnotation alloc] init];
    
    double max_lat = -90.0f;
    double max_lon = -90.0f;
    double min_lat = 180.0f;
    double min_lon = 180.0f;
    double sum_lat = 0.0f;
    double sum_lon = 0.0f;
    double numLocations = 0.0f;
    
    for (int i=0; i<[self.dataController countOfList]; i++) {
        DucNTNote *note = [self.dataController objectInListAtIndex:i];
        CLLocation *location = note.location;
        if(location) {
            [annot setCoordinate:location.coordinate];
            [annot setTitle:note.title];
            [annot setSubtitle:note.date];
            
            float lat = location.coordinate.latitude;
            float lon = location.coordinate.longitude;
            
            if(lat>max_lat) {
                max_lat = location.coordinate.latitude;
            }
            if(lon>max_lon) {
                max_lon = location.coordinate.longitude;
            }
            if(lat<min_lat) {
                min_lat = location.coordinate.latitude;
            }
            if(lon<min_lon) {
                min_lon = location.coordinate.longitude;
            }
            sum_lat += lat;
            sum_lon += lon;
            
            numLocations++;
            
            [self.map addAnnotation:annot];
        }
    }
    
    if(numLocations>0.0f) {
        double center_lat = sum_lat/numLocations;
        double center_lon = sum_lon/numLocations;
        
        CLLocationCoordinate2D center;
        center.latitude = center_lat;
        center.longitude = center_lon;
        
        double lat_range = max_lat - min_lat;
        double lon_range = max_lon - min_lon;
        
        if (lat_range<20) {
            lat_range = 20;
        }
        if(lon_range<40) {
            lon_range = 40;
        }
        
        MKCoordinateSpan span = MKCoordinateSpanMake(lat_range, lon_range);
        MKCoordinateRegion region = {center, span};
    
        
        [self.map setRegion:region];
         
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


@end
