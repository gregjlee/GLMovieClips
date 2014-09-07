//
//  GLMovieTableViewController.m
//  GLMovieClips
//
//  Created by Gregory Lee on 9/6/14.
//  Copyright (c) 2014 Greg. All rights reserved.
//

#import "GLMovieTableViewController.h"
#import "GLFlixsterAPIClient.h"
@interface GLMovieTableViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,assign)NSInteger pageSize;
@property (nonatomic,assign)NSInteger total;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)UITableView *tableView;
@end
@implementation GLMovieTableViewController

#pragma mark - 
#pragma mark - view life cycle
-(void)viewDidLoad{
    [super viewDidLoad];
    UIBarButtonItem *nextButton=[[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(fetchNextMoviePage:)];
    self.navigationItem.rightBarButtonItem=nextButton;
    
    self.pageSize=10;
    self.page=1;
    self.total=NSNotFound;
    [self fetchNextMoviePage:nil];
}


#pragma mark - 
#pragma mark - fetch from api
-(void)fetchNextMoviePage:(id)sender{
    NSInteger pages=0;
    /* check if last page */
    if (self.total!=NSNotFound) {
        pages= self.total/self.pageSize;
        if (self.page>pages) {
            //no more pages
            NSLog(@"no more pages");
            return;
        }
    }
    [[GLFlixsterAPIClient sharedFlixsterClient] fetchMoviesWithPageSize:self.pageSize page:self.page success:^(NSInteger total, NSArray *movies) {
        NSLog(@"page %@ of %@",@(self.page),@(pages));
        /* update and increment page */
        self.total=total;
        self.page++;
    } fail:^{
        //show message
    }];

}


#pragma mark -
#pragma mark - getters
-(UITableView *)tableView{
    return nil;
}
@end
