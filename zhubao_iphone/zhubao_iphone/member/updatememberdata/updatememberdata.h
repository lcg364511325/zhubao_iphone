//
//  updatememberdata.h
//  zhubao_iphone
//
//  Created by johnson on 14-9-16.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface updatememberdata : UIViewController
{
    NSArray *provincelist;
    NSArray *citylist;
    NSArray *Divisionlist;
    NSInteger selecttable;
    CGRect tableviewframe;
    NSArray *list;
}
@property (weak, nonatomic) IBOutlet UIImageView *clogoimg;
@property (weak, nonatomic) IBOutlet UITextField *companyname;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *userphone;
@property (weak, nonatomic) IBOutlet UITextField *usertel;
@property (weak, nonatomic) IBOutlet UITextField *paddr;
@property (weak, nonatomic) IBOutlet UITextField *caddr;
@property (weak, nonatomic) IBOutlet UITextField *addr;
@property (weak, nonatomic) IBOutlet UITextField *division;
@property (weak, nonatomic) IBOutlet UITableView *tview;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;

@end
