//
//  GLMovieCell.h
//  GLMovieClips
//
//  Created by Gregory Lee on 9/6/14.
//  Copyright (c) 2014 Greg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GLMovie;
@interface GLMovieCell : UITableViewCell
@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *mpaaRatingLabel;
@property (nonatomic,strong)UILabel *castLabel;
@property (nonatomic,strong)UILabel *ratingLabel;
@property (nonatomic,strong)UILabel *descriptionLabel;
-(void)configureWithMovie:(GLMovie *)movie;
@end
