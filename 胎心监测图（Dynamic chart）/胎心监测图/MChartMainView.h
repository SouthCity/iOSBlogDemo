//
//  MChartMainView.h
//  胎心监测图
//
//  Created by chni on 2017/4/21.
//  Copyright © 2017年 孟家豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MChartMainView : UIView


/**
 horizontalArray = @[@" 0",@"",@"10",@"",@"20",@"",@"30",@"",@"40",@"",@"50",@"",@"60",@"",@"70",@"",@"80"];
 
 verticalArray = @[@"80",@"90",@"100",@"110",@"120",@"130",@"140",@"150",@"160",@"170",@"180",@"190",@"200"];
 */

///横向数组
@property (nonatomic, strong) NSArray *horizontalArray;
///竖向数组
@property (nonatomic, strong) NSArray *verticalArray;


//添加点，根据时间和数值
- (void)addPoint:(double)time  heartbeat:(NSInteger)number;

@end
