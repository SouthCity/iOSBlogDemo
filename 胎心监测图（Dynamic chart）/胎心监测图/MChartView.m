//
//  MChartView.m
//  胎心监测图
//
//  Created by chni on 2017/4/21.
//  Copyright © 2017年 孟家豪. All rights reserved.
//

#import "MChartView.h"

@interface MChartView ()

@property (nonatomic, strong) NSMutableArray  *xArray;
@property (nonatomic, strong) NSMutableArray  *yArray;


@end

@implementation MChartView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    
    if (self.horizontalArray) {
//        _averageWidth = self.frame.size.width/self.horizontalArray.count;
        for (int i = 0; i<self.horizontalArray.count; i++) {
            double x = _averageWidth*i;
          [self drawLine:CGPointMake(x, self.frame.size.height) endPoint:CGPointMake(x, 0)];
        }
    }
    
    if (self.verticalArray) {
//        _averageHeight = self.frame.size.height/self.verticalArray.count;
        for (int i = 0; i<self.verticalArray.count; i++) {
            double y = _averageHeight*i;
            [self drawLine:CGPointMake(0, y) endPoint:CGPointMake(self.frame.size.width, y)];
        }
    }
    
    for (int i = 0; i<_xArray.count; i++) {
        [self addPoint:[self.xArray[i] floatValue] heartbeat:[self.yArray[i] floatValue]];
    }
    
}




- (void)drawLine:(CGPoint)beginPoint endPoint:(CGPoint)endPoint {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 0.7);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 252.0 / 255.0, 105.0 / 255.0, 161.0 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, beginPoint.x, beginPoint.y);  //起点坐标
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);   //终点坐标
    CGContextStrokePath(context);
}

- (void)setPoint:(double)time  heartbeat:(NSInteger)number {
    double length = (double)[[self.horizontalArray lastObject] integerValue] - [[self.horizontalArray firstObject] integerValue];
    CGFloat xPoint = time/length*self.frame.size.width;
    [self.xArray addObject:[NSNumber numberWithFloat:xPoint]];
    
    
    double height = (double)[[self.verticalArray lastObject]integerValue] - [[self.verticalArray firstObject]integerValue];
    double tempNumber = number - [[self.verticalArray firstObject] integerValue];
    CGFloat yPoint = tempNumber/height*self.frame.size.height;
    [self.yArray addObject:[NSNumber numberWithFloat:yPoint]];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsDisplay];
    });
}



- (void)addPoint:(CGFloat)x  heartbeat:(CGFloat)y {
   
    [self drawCirclePoint:CGRectMake(x, y, 5, 5)];
}

- (void)drawCirclePoint:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, rect);
     CGContextSetRGBStrokeColor(context, 255.0 / 255.0, 255.0 / 255.0, 255.0 / 255.0, 1.0);  //线的颜色
    CGContextFillPath(context);
}


- (NSMutableArray *)xArray {
    if (!_xArray) {
        _xArray = [NSMutableArray array];
    }
    return _xArray;
}


- (NSMutableArray *)yArray {
    if (!_yArray) {
        _yArray = [NSMutableArray array];
    }
    return _yArray;
}

@end
