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
- (IBAction)createDemoView:(id)sender
{
    shadow=[[UIView alloc]initWithFrame:self.view.frame];
    shadow.backgroundColor=[UIColor blackColor];
    shadow.alpha=0.5;
    
    demoView = [[UIView alloc] initWithFrame:CGRectMake(50, 224, 220, 105)];
    [demoView setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:234.0f/255.0f blue:234.0f/255.0f alpha:1.0f]];
    
    
    UIImageView *bgimgview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 220, 35)];
    [bgimgview setBackgroundColor:[UIColor colorWithRed:8.0f/255.0f green:46.0f/255.0f blue:85.0f/255.0f alpha:1.0f]];
    
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 220, 35)];
    title.text=@"密码验证";
    title.textAlignment = NSTextAlignmentCenter;
    title.font=[UIFont systemFontOfSize:17.0f];
    [title setTextColor:[UIColor colorWithRed:152.0f/255.0f green:152.0f/255.0f blue:152.0f/255.0f alpha:1.0f]];
    title.backgroundColor=[UIColor clearColor];
    
    password=[[UITextField alloc]initWithFrame:CGRectMake(13, 45, 200, 30)];
    [password setBorderStyle:UITextBorderStyleBezel];
    password.placeholder=@"请输入密码";
    [password setBackground:[UIImage imageNamed:@"textbox_midbg"]];
    password.secureTextEntry=YES;
    password.font=[UIFont systemFontOfSize:12.0f];
    
    UIButton *okbtn=[[UIButton alloc]initWithFrame:CGRectMake(13, 75, 60, 20)];
    [okbtn setTitle:@"确定" forState:UIControlStateNormal];
    [okbtn setTitleColor:[UIColor colorWithRed:152.0f/255.0f green:152.0f/255.0f blue:152.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    okbtn.titleLabel.font=[UIFont systemFontOfSize:15.0f];
    okbtn.tag=1;
    [okbtn addTarget:self action:@selector(lookfororder:) forControlEvents:UIControlEventTouchDown];
    
    UIButton *cancelbtn=[[UIButton alloc]initWithFrame:CGRectMake(150, 75, 60, 20)];
    [cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelbtn setTitleColor:[UIColor colorWithRed:152.0f/255.0f green:152.0f/255.0f blue:152.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    cancelbtn.titleLabel.font=[UIFont systemFontOfSize:15.0f];
    cancelbtn.tag=0;
    [cancelbtn addTarget:self action:@selector(lookfororder:) forControlEvents:UIControlEventTouchDown];
    
    [demoView addSubview:bgimgview];
    [demoView addSubview:password];
    [demoView addSubview:title];
    [demoView addSubview:okbtn];
    [demoView addSubview:cancelbtn];
    
    [self.view addSubview:shadow];
    [self.view addSubview:demoView];
}

-(void)lookfororder:(UIButton *)btn
{
    NSInteger buttonIndex=btn.tag;
    if (buttonIndex==1) {
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
            checkorder *_checkorder=[[checkorder alloc]init];
            _checkorder.url=surl;
            [self.navigationController pushViewController:_checkorder animated:NO];
            [shadow removeFromSuperview];
            [demoView removeFromSuperview];
            
        }else{
            password.text=nil;
            NSString *rowString =@"请输入正确密码！";
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }
    }else{
        [shadow removeFromSuperview];
        [demoView removeFromSuperview];
    }
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
