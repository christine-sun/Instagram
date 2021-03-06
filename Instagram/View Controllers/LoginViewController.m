//
//  LoginViewController.m
//  Instagram
//
//  Created by Christine Sun on 7/6/21.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "HomeViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.loginButton.layer setCornerRadius:5];
}

- (IBAction)onTapSignUp:(id)sender {
    // initialize a user object
    PFUser *newUser = [PFUser user];
        
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
        
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (succeeded) {
            [self configureHome];
        }
    }];
}

- (IBAction)onTapLogin:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
        
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (user) {
            [self configureHome];
        }
    }];
}

-(void)configureHome {
    [self performSegueWithIdentifier:@"loginSegue" sender:nil];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
    self.view.window.rootViewController = homeVC;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    HomeViewController *homeViewController = [segue destinationViewController];
}


@end
