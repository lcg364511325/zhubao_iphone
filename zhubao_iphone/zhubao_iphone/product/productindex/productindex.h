//
//  productindex.h
//  zhubao_iphone
//
//  Created by johnson on 14-9-11.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface productindex : UIViewController
{
    NSInteger hidden;
    NSMutableArray *list;
    NSInteger pagesize;
    NSInteger page;
    NSArray *stylearray;
    NSArray *texturearray;
    NSArray *inlayarray;
    NSArray *seriearray;
    NSArray *conditionlist;
    NSString *styleindex;
    NSString *textrueindex;
    NSString *inlayindex;
    NSString *serieindex;
    NSInteger btntag;
    NSInteger isfirst;
}

@property (nonatomic,assign) id <UIApplicationDelegate> mydelegate;//当前请求过来的对象

@property (weak, nonatomic) IBOutlet UIView *searchview;
@property (weak, nonatomic) IBOutlet UIImageView *selectbgimg;
@property (weak, nonatomic) IBOutlet UICollectionView *productCView;
@property (weak, nonatomic) IBOutlet UIImageView *countimg;
@property (weak, nonatomic) IBOutlet UILabel *countlabel;
@property (weak, nonatomic) IBOutlet UIButton *hiddenbtn;
@property (weak, nonatomic) IBOutlet UITableView *conditionTView;
@property (weak, nonatomic) IBOutlet UITextField *styleText;
@property (weak, nonatomic) IBOutlet UITextField *serieaText;
@property (weak, nonatomic) IBOutlet UITextField *textrueText;
@property (weak, nonatomic) IBOutlet UITextField *inlayText;
@end
