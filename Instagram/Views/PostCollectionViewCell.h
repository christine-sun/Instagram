//
//  PostCollectionViewCell.h
//  Instagram
//
//  Created by Christine Sun on 7/9/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <Parse/PFImageView.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet PFImageView *postImageView;

@end

NS_ASSUME_NONNULL_END
