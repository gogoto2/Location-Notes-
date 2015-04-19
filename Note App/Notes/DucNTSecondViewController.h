
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@class DucNTNoteDataController;


@interface DucNTSecondViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *map;

@property (strong, nonatomic) DucNTNoteDataController *dataController;


@end
