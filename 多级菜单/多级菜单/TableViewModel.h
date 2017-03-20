//
//  TableViewModel.h
//  多级菜单
//
//  Created by chni on 2017/3/8.
//  Copyright © 2017年 孟家豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableViewModel : NSObject

@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) BOOL open;
@property (strong, nonatomic) NSMutableArray *array;

@end
