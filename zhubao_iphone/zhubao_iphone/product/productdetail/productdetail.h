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
    NSInteger btntag;
    NSString *womanprice;
    NSString *manprice;
    NSArray *manpdetail;
    NSArray *productlist;
    NSString *proclass;
    NSString *protypeWenProId;
    CGRect oldframe;
    CGRect frame;
}

@property (nonatomic,assign) id <UIApplicationDelegate> mydelegate;//当前请求过来的对象
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *UINavigationItem;
@property (weak, nonatomic) IBOutlet UIImageView *clogoimg;
@property (nonatomic, strong) NSMutableArray *photos;

@property(retain , nonatomic) NSString * pid;//商品id
@property (weak, nonatomic) IBOutlet UIScrollView *pdSView;
@property (strong, nonatomic) IBOutlet UIView *pdetailView;
@property (weak, nonatomic) IBOutlet UIImageView *bgimg1;
@property (weak, nonatomic) IBOutlet UIImageView *bgimg2;
@property (weak, nonatomic) IBOutlet UIImageView *logoimg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *noLabel;
@property (weak, nonatomic) IBOutlet UITableView *TView;

//女戒
@property (weak, nonatomic) IBOutlet UILabel *womanweightLabel;
@property (weak, nonatomic) IBOutlet UILabel *wmaincountLabel;
@property (weak, nonatomic) IBOutlet UILabel *wfitcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *wfitweightLabel;
@property (weak, nonatomic) IBOutlet UITextField *wmianinlayText;
@property (weak, nonatomic) IBOutlet UITextField *wnetText;
@property (weak, nonatomic) IBOutlet UITextField *wcolorText;
@property (weak, nonatomic) IBOutlet UITextField *wtexttureText;
@property (weak, nonatomic) IBOutlet UITextField *wsizeText;
@property (weak, nonatomic) IBOutlet UITextField *wfontLabel;
@property (weak, nonatomic) IBOutlet UITextField *countLabel;

//男戒
@property (weak, nonatomic) IBOutlet UILabel *manweightLabel;
@property (weak, nonatomic) IBOutlet UILabel *mmaincountLabel;
@property (weak, nonatomic) IBOutlet UILabel *mfitcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *mfitweightLabel;
@property (weak, nonatomic) IBOutlet UITextField *mmianinlayText;
@property (weak, nonatomic) IBOutlet UITextField *mnetText;
@property (weak, nonatomic) IBOutlet UITextField *mcolorText;
@property (weak, nonatomic) IBOutlet UITextField *mtexttureText;
@property (weak, nonatomic) IBOutlet UITextField *msizeText;
@property (weak, nonatomic) IBOutlet UITextField *mfontLabel;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@end
