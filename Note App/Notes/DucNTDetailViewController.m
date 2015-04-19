

#import "DucNTDetailViewController.h"
#import "DucNTNote.h"
#import <QuartzCore/QuartzCore.h>

@interface DucNTDetailViewController ()
- (void)configureView;
@end

@implementation DucNTDetailViewController

@synthesize note = _note;

#pragma mark - Managing the detail item


- (void)setNote:(DucNTNote *) newNote {
    if (_note != newNote) {
        _note = newNote;
        
        //update the view
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    DucNTNote *theNote = self.note;
    
    if(theNote) {
        self.noteTitleField.text = theNote.title;
        self.noteLocationField.text = theNote.locationString;
        self.noteDateField.text = theNote.date;
        self.noteTextView.text = theNote.text;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];

    self.noteTextView.layer.borderWidth = 2.0f;
    self.noteTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.noteTextView.layer.cornerRadius = 10;
    self.noteTextView.clipsToBounds = YES;
        
    [self configureView];
}

- (void)viewDidUnload
{
    self.note = nil;
    [self setNoteTitleField:nil];
    [self setNoteLocationField:nil];
    [self setNoteTextView:nil];
    [self setNoteDateField:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) save {
    self.note.title = self.noteTitleField.text;
    self.note.locationString = self.noteLocationField.text;
    self.note.text = self.noteTextView.text;
    self.note.date = self.noteDateField.text;
}

- (void) viewWillDisappear:(BOOL)animated {
    [self save];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self save];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self save];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.navigationItem.rightBarButtonItem = doneButton;
    scrollViewDefaultOffset = self.scrollView.contentOffset;
    CGPoint point;
    CGRect bounds = [self.noteTextView bounds];
    bounds = [self.noteTextView convertRect:bounds toView:self.scrollView];
    point = bounds.origin;
    point.x = 0;
    [self.scrollView setContentOffset:point animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.navigationItem.rightBarButtonItem = nil;
    [self.scrollView setContentOffset:scrollViewDefaultOffset animated:YES];
    [self save];
}

- (void)done {
    [self.noteTextView resignFirstResponder];
    [self.noteTitleField resignFirstResponder];
    [self.noteDateField resignFirstResponder];
    [self.noteLocationField resignFirstResponder];
    self.navigationItem.rightBarButtonItem = nil;
}

@end
