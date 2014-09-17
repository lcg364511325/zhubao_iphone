//
//  customtailor.h
//  zhubao_iphone
//
//  Created by johnson on 14-9-17.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customtailor : UIViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
{
    NSArray *textturelist;
    NSInteger pictag;
    NSString *pic1;
    NSString *pic2;
    NSString *pic3;
    BOOL isFullScreen;
    UIActionSheet *myActionSheet;
    
    UIPopoverController *popoverController;
    CGRect oldframe;
    CGRect frame;
}

@property (weak, nonatomic) IBOutlet UIImageView *fpicimg;
@property (weak, nonatomic) IBOutlet UIImageView *spicimg;
@property (weak, nonatomic) IBOutlet UIImageView *tpicimg;
@property (weak, nonatomic) IBOutlet UITextField *texttureText;
@property (weak, nonatomic) IBOutlet UITextField *weightText;
@property (weak, nonatomic) IBOutlet UITextField *mainweiText;
@property (weak, nonatomic) IBOutlet UITextField *maincountText;
@property (weak, nonatomic) IBOutlet UITextField *fitweiText;
@property (weak, nonatomic) IBOutlet UITextField *fitcountText;
@property (weak, nonatomic) IBOutlet UITextField *sizeText;
@property (weak, nonatomic) IBOutlet UITextField *fontText;
@property (weak, nonatomic) IBOutlet UITableView *texttureTView;

@end
