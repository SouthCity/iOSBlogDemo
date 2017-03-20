//
//  TableViewController.m
//  多级菜单
//
//  Created by chni on 2017/3/8.
//  Copyright © 2017年 孟家豪. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewModel.h"

typedef enum : NSUInteger {
    defaultDirection,
    downDirection,
    upDirection,
} ScrollDirection;



@interface TableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger oldY;
    int state; //0初始 1下 2上
}
@property (strong, nonatomic) NSMutableArray *countArray;
@property (assign, nonatomic) NSInteger rowCount;
@property (strong, nonatomic) UILabel *label;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
}

#pragma mark - UITableViewDelegate、UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.countArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    TableViewModel *model = [self.countArray objectAtIndex:indexPath.row];
    if (model.array) {
        NSString *cellState = model.open?@"-":@"+";
         cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",cellState,model.name];
    }else{
         cell.textLabel.text = model.name;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewModel *model = [self.countArray objectAtIndex:indexPath.row];
    if (model.open) {
        [self deleteData:model.array];
    }else{
        self.rowCount = indexPath.row;
        [self insertData:model.array];
    }
    model.open = !model.open;
    [self.tableView reloadData];
    state = 0;
}

//cell显示
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.countArray.count>indexPath.row && state == 1) {
        for (NSInteger i = indexPath.row ; i>=0; i--) {
            TableViewModel *model = [self.countArray objectAtIndex:i];
            if (model.open) {
                self.label.hidden = NO;
                self.label.text = model.name;
                return;
            }
        }
        self.label.hidden = YES;
    }
}

//cell消失
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0) {
    if (self.countArray.count>indexPath.row && state == 2) {
        TableViewModel *model = [self.countArray objectAtIndex:indexPath.row];
        if(model.open) {
            self.label.hidden = NO;
            self.label.text = model.name;
        }
    }
}

#pragma mark UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
     //如果当前位移大于缓存位移，说明scrollView向上滑动
    if (scrollView.contentOffset.y > oldY) {
        state = 2;
    }else{
        state = 1;
    }
    //将当前位移变成缓存位移
    oldY = scrollView.contentOffset.y;
    if (scrollView.contentOffset.y <= 0) {
        self.label.hidden = YES;
    }
}

//收起所有子节点
- (void)deleteData:(NSMutableArray *)array {
    for (int i = 0; i<array.count; i++) {
        TableViewModel *model = [array objectAtIndex:i];
        if (model.array) {
            [self deleteData:model.array];
        }
        [self.countArray removeObject:model];
    }
    
}

//展开所有子节点
- (void)insertData:(NSMutableArray *)array {
    for (int i = 0; i<array.count; i++) {
        TableViewModel *model = [array objectAtIndex:i];
        self.rowCount++;
        [self.countArray insertObject:model atIndex:self.rowCount];
        if (model.array && model.open) {
            [self insertData:model.array];
        }
    }
}

#pragma init
//构造模拟数据
- (void)initData {
    //构造父节点
    for (int i = 0; i<5; i++) {
        TableViewModel *model = [[TableViewModel alloc]init];
        model.name = [NSString stringWithFormat:@"%i",i];
        model.array = [NSMutableArray array];
        //构造子节点
        for (int j = 6; j<10; j++) {
            TableViewModel *childModel = [[TableViewModel alloc]init];
            childModel.name = [NSString stringWithFormat:@"  %i",j];
            childModel.array = [NSMutableArray array];
            //构造孙子节点
            for (int k = 11; k<14; k++) {
                TableViewModel *grandsonModel = [[TableViewModel alloc]init];
                grandsonModel.name = [NSString stringWithFormat:@"      %i",k];
                grandsonModel.array = [NSMutableArray array];
                //构造曾孙节点
                for (int l = 15; l<17; l++) {
                    TableViewModel *grandsonSonModel = [[TableViewModel alloc]init];
                    grandsonSonModel.name = [NSString stringWithFormat:@"          %i",l];
                     //构造曾孙节点
                    [grandsonModel.array addObject:grandsonSonModel];
                }
                //孙子节点
                [childModel.array addObject:grandsonModel];
            }
            //子节点
            [model.array addObject:childModel];
        }
        //父节点
        [self.countArray addObject:model];
    }
}

#pragma mark lazyLoad

- (NSMutableArray *)countArray {
    if (!_countArray) {
        _countArray = [NSMutableArray array];
    }
    return _countArray;
}

- (UILabel *)label {
    if (!_label) {
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        self.label.backgroundColor = [UIColor redColor];
        [[UIApplication sharedApplication].keyWindow addSubview:self.label];
        self.label.hidden = YES;
    }
    return _label;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
