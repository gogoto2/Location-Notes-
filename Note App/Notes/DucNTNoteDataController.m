

#import "DucNTNoteDataController.h"
#import "DucNTNote.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLGeocoder.h>
#import "DucNTMasterViewController.h"

@interface DucNTNoteDataController ()
- (void)initializeDefaultDataList;
@end

@implementation DucNTNoteDataController

@synthesize masterNoteList = _masterNoteList;

- (void)initializeDefaultDataList {
    NSMutableArray *noteList = [[NSMutableArray alloc] init];
    self.masterNoteList = noteList;
}

- (void)setMasterNoteList:(NSMutableArray *)newList {
    if (_masterNoteList != newList) {
        _masterNoteList = [newList mutableCopy];
    }
}

- (id)init {
    if (self = [super init]) {
        [self initializeDefaultDataList];
        return self;
    }
    return nil;
}

- (NSUInteger)countOfList {
    return [self.masterNoteList count];
}

- (DucNTNote *)objectInListAtIndex:(NSUInteger)theIndex {
    return [self.masterNoteList objectAtIndex:theIndex];
}

- (void)addNoteWithLocation:(CLLocation *)location locationString:(NSString *)locationString {
    
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
    }
    
    DucNTNote *note = [[DucNTNote alloc] initWithTitle:@"" locationString:locationString location:location date:[formatter stringFromDate:[NSDate date]] text:@""];
    [self.masterNoteList addObject:note];
}

- (void)removeObjectAtIndex:(NSUInteger)theIndex {
    [self.masterNoteList removeObjectAtIndex:theIndex];
}


@end
