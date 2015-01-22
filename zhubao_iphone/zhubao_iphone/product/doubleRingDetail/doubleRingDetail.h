//
//  doubleRingDetail.h
//  zhubao_iphone
//
//  Created by johnson on 15-1-8.
//  Copyright (c) 2015年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"

@interface doubleRingDetail : UIViewController<UITextFieldDelegate,MWPhotoBrowserDelegate>
{
    NSArray *list;
    NSArray *winlaylist;
    NSArray *minlaylist;
    NSArray *netlist;
    NSArray *colorlist;
    NSArray *textturelist;
    NSArray *mnetlist;
    NSArray *mcolorlist;
    NSArray *mtextturelist;
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
    float mminlay;
    float wminlay;
    NSString *wcolor;
    NSString *wnet;
    NSString *mcolor;
    NSString *mnet;
    NSInteger rowindex;
    NSInteger mrowindex;
}

@property (nonatomic,assign) id <UIApplicationDelegate> mydelegate;//当前请求过来的对象
@property (weak, nonatomic) IBOutlet UIImageView *clogoimg;
@property (nonatomic, strong) NSMutableArray *photos;

@property(retain , nonatomic) NSString * pid;//商品id
@property (weak, nonatomic) IBOutlet UIScrollView *pdSView;
@property (strong, nonatomic) IBOutlet UIView *pdetailView;
@property (weak, nonatomic) IBOutlet UIImageView *bgimg1;
@property (weak, nonatomic) IBOutlet UIImageView *logoimg;
@property (weak, nonatomic) IBOutlet UIImageView *mlogoimg;
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

//男戒
@property (weak, nonatomic) IBOutlet UILabel *manweightLabel;
@property (weak, nonatomic) IBOutlet UILabel *mmaincountLabel;
@property (weak, nonatomic) IBOutlet UILabel *mfitweightLabel;
@property (weak, nonatomic) IBOutlet UITextField *mmianinlayText;
@property (weak, nonatomic) IBOutlet UITextField *mnetText;
@property (weak, nonatomic) IBOutlet UITextField *mcolorText;
@property (weak, nonatomic) IBOutlet UITextField *mtexttureText;
@property (weak, nonatomic) IBOutlet UITextField *msizeText;
@property (weak, nonatomic) IBOutlet UITextField *mfontLabel;


@end
