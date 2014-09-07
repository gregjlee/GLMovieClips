//
//  GLRottenTomatoesAPIClient.h
//  GLMovieClips
//
//  Created by Gregory Lee on 9/6/14.
//  Copyright (c) 2014 Greg. All rights reserved.
//

#import "AFHTTPSessionManager.h"
typedef void(^ResponseBlock)(NSInteger, NSArray *);
typedef void(^CompletionBlock)();

@interface GLFlixsterAPIClient : AFHTTPSessionManager
+(GLFlixsterAPIClient *)sharedFlixsterClient;
-(void)fetchMoviesWithPageSize:(NSInteger)pageSize page:(NSInteger)page success:(ResponseBlock)success fail:(CompletionBlock)fail;
@end
