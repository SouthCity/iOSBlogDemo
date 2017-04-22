//
//  MChartMainView.m
//  胎心监测图
//
//  Created by chni on 2017/4/21.
//  Copyright © 2017年 孟家豪. All rights reserved.
//

#import "MChartMainView.h"
#import "MChartView.h"
@interface MChartMainView ()

@property (nonatomic, strong) MChartView *chartView;


@end

@implementation MChartMainView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    self.chartView = [[MChartView alloc]init];
    self.chartView.horizontalArray = self.horizontalArray;
    self.chartView.verticalArray = self.verticalArray;
    self.chartView.averageWidth = self.frame.size.width/(self.horizontalArray.count+1);
    self.chartView.averageHeight = self.frame.size.height/(self.verticalArray.count+1);
    self.chartView.frame = CGRectMake(self.chartView.averageWidth*1.5, self.chartView.averageHeight*0.5, self.frame.size.width-self.chartView.averageWidth*2, self.frame.size.height-self.chartView.averageHeight*2);
    self.chartView.layer.borderColor = [UIColor redColor].CGColor;
    self.chartView.layer.borderWidth = 1.0f;
    self.chartView.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.chartView];
    [self addHorizontalLabel];
    [self addVerticalLabel];
}


- (void)addHorizontalLabel {
    for (int i = 0; i<self.horizontalArray.count; i++) {
        [self addSubview:[self label:CGRectMake(self.chartView.averageWidth+self.chartView.averageWidth*i, self.chartView.frame.size.height+self.chartView.frame.origin.y,self.chartView.averageWidth , self.chartView.averageHeight) title:self.horizontalArray[i]]];
    }
}

- (void)addVerticalLabel {
    for (int i = 0; i<self.verticalArray.count; i++) {
        [self addSubview:[self label:CGRectMake(self.chartView.averageWidth*0.2, self.frame.size.height-self.chartView.averageHeight*2-self.chartView.averageHeight*i,self.chartView.averageWidth , self.chartView.averageHeight) title:self.verticalArray[i]]];
    }
}


- (UILabel *)label:(CGRect)rect title:(NSString *)labelText{
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    label.font = [UIFont systemFontOfSize:15];
    label.text = labelText;
    label.minimumScaleFactor = 0.4;
    label.adjustsFontSizeToFitWidth = YES;
    label.textColor = [UIColor blackColor];
    return label;
}

- (void)addPoint:(double)time  heartbeat:(NSInteger)number {
    [self.chartView setPoint:time heartbeat:number];
}

@end
