//
//  ComposeViewController.m
//  Instagram
//
//  Created by Christine Sun on 7/6/21.
//

#import "ComposeViewController.h"
#import "HomeViewController.h"
#import "Post.h"

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *postImage;
@property (weak, nonatomic) IBOutlet UITextView *captionText;
//
@property (strong, nonatomic) UIImagePickerController *imagePickerVC;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imagePickerVC = [UIImagePickerController new];
    self.imagePickerVC.delegate = self;
    self.imagePickerVC.allowsEditing = YES;
}

- (IBAction)onTapCamera:(id)sender {
    self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];
}

- (IBAction)onTapPhotoAlbum:(id)sender {
    self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];
}

- (IBAction)onTapCancel:(id)sender {
    [self clearAndGoHome];
}

- (IBAction)onTapShare:(id)sender {
    // Upload the image to Parse
    [Post postUserImage:self.postImage withCaption:self.captionText.text withCompletion:nil];
    
    [self clearAndGoHome];
}

- (void)clearAndGoHome {
    self.captionText.text = @"";
    self.imageView.image = nil;
    
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // Resize image before uploading
    CGSize imageDimensions = CGSizeMake(1000, 1000);
    UIImage *resizedImage = [self resizeImage:editedImage withSize:imageDimensions];
    self.postImage = resizedImage;
    [self.imageView setImage:resizedImage];
        
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - Navigation

/*// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
} */

@end
