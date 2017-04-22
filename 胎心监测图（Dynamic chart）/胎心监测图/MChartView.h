//
//  MChartView.h
//  胎心监测图
//
//  Created by chni on 2017/4/21.
//  Copyright © 2017年 孟家豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MChartView : UIView

///横坐标数组
@property (nonatomic, strong) NSArray *horizontalArray;

///纵坐标数组
@property (nonatomic, strong) NSArray *verticalArray;

///平均每格宽度
@property (nonatomic, assign) double averageWidth;

///平均每格高度
@property (nonatomic, assign) double averageHeight;

///添加点
- (void)setPoint:(double)time  heartbeat:(NSInteger)number;


@end
