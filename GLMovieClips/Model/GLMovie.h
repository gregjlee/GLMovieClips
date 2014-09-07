//
//  GLMovie.h
//  GLMovieClips
//
//  Created by Gregory Lee on 9/6/14.
//  Copyright (c) 2014 Greg. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>

@interface GLMovie : MTLModel <MTLJSONSerializing>
@property (nonatomic,strong)NSNumber *objectID;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *mpaaRating;
@property (nonatomic,strong)NSString *criticsConsensus;
@property (nonatomic,strong)NSString *synopsis;

+ (NSArray *)deserializeMoviesFromJSON:(NSArray *)moviesJSON;

@end
