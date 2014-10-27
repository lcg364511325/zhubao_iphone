//
//  shopcart.h
//  zhubao_iphone
//
//  Created by johnson on 14-9-17.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "buyproduct.h"

@interface shopcart : UIViewController<UIApplicationDelegate>
{
    NSMutableArray *shoppingcartlist;
    UIView *demoView;
    UIView *hiview;
    UITextField *goodsno;
    NSString *goodnumber;
    buyproduct *goodselect;
}

@property (nonatomic,assign) id <UIApplicationDelegate> mydelegate;//当前请求过来的对象

@property (weak, nonatomic) IBOutlet UITableView *shopcartTView;
@property (weak, nonatomic) IBOutlet UIImageView *clogoimg;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;

-(void)refleshdata;

@end
