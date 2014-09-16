//
//  productdetail.h
//  zhubao_iphone
//
//  Created by johnson on 14-9-15.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface productdetail : UIViewController

@property(retain , nonatomic) NSString * pid;//商品id
@property (weak, nonatomic) IBOutlet UIScrollView *pdSView;
@end
