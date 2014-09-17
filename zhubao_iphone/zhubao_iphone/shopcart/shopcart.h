//
//  shopcart.h
//  zhubao_iphone
//
//  Created by johnson on 14-9-17.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shopcart : UIViewController
{
    NSMutableArray *shoppingcartlist;
}

@property (weak, nonatomic) IBOutlet UITableView *shopcartTView;

@end
