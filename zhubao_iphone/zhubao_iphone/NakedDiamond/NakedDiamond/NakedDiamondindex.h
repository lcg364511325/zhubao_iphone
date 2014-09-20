//
//  NakedDiamondindex.h
//  zhubao_iphone
//
//  Created by johnson on 14-9-15.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewPassValueDelegate.h"

@interface NakedDiamondindex : UIViewController<UIViewPassValueDelegate,UITextFieldDelegate>
{
    NSString *modelvalue;
    NSString *colorvalue;
    NSString *netvalue;
    NSString *cutvalue;
    NSString *chasingvalue;
    NSString *symmetryvalue;
    NSString *fluorescencevalue;
    NSString *diplomavalue;
    CGRect oldframe;
    CGRect frame;
    NSArray *btnarray;
    NSInteger isfirst;
}

@property (nonatomic,assign) id <UIApplicationDelegate> mydelegate;//当前请求过来的对象

@property (retain, nonatomic) NSString *pkey;
@property (retain, nonatomic) NSString *pvalue;
@property (retain, nonatomic) NSString *selecttag;

@property (weak, nonatomic) IBOutlet UIButton *modelButton;
@property (weak, nonatomic) IBOutlet UIButton *colorButton;
@property (weak, nonatomic) IBOutlet UIButton *netButton;
@property (weak, nonatomic) IBOutlet UIButton *cutButton;
@property (weak, nonatomic) IBOutlet UIButton *chasingButton;
@property (weak, nonatomic) IBOutlet UIButton *symmetryButton;
@property (weak, nonatomic) IBOutlet UIButton *fluorescenceButton;
@property (weak, nonatomic) IBOutlet UIButton *diplomaButton;
@property (weak, nonatomic) IBOutlet UITextField *noText;
@property (weak, nonatomic) IBOutlet UITextField *minheight;
@property (weak, nonatomic) IBOutlet UITextField *maxheight;
@property (weak, nonatomic) IBOutlet UITextField *minprice;
@property (weak, nonatomic) IBOutlet UITextField *maxprice;





@end
