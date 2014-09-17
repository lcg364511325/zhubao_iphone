//
//  updatepassword.m
//  zhubao_iphone
//
//  Created by johnson on 14-9-17.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "updatepassword.h"
#import "AppDelegate.h"

@interface updatepassword ()

@end

@implementation updatepassword

@synthesize oldpassword;
@synthesize newpassword;
@synthesize checkpassword;

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

//密码修改
-(IBAction)updatepassword:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    
    if ([[Commons md5:[NSString stringWithFormat:@"%@",oldpassword.text]]  isEqualToString:myDelegate.entityl.userPass]) {
        
        if(![[NSString stringWithFormat:@"%@",newpassword.text] isEqualToString:[NSString stringWithFormat:@"%@",checkpassword.text]]){
            NSString *rowString =@"两次输入密码不一致！";
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
            return;
        }
        
        NSString * uId=myDelegate.entityl.uId;
        NSString * Upt=@"0";//获取上一次的更新时间
        
        getNowTime * time=[[getNowTime alloc] init];
        NSString * Nowt=[time nowTime];
        
        NSString * Password=[Commons md5:[NSString stringWithFormat:@"%@",oldpassword.text]];//已加密码32位md5
        NSString * NewPassword=[Commons md5:[NSString stringWithFormat:@"%@",newpassword.text]];;//已加密码32位md5
        
        //Kstr=md5(uId|type|Upt|Key|Nowt|Password|NewPassword)
        NSString * Kstr=[Commons md5:[NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@|%@",uId,@"500",Upt,apikey,Nowt,Password,NewPassword]];
        
        NSString * surl = [NSString stringWithFormat:@"/app/aiface.php?uId=%@&type=500&Upt=%@&Nowt=%@&Kstr=%@&Password=%@&NewPassword=%@",uId,Upt,Nowt,Kstr,Password,NewPassword];
        
        NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
        
        NSMutableDictionary * dict = [DataService GetDataService:URL];
        NSString *state=[NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]];
        
        if ([state isEqualToString:@"true"]) {
            myDelegate.entityl.userPass=[Commons md5:[NSString stringWithFormat:@"%@",newpassword.text]];
            NSString *rowString =@"修改成功！";
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }else{
            NSString *rowString =@"修改失败！";
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }
    }else{
        NSString *rowString =@"请输入正确的原密码！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
