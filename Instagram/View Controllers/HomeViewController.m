//
//  HomeViewController.m
//  Instagram
//
//  Created by Christine Sun on 7/6/21.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "ComposeViewController.h"
#import "DetailsViewController.h"
#import "PostCell.h"
#import <Parse/Parse.h>

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *arrayOfPosts;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self fetchPosts];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (IBAction)onTapLogOut:(id)sender {
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
        self.view.window.rootViewController = loginVC;
    }];
    
}

- (IBAction)onTapCamera:(id)sender {
    [self performSegueWithIdentifier:@"composeSegue" sender:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfPosts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    cell.post = self.arrayOfPosts[indexPath.row];
    return cell;
}

- (void)fetchPosts {
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.arrayOfPosts = posts;
            [self.tableView reloadData];
        }
        else {
            // display an error message saying posts could not be loaded
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", indexPath);
    Post *post = self.arrayOfPosts[indexPath.row];
    [self performSegueWithIdentifier:@"detailsSegue" sender:post];
    
}
- (IBAction)onLogout:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];

    self.view.window.rootViewController = loginVC;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqual: @"detailsSegue"]) {
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.post = (Post *) sender;
    }
}

@end
