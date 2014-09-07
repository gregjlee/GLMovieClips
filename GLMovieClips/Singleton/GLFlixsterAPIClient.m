//
//  GLRottenTomatoesAPIClient.m
//  GLMovieClips
//
//  Created by Gregory Lee on 9/6/14.
//  Copyright (c) 2014 Greg. All rights reserved.
//

#import "GLFlixsterAPIClient.h"
#import "GLMovie.h"
static NSString * const kFlixsterAPIKey = @"zavu7dws6wxjzgj682zvvm7j";
static NSString * const kFlixsterBaseURL = @"http://api.rottentomatoes.com/api/public/v1.0/";

@implementation GLFlixsterAPIClient

#pragma mark -
#pragma mark - init

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}


#pragma mark -
#pragma mark - shared getter

+(GLFlixsterAPIClient *)sharedFlixsterClient{
    static GLFlixsterAPIClient *_sharedFlixsterClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedFlixsterClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kFlixsterBaseURL]];
    });
    
    return _sharedFlixsterClient;
    
}

#pragma mark -
#pragma mark - public

/*
 This endpoint provides us with a 'link_template' to fill out. This is our API to search for movies. Let's try it with one of my favorite movies, Toy Story 3. Make sure to URI encode your queries! http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=[your_api_key]&q=Toy+Story+3&page_limit=1
 

 */


-(void)fetchMoviesWithPageSize:(NSInteger)pageSize page:(NSInteger)page success:(ResponseBlock)success fail:(CompletionBlock)fail{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    parameters[@"apikey"] = kFlixsterAPIKey;
    parameters[@"page_limit"] = @(pageSize);
    parameters[@"page"] = @(page);
    
    [self GET:@"lists/movies/in_theaters.json" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *response=responseObject;
        NSInteger total=[response[@"total"] integerValue];
        NSArray *movieJSON=response[@"movies"];
        NSArray *movies= [GLMovie deserializeMoviesFromJSON:movieJSON];
        if (success) {
            success(total,movies);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error %@",error);
    }];
    

}



@end
