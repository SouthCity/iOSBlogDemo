//
//  TableViewController.m
//  UITableViewAutolayoutCell
//
//  Created by chni on 16/3/14.
//  Copyright © 2016年 孟家豪. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
@interface TableViewController ()

@property (nonatomic, copy) NSArray *contentArray;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
}

- (NSArray *)contentArray {
    if (!_contentArray) {
        _contentArray = @[@"大大大大大大，咦不够大",@"大大大大大大大大大大大大大大大大大大大大大大大大大，还是小点好",@"通常产生攀比心理的个体与被选作为参照的个体之间往往具有极大的相似性，导致自身被尊重的需要过分夸大，虚荣动机增强，甚至产生极端的心理障碍和行为。",@"攀比属于正常人心理，因为有比较才有进步，有目标才会有努力。积极向上的攀比是益于健康，益于工作的。但是消极病态的攀比却会带来不良的后果：有的人会因此而造成情绪障碍，牢骚满腹，总觉得社会对自己格外不公平，从而丧失了公平感，并且出现焦虑、抑郁等心理疾病症状；也有的人因盲目攀比而使自己处于做白日梦的幻想状态，长期不求上进，脱离实际，最终一事无成，使自己受到巨大的伤害，产生挫败感；更有甚者，攀比还是造成犯罪的主要原因，为了能像别人那样享受奢华，很多人步入歧途坠入深渊。"];
    }
    return _contentArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contentArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"autolayoutCell";
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentLabel.text = [self.contentArray objectAtIndex:indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
