//
//  GLMovieDetailsCell.h
//  GLMovieClips
//
//  Created by Gregory Lee on 9/10/14.
//  Copyright (c) 2014 Greg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GLMovie;
@interface GLMovieDetailsCell : UITableViewCell
-(void)configureWithMovie:(GLMovie *)movie;
-(void)loadSubviews;
-(void)setupConstraints;

@end

@interface GLMovieDetailsImageCell : GLMovieDetailsCell
@property (nonatomic,strong)UIImageView *posterImageView;
@end
