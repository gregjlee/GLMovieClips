//
//  GLMovie.m
//  GLMovieClips
//
//  Created by Gregory Lee on 9/6/14.
//  Copyright (c) 2014 Greg. All rights reserved.
//

#import "GLMovie.h"
#import <NSValueTransformer+MTLPredefinedTransformerAdditions.h>
@implementation GLMovie
/*
 response
 
 "id": "770687943",
 05
 "title": "Harry Potter and the Deathly Hallows - Part 2",
 06
 "year": 2011,
 07
 "mpaa_rating": "PG-13",
 08
 "runtime": 130,
 09
 "critics_consensus": "Thrilling, powerfully acted, and visually dazzling, Deathly Hallows Part II brings the Harry Potter franchise to a satisfying -- and suitably magical -- conclusion.",
 10
 "release_dates": {"theater": "2011-07-15"},
 11
 "ratings": {
 12
 "critics_rating": "Certified Fresh",
 13
 "critics_score": 97,
 14
 "audience_rating": "Upright",
 15
 "audience_score": 93
 16
 },
 17
 "synopsis": "Harry Potter and the Deathly Hallows - Part 2, is the final adventure in the Harry Potter film series. The much-anticipated motion picture event is the second of two full-length parts. In the epic finale, the battle between the good and evil forces of the wizarding world escalates into an all-out war. The stakes have never been higher and no one is safe. But it is Harry Potter who may be called upon to make the ultimate sacrifice as he draws closer to the climactic showdown with Lord Voldemort. It all ends here. -- (C) Warner Bros",
 18
 "posters": {
 19
 "thumbnail": "http://content8.flixster.com/movie/11/15/86/11158674_mob.jpg",
 20
 "profile": "http://content8.flixster.com/movie/11/15/86/11158674_pro.jpg",
 21
 "detailed": "http://content8.flixster.com/movie/11/15/86/11158674_det.jpg",
 22
 "original": "http://content8.flixster.com/movie/11/15/86/11158674_ori.jpg"
 23
 },

 */
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"objectID": @"id",
             @"mpaaRating": @"mpaa_rating",
             @"criticsConsensus": @"critics_consensus"};
}


#pragma mark - 
#pragma mark - process JSON
+ (NSArray *)deserializeMoviesFromJSON:(NSArray *)moviesJSON
{
    NSError *error;
    NSArray *movies = [MTLJSONAdapter modelsOfClass:[GLMovie class] fromJSONArray:moviesJSON error:&error];
    if (error) {
        NSLog(@"Couldn't convert app infos JSON to movie models: %@", error);
        return nil;
    }
    
    return movies;
}

+ (NSArray *)deserializeMoviesFromNSData:(NSData *)jsonFormatData
{
    NSError *error;
    NSArray *moviesJSON = [NSJSONSerialization JSONObjectWithData:jsonFormatData options:0 error:&error];
    if (error) {
        NSLog(@"Couldn't deserealize app info data into JSON from NSData: %@", error);
        return nil;
    }
    
    return [self deserializeMoviesFromJSON:moviesJSON];
}


@end
