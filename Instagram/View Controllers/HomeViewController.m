//
//  HomeViewController.m
//  Instagram
//
//  Created by Christine Sun on 7/6/21.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "ComposeViewController.h"
#import <Parse/Parse.h>

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onTapLogOut:(id)sender {
    [self performSegueWithIdentifier:@"logoutSegue" sender:nil];
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
    }];
}

- (IBAction)onTapCamera:(id)sender {
    [self performSegueWithIdentifier:@"composeSegue" sender:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqual: @"logoutSegue"]) {
        LoginViewController *loginViewController = [segue destinationViewController];
    }
    else if ([segue.identifier isEqual: @"composeSegue"]) {
        ComposeViewController *composeViewController = [segue destinationViewController];
    }
}

@end
