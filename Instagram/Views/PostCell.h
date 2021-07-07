//
//  PostCell.h
//  Instagram
//
//  Created by Christine Sun on 7/6/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <Parse/PFImageView.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) IBOutlet PFImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@end

NS_ASSUME_NONNULL_END
