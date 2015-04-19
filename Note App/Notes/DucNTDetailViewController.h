

#import <UIKit/UIKit.h>
@class DucNTNote;


@interface DucNTDetailViewController : UIViewController <UITextFieldDelegate,UITextViewDelegate> {
    
    CGPoint scrollViewDefaultOffset;

}

@property (strong,nonatomic) DucNTNote *note;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *noteTitleField;
@property (weak, nonatomic) IBOutlet UITextField *noteLocationField;
@property (weak, nonatomic) IBOutlet UITextField *noteDateField;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
- (void)done;
- (void)save;


@end

UIBarButtonItem* doneButton;