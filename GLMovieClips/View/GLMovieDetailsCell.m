//
//  GLMovieDetailsCell.m
//  GLMovieClips
//
//  Created by Gregory Lee on 9/10/14.
//  Copyright (c) 2014 Greg. All rights reserved.
//

#import "GLMovieDetailsCell.h"
#import <PureLayout.h>
#import <UIImageView+AFNetworking.h>
#import "GLMovie.h"

@implementation GLMovieDetailsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadSubviews];
        [self setupConstraints];
        // Initialization code
    }
    return self;
}

-(void)loadSubviews{
}

-(void)setupConstraints{
    
}
-(void)configureWithMovie:(GLMovie *)movie{
    
}

@end

@implementation GLMovieDetailsImageCell
-(void)loadSubviews{
    self.posterImageView=[[UIImageView alloc]initForAutoLayout];
    self.posterImageView.contentMode=UIViewContentModeCenter;
    [self.contentView addSubview:self.posterImageView];
}

-(void)setupConstraints{
    [self.posterImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

-(void)configureWithMovie:(GLMovie *)movie{
    
    [self.posterImageView setImageWithURL:[NSURL URLWithString:movie.detailedImageURL] placeholderImage:nil];
}
@end
