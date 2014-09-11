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
#import <UIImageView+AFNetworking.h>
@implementation GLMovieCell
#pragma mark -
#pragma mark - init
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor=[UIColor blackColor];
        [self loadSubviews];
        [self setupConstraints];
        // Initialization code
    }
    return self;
}

-(void)loadSubviews{
    self.iconImageView=[[UIImageView alloc] initForAutoLayout];
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLabel=[[UILabel alloc] initForAutoLayout];
    self.titleLabel.textColor=[UIColor whiteColor];
    [self.contentView addSubview:self.titleLabel];
    
    self.mpaaRatingLabel = [self labelForDetails];
    [self.contentView addSubview:self.mpaaRatingLabel];

    
    self.castLabel= [self labelForDetails];
    [self.contentView addSubview:self.castLabel];
    
    self.descriptionLabel = [self labelForDetails];
    [self.contentView addSubview:self.descriptionLabel];
    
    self.ratingLabel = [self labelForDetails];
    self.ratingLabel.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:self.ratingLabel];
    

}

-(UILabel *)labelForDetails{
    UILabel *label=[[UILabel alloc] initForAutoLayout];
    label.font=[UIFont systemFontOfSize:14];
    label.textColor=[UIColor lightGrayColor];
    return label;
}

-(void)setupConstraints{
    CGFloat border=5.f;
    CGFloat offset = 10.f;
    
    [self.iconImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(border, offset, border, 0) excludingEdge:ALEdgeRight];
    [self.iconImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.iconImageView autoSetDimension:ALDimensionWidth toSize:60.f];
    
    /* middle detail labels */
    [self.ratingLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.ratingLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:offset];
    
    [self.castLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.castLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.iconImageView withOffset:offset];
    [self.castLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.ratingLabel withOffset:-offset];
    
    /*top title */
    [self.titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.iconImageView withOffset:offset];
    [self.titleLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.castLabel withOffset:0];
    
    /* bot title */
    [self.descriptionLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.iconImageView withOffset:offset];
    [self.descriptionLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.castLabel withOffset:0];
    
}

#pragma mark - public config
-(void)configureWithMovie:(GLMovie *)movie{
    [self.iconImageView setImageWithURL:[NSURL URLWithString:movie.thumbnailImageURL] placeholderImage:nil];
    self.titleLabel.text= movie.title;
    self.ratingLabel.text =movie.criticsScore.stringValue;// movie.criticsRating;
    self.descriptionLabel.text=movie.criticsRating;
    self.castLabel.text = [NSString stringWithFormat:@"%@ %@",movie.mpaaRating,movie.abridgedCast];
    
//    self.descriptionLabel.text = movie.runtime.stringValue;
}


@end
