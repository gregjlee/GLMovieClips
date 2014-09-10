//
//  GLMovieDetailsViewController.m
//  GLMovieClips
//
//  Created by Gregory Lee on 9/6/14.
//  Copyright (c) 2014 Greg. All rights reserved.
//

#import "GLMovieDetailsViewController.h"
#import "GLMovie.h"
#import "GLMovieDetailsCell.h"
@interface GLMovieDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)GLMovie *movie;
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation GLMovieDetailsViewController

#pragma mark -
#pragma mark - init

-(id)initWithMovie:(GLMovie *)movie{
    self=[super init];
    if(!self){
        return nil;
    }
    self.movie=movie;
    return self;
}

#pragma mark -
#pragma mark - view life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];

    // Do any additional setup after loading the view.
}

#pragma mark -
#pragma mark - tableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 400.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"cell";
    Class class= [GLMovieDetailsImageCell class];
    GLMovieDetailsCell *cell=(GLMovieDetailsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell configureWithMovie:self.movie];
    return cell;
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
