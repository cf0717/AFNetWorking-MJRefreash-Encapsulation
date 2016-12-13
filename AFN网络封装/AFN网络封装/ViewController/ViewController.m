//
//  ViewController.m
//  AFN网络封装
//
//  Created by chaofan on 2016/11/15.
//  Copyright © 2016年 chaofan. All rights reserved.
//

#import "ViewController.h"
#import "CFSendNet.h"//网络请求
#import "CFDataModel.h"//模型数据
//封装上下拉刷新
#import "CFCustomHeader.h"
#import "CFCustomFooter.h"
//没有数据
#import "CFNoDataView.h"

#define httpHead @"https://hs.tocet.cn/v1.0"

@interface ViewController () <UITableViewDataSource>

@property (nonatomic,strong) AFHTTPSessionManager *manger;
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) CFNoDataView *noDataView;
@property (nonatomic,assign) NSUInteger pageNo;

@end

@implementation ViewController

#pragma mark - 懒加载
-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]init];
    }
    return _tableview;
}

-(AFHTTPSessionManager *)manger
{
    if (!_manger) {
        _manger = [AFHTTPSessionManager manager];
    }
    return _manger;
}

-(CFNoDataView *)noDataView
{
    if (!_noDataView) {
        _noDataView = [[CFNoDataView alloc]initWithFrame:self.view.bounds];
        _noDataView.hidden = YES;
        [_noDataView.reloadBtn addTarget:self action:@selector(loadNewData) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_noDataView];
    }
    return _noDataView;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];

    self.tableview.frame = self.view.bounds;
    self.tableview.dataSource = self;
    self.tableview.rowHeight = 60;
    [self.view addSubview:self.tableview];

    
//TODO:增加上下拉刷新功能
    CFCustomHeader *customHeader = [CFCustomHeader customHeaderTarget:self selector:@selector(loadNewData)];
    self.tableview.mj_header = customHeader;
    
    CFCustomFooter *customFooter = [CFCustomFooter customFooterTarget:self selector:@selector(loadMoreData)];
    self.tableview.mj_footer = customFooter;

    [self.tableview.mj_header beginRefreshing];//MJRefresh开始刷新

}

-(void)viewWillDisappear:(BOOL)animated
{
    [CFSendNet cancelAFNManger:self.manger];
}

#pragma mark - 发送请求
-(void)loadNewData
{
    //无网络图片隐藏
    self.noDataView.hidden = YES;
    [CFSendNet cancelAFNManger:self.manger];
    _pageNo = 1;
    //1.视图懒加载请求管理者
    
    //2.拼接参数
    NSString *kindStr = @"/news";
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",httpHead,kindStr];//宏定义头部，拼接字符串
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"address"] = @"";
    parameter[@"rows"] = @"5";
    parameter[@"page"] = [NSString stringWithFormat:@"%zd",_pageNo];
    
    //3.发送网路请求
    [self.manger GET:urlStr parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //TODO:请求成功
        if ([responseObject[@"status"] intValue] == 200) {

            //数据转模型
            _dataArr = [NSMutableArray array];
            _dataArr = [CFDataModel dataModelWithArray:responseObject[@"data"]];
       
            //没有数据视图
            self.noDataView.hidden = !(_dataArr.count == 0);
            
            [self.tableview reloadData];
            
        }else{
            NSLog(@"失败了，错误了");
        }
        //结束刷新
        [self.tableview.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [self.tableview.mj_header endRefreshing];
        //更换界面
        [self noNetWork];
    }];
}

-(void)loadMoreData
{
    [CFSendNet cancelAFNManger:self.manger];
    ++_pageNo;
    //1.视图懒加载请求管理者
    
    //2.拼接参数
    NSString *kindStr = @"/news";
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",httpHead,kindStr];//宏定义头部，拼接字符串
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"address"] = @"";
    parameter[@"rows"] = @"5";
    parameter[@"page"] = [NSString stringWithFormat:@"%zd",_pageNo];
    
    //3.发送网路请求
    [self.manger GET:urlStr parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //TODO:请求成功
        if ([responseObject[@"status"] intValue] == 200) {
            
            //数据转模型
            [_dataArr addObjectsFromArray:[CFDataModel dataModelWithArray:responseObject[@"data"]]];
            
            [self.tableview reloadData];
            
        }else{
            --_pageNo;
            NSLog(@"失败了，错误了");
        }
        //结束刷新
        [self.tableview.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [self.tableview.mj_footer endRefreshing];
        --_pageNo;
        //更换界面
        [self noNetWork];
    }];
}

#pragma mark - 没有网络
-(void)noNetWork{
    if (_dataArr.count) return;
    self.noDataView.hidden = NO;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //这里最好也设置一下
    self.tableview.mj_footer.hidden = (_dataArr.count == 0);
    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    CFDataModel *dataModel = _dataArr[indexPath.row];
    cell.textLabel.text = dataModel.titleStr;
    cell.detailTextLabel.text = dataModel.introStr;
    
    return cell;
}

@end
