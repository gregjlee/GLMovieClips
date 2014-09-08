//
//  GLMovieCell.m
//  GLMovieClips
//
//  Created by Gregory Lee on 9/6/14.
//  Copyright (c) 2014 Greg. All rights reserved.
//

#import "GLMovieCell.h"
#import "GLMovie.h"
#import <PureLayout.h>
@implementation GLMovieCell
#pragma mark -
#pragma mark - init
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Initialization code
    }
    return self;
}

-(void)loadSubviews{
    self.iconImageView=[[UIImageView alloc] initForAutoLayout];
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLabel=[[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:self.titleLabel];
    
    self.mpaaRatingLabel = [self labelForDetails];
    [self.contentView addSubview:self.mpaaRatingLabel];
    
    self.castLabel= [self labelForDetails];
    [self.contentView addSubview:self.castLabel];
    
    self.descriptionLabel = [self labelForDetails];
    [self.contentView addSubview:self.descriptionLabel];
    
    self.ratingLabel = [self labelForDetails];
    [self.contentView addSubview:self.ratingLabel];
    

}

-(UILabel *)labelForDetails{
    UILabel *label=[[UILabel alloc] initForAutoLayout];
    return label;
}

-(void)setupConstraints{
    CGFloat border=5.f;
    CGFloat offset = 10.f;
    [self.iconImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(5., 5.f, 5.f, 5.f) excludingEdge:ALEdgeRight];
    
    /* middle detail labels */
    [self.ratingLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.ratingLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:offset];
    
    [self.castLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.castLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.iconImageView withOffset:offset];
    [self.castLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.ratingLabel withOffset:offset];
    
    /*main title */
    [self.titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.iconImageView withOffset:offset];
    [self.titleLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.castLabel withOffset:border];
    
    [self.descriptionLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.iconImageView withOffset:offset];
    [self.descriptionLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.castLabel withOffset:border];
    
}

#pragma mark - public config
-(void)configureWithMovie:(GLMovie *)movie{
    self.titleLabel.text= movie.title;
    self.ratingLabel.text = movie.criticsRating;
    self.castLabel.text = [NSString stringWithFormat:@"%@ %@",movie.mpaaRating,movie.abridgedCast];
    self.descriptionLabel.text = movie.runtime;
}


@end
