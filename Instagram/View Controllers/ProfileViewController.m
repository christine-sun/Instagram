//
//  ProfileViewController.m
//  Instagram
//
//  Created by Christine Sun on 7/9/21.
//

#import "ProfileViewController.h"
#import "PostCollectionViewCell.h"

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *myArrayOfPosts;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self fetchMyPosts];
    
    PFUser *user = [PFUser currentUser];
    self.usernameLabel.text = user[@"username"];
    
    [self.profileImageView.layer setCornerRadius:65];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = 2;
    layout.minimumLineSpacing = 2;
    
    CGFloat postsPerLine = 3;
    CGFloat dimension = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (postsPerLine - 0)) / postsPerLine;
    layout.itemSize = CGSizeMake(dimension, dimension);
}

-(void)fetchMyPosts {
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"image"];
    [postQuery whereKey:@"author" equalTo:[PFUser currentUser]];
    postQuery.limit = 20;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.myArrayOfPosts = posts;
            [self.collectionView reloadData];
        }
        else {
            // display an error message saying posts could not be loaded
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PostCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionViewCell" forIndexPath:indexPath];
    Post *post = self.myArrayOfPosts[indexPath.row];
    cell.postImageView.file = post[@"image"];
    [cell.postImageView loadInBackground];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.myArrayOfPosts.count;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
