

#import "DucNTNote.h"

@implementation DucNTNote

@synthesize title = _title, location = _location, date = _date, text = _text;

-(id)initWithTitle:(NSString *)title locationString:(NSString *)locationString location:(CLLocation *) location date:(NSString *)date text:(NSString *)text {
    self = [super init];
    if (self) {
        _title = title;
        _location = location;
        _locationString = locationString;
        _date = date;
        _text = text;
        return self;
    }
    return nil;
}

@end
