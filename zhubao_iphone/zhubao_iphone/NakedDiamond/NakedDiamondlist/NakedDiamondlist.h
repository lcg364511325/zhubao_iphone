//
//  NakedDiamondlist.h
//  zhubao_iphone
//
//  Created by johnson on 14-9-16.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NakedDiamondlist : UIViewController
{
    NSMutableArray *list;
    NSInteger pagesize;
    NSInteger page;
    NSString *modelvalue;
    NSString *colorvalue;
    NSString *netvalue;
    NSString *cutvalue;
    NSString *chasingvalue;
    NSString *symmetryvalue;
    NSString *fluorescencevalue;
    NSString *diplomavalue;
    NSString *novalue;
    NSString *minheight;
    NSString *maxheight;
    NSString *minprice;
    NSString *maxprice;
}
@property (nonatomic,assign) id <UIApplicationDelegate> mydelegate;//当前请求过来的对象

@property (retain,nonatomic) NSDictionary *condition;//裸钻查询参数
@property (weak, nonatomic) IBOutlet UITableView *nksrTView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

-(NSArray *)showmodelandimg:(NSString *)modeltype;

@end
