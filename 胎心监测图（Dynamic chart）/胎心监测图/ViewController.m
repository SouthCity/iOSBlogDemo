//
//  ViewController.m
//  胎心监测图
//
//  Created by chni on 2017/4/21.
//  Copyright © 2017年 孟家豪. All rights reserved.
//

#import "ViewController.h"
#import "MChartMainView.h"
@interface ViewController ()

@property (nonatomic, strong) MChartMainView *chartview;
@property (nonatomic, strong) NSMutableDictionary *pointDic;
@property (nonatomic, assign) double timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chartview = [[MChartMainView alloc]init];
    self.chartview.frame = CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 200);
    self.chartview.backgroundColor = [UIColor blueColor];
    self.chartview.horizontalArray = @[@" 0",@"",@"10",@"",@"20",@"",@"30",@"",@"40",@"",@"50",@"",@"60",@"",@"70",@"",@"80"];
    self.chartview.verticalArray = @[@"80",@"90",@"100",@"110",@"120",@"130",@"140",@"150",@"160",@"170",@"180",@"190",@"200"];
    [self.view addSubview:self.chartview];
    [self countDownTimer];
}


- (void)countDownTimer {
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.25 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        self.timer += 0.25;
        [self pointTimer];
        if (self.timer>=10) {
            dispatch_source_cancel(timer);
        }
    });
    dispatch_resume(timer);
}

- (void)pointTimer {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __block int point = 80;
        point += arc4random() % 100;
        if (point>200) {
            point = 80;
        }
        [self.pointDic setObject:[NSNumber numberWithInt:point] forKey:[NSString stringWithFormat:@"%.2f",self.timer]];
        [self.chartview addPoint:self.timer heartbeat:point];
    });
}


- (NSMutableDictionary *)pointDic {
    if (!_pointDic) {
        _pointDic = [NSMutableDictionary dictionary];
    }
    return _pointDic;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
