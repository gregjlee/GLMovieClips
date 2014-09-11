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
@property (nonatomic,strong)NSNumber *year;
@property (nonatomic,strong)NSString *mpaaRating;
@property (nonatomic,strong)NSNumber *runtime;
@property (nonatomic,strong)NSString *synopsis;

/*cast */
@property (nonatomic,strong)NSString *abridgedCast;
/*ratings */
@property (nonatomic,strong)NSString *criticsRating;
@property (nonatomic,strong)NSNumber *criticsScore;
@property (nonatomic,strong)NSString *audienceRating;
@property (nonatomic,strong)NSNumber *audienceScore;

/* posters */
@property (nonatomic,strong)NSString *detailedImageURL;
@property (nonatomic,strong)NSString *thumbnailImageURL;

+ (NSArray *)deserializeMoviesFromJSON:(NSArray *)moviesJSON;

@end
