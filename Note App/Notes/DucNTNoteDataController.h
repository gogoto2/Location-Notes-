

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@class DucNTNote;

@interface DucNTNoteDataController : NSObject

@property (nonatomic,copy) NSMutableArray *masterNoteList;

- (NSUInteger)countOfList;
- (DucNTNote *)objectInListAtIndex:(NSUInteger)theIndex;
- (void)addNoteWithLocation:(CLLocation *)location locationString:(NSString *)locationString;
- (void)removeObjectAtIndex:(NSUInteger)theIndex;
@end

