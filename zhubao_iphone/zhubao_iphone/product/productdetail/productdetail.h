//
//  productdetail.h
//  zhubao_iphone
//
//  Created by johnson on 14-9-15.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"

@interface productdetail : UIViewController<UITextFieldDelegate,MWPhotoBrowserDelegate>
{
    NSArray *list;
    NSArray *winlaylist;
    NSArray *minlaylist;
    NSArray *netlist;
    NSArray *colorlist;
    NSArray *textturelist;
    NSArray *sizelist;
    NSArray *lasilist;
    NSInteger btntag;
    NSString *womanprice;
    NSString *manprice;
    NSMutableArray *manpdetail;
    NSMutableArray *productlist;
    NSString *proclass;
    NSString *protypeWenProId;
    CGRect oldframe;
    CGRect frame;
    float wmweight;
    float mmweight;
    float wminlay;
    NSString *wcolor;
    NSString *wnet;
    NSInteger rowindex;
}

@property (nonatomic,assign) id <UIApplicationDelegate> mydelegate;//当前请求过来的对象
@property (weak, nonatomic) IBOutlet UIImageView *clogoimg;
@property (nonatomic, strong) NSMutableArray *photos;

@property(retain , nonatomic) NSString * pid;//商品id
@property (weak, nonatomic) IBOutlet UIScrollView *pdSView;
@property (strong, nonatomic) IBOutlet UIView *pdetailView;
@property (weak, nonatomic) IBOutlet UIImageView *bgimg1;
@property (weak, nonatomic) IBOutlet UIImageView *logoimg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITableView *TView;
@property (weak, nonatomic) IBOutlet UITextView *remarkText;

//女戒
@property (weak, nonatomic) IBOutlet UILabel *womanweightLabel;
@property (weak, nonatomic) IBOutlet UILabel *wmaincountLabel;
@property (weak, nonatomic) IBOutlet UILabel *wfitweightLabel;
@property (weak, nonatomic) IBOutlet UITextField *wmianinlayText;
@property (weak, nonatomic) IBOutlet UITextField *wnetText;
@property (weak, nonatomic) IBOutlet UITextField *wcolorText;
@property (weak, nonatomic) IBOutlet UITextField *wtexttureText;
@property (weak, nonatomic) IBOutlet UITextField *wsizeText;
@property (weak, nonatomic) IBOutlet UITextField *wfontLabel;
@property (weak, nonatomic) IBOutlet UITextField *countLabel;


@end
