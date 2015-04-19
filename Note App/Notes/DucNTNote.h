
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface DucNTNote : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *locationString;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, copy) NSString *text;

-(id)initWithTitle:(NSString *)title locationString:(NSString *)locationString location:(CLLocation *) location date:(NSString *)date text:(NSString *) text;

@end
