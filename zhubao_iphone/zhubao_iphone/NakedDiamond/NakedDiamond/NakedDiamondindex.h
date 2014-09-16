//
//  NakedDiamondindex.h
//  zhubao_iphone
//
//  Created by johnson on 14-9-15.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewPassValueDelegate.h"

@interface NakedDiamondindex : UIViewController<UIViewPassValueDelegate>
{
    NSMutableArray *list;
}

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



@end