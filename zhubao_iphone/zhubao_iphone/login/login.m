//
//  login.m
//  zhubao
//
//  Created by moko on 14-6-4.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "login.h"
#import "decorateView.h"

@interface login ()

@end

@implementation login

@synthesize passwordbtn;
@synthesize logoshengyu;
@synthesize bgimg;

NSInteger i=0;

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
    
    //shengyu    222222   13428706220  111111
    [self.navigationController setNavigationBarHidden:YES];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
    {
        bgimg.frame=CGRectMake(bgimg.frame.origin.x, bgimg.frame.origin.y, bgimg.frame.size.width, bgimg.frame.size.height+20);
    }
    
    
    UIImageView *usericon=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"useriocn.png"]];
    usericon.frame=CGRectMake(0, 0, 24, 26);
    _account.leftView=usericon;
    _account.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *lockiocn=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lockiocn.png"]];
    lockiocn.frame=CGRectMake(0, 0, 24, 26);
    _password.leftView=lockiocn;
    _password.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    //判断是否自动登录
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if(myDelegate.entityl && myDelegate.entityl.uId && ![myDelegate.entityl.uId isEqualToString:@"0"] && ![myDelegate.entityl.uId isEqualToString:@""]){
        
    }
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"_account"]) {
        
        _account.text=(NSString *)[[NSUserDefaults standardUserDefaults]objectForKey:@"_account"];
        _password.text=(NSString *)[[NSUserDefaults standardUserDefaults]objectForKey:@"_password"];
        [passwordbtn setImage:[UIImage imageNamed:@"remember"] forState:UIControlStateNormal];
        i=1;
    }else{
        _account.text=@"";//@"13428706220";
        _password.text=@"";//@"111111";
    }
    
       
    NSString *logopath = [[Tool getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"logopath.png"]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:logopath]) {
        [logoshengyu setImage:[[UIImage alloc] initWithContentsOfFile:logopath]];
    }
    else {
        [logoshengyu setImage:[UIImage imageNamed:@"logoshengyu"]];
    }
    
    //设置此输入框可以隐藏键盘
    _account.delegate=self;
    //[_account setKeyboardType:UIKeyboardTypeDecimalPad];
    _password.delegate=self;
    //[_password setKeyboardType:UIKeyboardTypeDecimalPad];
    
//    NSDate *  senddate=[NSDate date];
//    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"YYYYMMdd"];
//    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    //[self autogetData];
//    tiplabellog.lineBreakMode = NSLineBreakByWordWrapping;
//    tiplabellog.numberOfLines = 0;
//    [tiplabellog setText:@""];
    
    //判断当前天是否已经有更新过数据了
    //if (![locationString isEqualToString:(NSString *)[[NSUserDefaults standardUserDefaults]objectForKey:@"autodata"]]) {
        
        //[self autogetData];
    //}else{
        //AutoGetData * getdata=[[AutoGetData alloc] init];
        //不同步数据，但去下载图片组
        //[getdata getAllZIPPhotos];
    //}
    
    
//    myApi * sd=[[myApi alloc] init];
//    [sd getMyInfo];
    
}


//-(id)autogetData{
//    @try {
//        
//        tipLable.text=@"正更新数据中...";
//        [_submitlogin setTag:1];
//        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            // 耗时的操作（异步操作）
//            
//            AutoGetData * getdata=[[AutoGetData alloc] init];
//            //[getdata getDataInsertTable:tiplabellog];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                //[_submitlogin setTitle:@"登录" forState:UIControlStateNormal];
//                [_submitlogin setTag:0];
//                
//                tipLable.text=@"";
//                
//                // 更新界面（处理结果）
//                NSDate *  senddate=[NSDate date];
//                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//                [dateformatter setDateFormat:@"YYYYMMdd"];
//                NSString *  locationString=[dateformatter stringFromDate:senddate];
//                
//                //标识今天已经更新过数据了
//                [[NSUserDefaults standardUserDefaults]setObject:locationString forKey:@"autodata"];
//                
//                //同步完数据了，则再去下载图片组
//                //[getdata getAllZIPPhotos];
//                [getdata getAllProductPhotos];
//            });
//        });
//    }
//    @catch (NSException *exception) {
//        
//    }
//    @finally {
//        
//    }
//    
//}

-(IBAction)loginAction:(id)sender
{
    @try {
        NSString *rowString =@"正在登录。。。";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alter show];
        
        UIButton *resultButton = (UIButton *)sender;
        
        if(resultButton.tag==1)return;
        
        [resultButton setTag:1];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作（异步操作）
            
            NSString * code = @"0";
            NSString * account = _account.text;
            NSString * password = _password.text;
            
            LoginApi * service = [[LoginApi alloc] init];
            LoginEntity * result = [service login:account password:password verlity:code];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面（处理结果）
                [alter dismissWithClickedButtonIndex:0 animated:NO];
                if(result){
                    
                    //判断是否要保存密码
                    if(i==1){
                        [[NSUserDefaults standardUserDefaults]setObject:account forKey:@"_account"];
                        [[NSUserDefaults standardUserDefaults]setObject:password forKey:@"_password"];
                    }else{
                        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"_account"];
                        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"_password"];
                    }
                    
                    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
                    
                    myDelegate.entityl=result;
                    
                    customer * n = [[customer alloc] init];
                    n.uId = result.uId;
                    n.userType = result.userType;
                    n.userName = result.userName;
                    n.userPass = result.userPass;
                    n.userDueDate = result.userDueDate;
                    n.userTrueName = result.userTrueName;
                    n.sfUrl = result.sfUrl;
                    n.lxrName = result.lxrName;
                    n.Sex = result.Sex;
                    n.bmName = result.bmName;
                    n.Email = result.Email;
                    n.Phone = result.Phone;
                    n.Lxphone = result.Lxphone;
                    n.Sf = result.Sf;
                    n.Cs = result.Cs;
                    n.Address = result.Address;

                    //登录成功，进入系统首页
                    NSLog(@"登录成功，进入系统首页");
                    //[[[UIAlertView alloc] initWithTitle:@"提示" message:@"登录成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                    
                    decorateView *_decorateView=[[decorateView alloc]init];
                    [self.navigationController pushViewController:_decorateView animated:NO];
                    
                    
                }else{
                    //测试中，进入系统首页
                    
                    NSString *info=@"登录失败！";
                    // NSLog(@"登录失败------:%@",info);
                    [[[UIAlertView alloc] initWithTitle:@"信息提示" message:info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil] show];
                    
                    //Index *sysmenu=[[Index alloc] init];
                    //[self.navigationController pushViewController:sysmenu animated:NO];
                }
                
                //[resultButton setTitle:@"登录" forState:UIControlStateNormal];
                [resultButton setTag:0];
            });
        });
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

//记住密码
-(IBAction)rememberpassword:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    if (i==0) {
        [btn setImage:[UIImage imageNamed:@"remember"] forState:UIControlStateNormal];
        i++;
    }else if (i==1)
    {
        [btn setImage:[UIImage imageNamed:@"forget"] forState:UIControlStateNormal];
        i--;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(done:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer: tapGestureRecognizer];   //只需要点击非文字输入区域就会响应hideKeyBoard
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.3f];
    float width=self.view.frame.size.width;
    float height=self.view.frame.size.height;
    //CGRect rect=CGRectMake(0.0f,-80*(textField.tag),width,height);//上移80个单位，按实际情况设置
    CGRect rect=CGRectMake(0.0f,-80,width,height);//上移80个单位，按实际情况设置
    self.view.frame=rect;
    [UIView commitAnimations];
    
    return YES;
}

-(void)done:(id)sender
{
    [self.view endEditing:YES];
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.3f];
    float width=self.view.frame.size.width;
    float height=self.view.frame.size.height;
    CGRect rect=CGRectMake(0.0f,0.0f,width,height);//上移80个单位，按实际情况设置
    //if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
        //rect=CGRectMake(0.0f,60.0f,width,height);//上移80个单位，按实际情况设置
    self.view.frame=rect;
    [UIView commitAnimations];
    
    UITapGestureRecognizer *tapGestureRecognizer=(UITapGestureRecognizer *)sender;
    [tapGestureRecognizer setEnabled:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
