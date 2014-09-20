//
//  membercenter.m
//  zhubao_iphone
//
//  Created by johnson on 14-9-16.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "membercenter.h"
#import "checkorder.h"
#import "AppDelegate.h"
#import "updatememberdata.h"
#import "updatepassword.h"

@interface membercenter ()

@end

@implementation membercenter

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


//订单查看
- (IBAction)pickerAction:(id)sender{
    // Here we need to pass a full frame
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertView setContainerView:[self createDemoView]];
    
    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"确定", @"取消", nil]];
    [alertView setDelegate:self];
    
    [alertView setUseMotionEffects:true];
    
    // And launch the dialog
    [alertView show];
}

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [alertView close];
    }else if (buttonIndex==0)
    {
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        //当前时间
        getNowTime * time=[[getNowTime alloc] init];
        NSString * Nowt=[time nowTime];
        //上次更新时间
        NSString *Upt=@"0";
        //订单号
        NSString *orderid=@"0";
        if ([[Commons md5:[NSString stringWithFormat:@"%@",password.text]] isEqualToString:myDelegate.entityl.userPass]) {
            password.text=@"";
            NSString * Kstr=[Commons md5:[NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@",myDelegate.entityl.uId,@"601",Upt,apikey,Nowt,orderid]];
            NSString * surl = [NSString stringWithFormat:@"%@/app/aiface.php?uId=%@&type=601&Upt=%@&Nowt=%@&Kstr=%@&ordid=%@",domainser,myDelegate.entityl.uId,Upt,Nowt,Kstr,orderid];
            [alertView close];
            checkorder *_checkorder=[[checkorder alloc]init];
            _checkorder.url=surl;
            [self.navigationController pushViewController:_checkorder animated:NO];
            
        }else{
            password.text=nil;
            NSString *rowString =@"请输入正确密码！";
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }
    }
}

//日历选择
- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 220, 70)];
    [demoView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundcolor"]]];
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(75, 5, 220, 30)];
    title.text=@"密码验证";
    title.font=[UIFont systemFontOfSize:17.0f];
    [title setTextColor:[UIColor colorWithRed:185/255.0f green:12/255.0f blue:20/255.0f alpha:1.0f]];
    
    password=[[UITextField alloc]initWithFrame:CGRectMake(13, 35, 200, 30)];
    [password setBorderStyle:UITextBorderStyleBezel];
    password.placeholder=@"请输入密码";
    [password setBackground:[UIImage imageNamed:@"writetextbox"]];
    password.secureTextEntry=YES;
    password.font=[UIFont boldSystemFontOfSize:12.0f];
    
    [demoView addSubview:password];
    [demoView addSubview:title];
    return demoView;
}

//修改会员资料
-(IBAction)updatememberdata:(id)sender
{
    updatememberdata *_updatememberdata=[[updatememberdata alloc]init];
    [self.navigationController pushViewController:_updatememberdata animated:NO];
}

//修改密码
-(IBAction)updatepassword:(id)sender
{
    updatepassword *_updatepassword=[[updatepassword alloc]init];
    [self.navigationController pushViewController:_updatepassword animated:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
