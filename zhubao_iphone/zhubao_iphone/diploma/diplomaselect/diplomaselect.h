//
//  diplomaselect.h
//  zhubao_iphone
//
//  Created by johnson on 14-9-16.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface diplomaselect : UIViewController
{
    NSArray *list;
    NSInteger diptype;
}

@property (weak, nonatomic) IBOutlet UITableView *dipTView;
@property (weak, nonatomic) IBOutlet UITextField *typeText;
@property (weak, nonatomic) IBOutlet UITextField *noText;
@property (weak, nonatomic) IBOutlet UITextField *heightLabel;
@end
