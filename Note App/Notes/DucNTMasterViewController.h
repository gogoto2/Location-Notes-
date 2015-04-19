
#import <iAd/iAd.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@class DucNTNoteDataController;

@interface DucNTMasterViewController :UITableViewController<ADBannerViewDelegate>

@property (strong, nonatomic) DucNTNoteDataController *dataController;
@property (strong, nonatomic) IBOutlet UITableView *tblTable;
@property (strong, nonatomic) CLLocationManager *locationManager;

- (CLLocationManager *)getLocationManager;

@property (strong,nonatomic) CLLocation *location;

@property (strong,nonatomic) NSString *locationString;

@end
