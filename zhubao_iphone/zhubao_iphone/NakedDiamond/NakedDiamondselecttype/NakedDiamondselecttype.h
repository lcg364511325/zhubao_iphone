//
//  NakedDiamondselecttype.h
//  zhubao_iphone
//
//  Created by johnson on 14-9-15.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewPassValueDelegate.h"

@interface NakedDiamondselecttype : UIViewController
{
    NSMutableString * skey;
    NSMutableString * svalue;
    NSMutableArray * namelist;
}

@property(nonatomic, retain) NSObject<UIViewPassValueDelegate> * delegate; //当前请求过来的对象


@property (retain, nonatomic) NSString *btntag;
@property (weak, nonatomic) IBOutlet UINavigationItem *UINavigationItem;
@end
