//
//  GLMovieTableViewController.m
//  GLMovieClips
//
//  Created by Gregory Lee on 9/6/14.
//  Copyright (c) 2014 Greg. All rights reserved.
//

#import "GLMovieTableViewController.h"
#import "GLFlixsterAPIClient.h"
#import "GLMovieCell.h"
#import "GLMovie.h"
#import <MBProgressHUD.h>
#import "GLMovieDetailsViewController.h"

@interface GLMovieTableViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,assign)NSInteger pageSize;
@property (nonatomic,assign)NSInteger total;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,assign)BOOL isLoadingPage;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *movies;
@end
@implementation GLMovieTableViewController

#pragma mark - 
#pragma mark - view life cycle
-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor=[UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *nextButton=[[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(fetchNextMoviePage:)];
    self.navigationItem.rightBarButtonItem=nextButton;
    
    [self.view addSubview:self.tableView];
    
    self.movies=@[];
    self.pageSize=20;
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
    
    /* show loading */
    self.isLoadingPage=YES;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [[GLFlixsterAPIClient sharedFlixsterClient] fetchMoviesWithPageSize:self.pageSize page:self.page success:^(NSInteger total, NSArray *movies) {
        NSLog(@"page %@ of %@",@(self.page),@(pages));
        
        /* update and increment page counts */
        self.total=total;
        self.page++;
        
        /* add to current movies */
        NSMutableArray *mutableArray=[self.movies mutableCopy];
        [mutableArray addObjectsFromArray:movies];
        self.movies=mutableArray;
        
        /* update ui */
        self.isLoadingPage=NO;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView reloadData];
    } fail:^{
        //show message
        self.isLoadingPage=NO;
    }];

}

#pragma mark -
#pragma mark - tableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!self.movies) {
        return 0;
    }
    return self.movies.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"identifier";
    GLMovieCell *cell=(GLMovieCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[GLMovieCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    GLMovie *movie=self.movies[indexPath.row];
    [cell configureWithMovie:movie];
    return cell;
}

#pragma mark -
#pragma mark - tableview delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GLMovie *movie=self.movies[indexPath.row];
    GLMovieDetailsViewController *detailController=[[GLMovieDetailsViewController alloc]initWithMovie:movie];
    [self.navigationController pushViewController:detailController animated:YES];
}

#pragma mark -
#pragma mark - scrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height)) {
        if(self.isLoadingPage == NO){ // no need to worry about threads because this is always on main thread.
            [self fetchNextMoviePage:nil];
        }
    }

}


#pragma mark -
#pragma mark - getters
-(UITableView *)tableView{
    if (_tableView) {
        return _tableView;
    }
    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    return _tableView;
}


@end
