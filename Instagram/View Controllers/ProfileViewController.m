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

// The dimension of the square profile picture
CGFloat profilePicDimension = 65;

// The spacing between each post
CGFloat spacing = 2;

// The number of posts per row
CGFloat postsPerLine = 3;

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self fetchMyPosts];
    
    PFUser *user = [PFUser currentUser];
    self.usernameLabel.text = user[@"username"];
    [self.profileImageView.layer setCornerRadius:profilePicDimension/2];
    
    // Configure posts layout
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = spacing;
    layout.minimumLineSpacing = spacing;
    CGFloat dimension = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * postsPerLine) / postsPerLine;
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

@end
