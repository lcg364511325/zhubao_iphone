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
    NSMutableArray *btnarray1;
    NSMutableArray *btnarray2;
    NSMutableArray *btnarray3;
    NSMutableArray *btnarray4;
    NSMutableArray *stylearray;
    NSMutableArray *texturearray;
    NSMutableArray *inlayarray;
    NSMutableArray *seriearray;
    NSMutableString *styleindex;
    NSMutableString *textrueindex;
    NSMutableString *inlayindex;
    NSMutableString *serieindex;
}

@property (weak, nonatomic) IBOutlet UIView *searchview;
@property (weak, nonatomic) IBOutlet UICollectionView *productCView;
@property (weak, nonatomic) IBOutlet UIImageView *countimg;
@property (weak, nonatomic) IBOutlet UILabel *countlabel;
@property (weak, nonatomic) IBOutlet UIButton *hiddenbtn;
@property (weak, nonatomic) IBOutlet UIButton *btnstyle;
@property (weak, nonatomic) IBOutlet UIButton *btntexture;
@property (weak, nonatomic) IBOutlet UIButton *btninlay;
@property (weak, nonatomic) IBOutlet UIButton *btnseric;
@end
