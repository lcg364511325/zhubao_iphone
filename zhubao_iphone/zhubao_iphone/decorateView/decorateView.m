//
//  decorateView.m
//  zhubao_iphone
//
//  Created by johnson on 14-9-11.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "decorateView.h"
#import "XNTabBarButton.h"
#import "frontindex.h"
#import "productindex.h"
#import "NakedDiamondindex.h"
#import "diplomaselect.h"
#import "membercenter.h"
#import "customtailor.h"
#import "shopcart.h"
#import "login.h"

@interface decorateView ()

/**
 *  设置之前选中的按钮
 */
@property (nonatomic, weak) UIButton *selectedBtn;

@end

@implementation decorateView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    isverson=0;
    
    //添加controller
    [self addcontroller];
    
    //顶部菜单
    [self createtopmenu];
    
    //自定义tabbar
    [self identitytabbar];
    
    //刷新购物车显示数量
    [self refleshBuycutData];
    
    
}

//添加controller
-(void)addcontroller
{
    frontindex *_frontindex=[[frontindex alloc]init];
    productindex *_productindex=[[productindex alloc]init];
    NakedDiamondindex *_NakedDiamondindex=[[NakedDiamondindex alloc]init];
    customtailor *_customtailor=[[customtailor alloc]init];
    diplomaselect *_diplomaselect=[[diplomaselect alloc]init];
    _NakedDiamondindex.mydelegate=self;
    _productindex.mydelegate=self;
    _customtailor.mydelegate=self;
    self.viewControllers=[NSArray arrayWithObjects:_frontindex,_productindex,_NakedDiamondindex,_customtailor,_diplomaselect, nil];
}


//顶部菜单
-(void)createtopmenu
{
    //菜单背景
    UIView *topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    UIImageView *topimg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    [topimg setImage:[UIImage imageNamed:@"menu_bg"]];
    
    //logo图片
    UIImageView *logoimg=[[UIImageView alloc]initWithFrame:CGRectMake(36, 5, 30, 30)];
    [logoimg setImage:[UIImage imageNamed:@"plogo"]];
    [topview addSubview:logoimg];
    
    //购物车按钮
    UIButton *buycartbtn=[[UIButton alloc]initWithFrame:CGRectMake(195, 7, 30, 25)];
    [buycartbtn setImage:[UIImage imageNamed:@"shopping"] forState:UIControlStateNormal];
    [buycartbtn addTarget:self action:@selector(shopcartshow) forControlEvents:UIControlEventTouchDown];
    [topview addSubview:buycartbtn];
    
    //购物车数量显示
    buycountbtn=[[UIButton alloc]initWithFrame:CGRectMake(buycartbtn.frame.origin.x+23, 5, 15, 15)];
    [buycountbtn setBackgroundImage:[UIImage imageNamed:@"round"] forState:UIControlStateNormal];
    [buycountbtn setHidden:YES];
    [buycountbtn.titleLabel setFont:[UIFont systemFontOfSize:10.0f]];
    buycountbtn.tintColor=[UIColor whiteColor];
    [topview addSubview:buycountbtn];
    
    //设置按钮
    UIButton *settingbtn=[[UIButton alloc]initWithFrame:CGRectMake(buycartbtn.frame.origin.x+50, 7, 25, 25)];
    [settingbtn setImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
    [settingbtn addTarget:self action:@selector(settingviewshow) forControlEvents:UIControlEventTouchDown];
    [topview addSubview:settingbtn];
    
    //设置按钮菜单
    hiddenview=[[UIView alloc]initWithFrame:self.view.frame];
    settingview=[[UIView alloc]initWithFrame:CGRectMake(210, 40, 100, 90)];
    UIImageView *settingimg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 90)];
    [settingimg setImage:[UIImage imageNamed:@"settingbg"]];
    //settingimg.hidden=YES;
    [settingview addSubview:settingimg];
    
    UIButton *membercenterbtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 7, 80, 30)];
    [membercenterbtn setTitle:@"会员中心" forState:UIControlStateNormal];
    [membercenterbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    membercenterbtn.titleLabel.font=[UIFont systemFontOfSize:12.0f];
    [membercenterbtn addTarget:self action:@selector(setmembercenter) forControlEvents:UIControlEventTouchDown];
    [settingview addSubview:membercenterbtn];
    
    UIButton *versonupdatebtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 35, 80, 30)];
    [versonupdatebtn setTitle:@"版本更新" forState:UIControlStateNormal];
    [versonupdatebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    versonupdatebtn.titleLabel.font=[UIFont systemFontOfSize:12.0f];
    [versonupdatebtn addTarget:self action:@selector(updateVerson) forControlEvents:UIControlEventTouchDown];
    [settingview addSubview:versonupdatebtn];
    
    UIButton *logoutbtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 63, 80, 30)];
    [logoutbtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    logoutbtn.titleLabel.font=[UIFont systemFontOfSize:12.0f];
    [logoutbtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchDown];
    [settingview addSubview:logoutbtn];

    [self.view addSubview:topimg];
    [self.view addSubview:topview];
}


//自定义tabbar
-(void)identitytabbar
{
    
    //删除现有的tabBar
    CGRect rect = self.tabBar.bounds; //这里要用bounds来加, 否则会加到下面去.看不见
    //LogFrame(self.tabBar);
    
    //测试添加自己的视图
    NSUInteger count=self.viewControllers.count;
    UIImageView *bgimg=[[UIImageView alloc]initWithFrame:rect];
    [bgimg setImage:[UIImage imageNamed:@"footer_bg1"]];
    for (int i=0; i<count-1; i++) {
        UIImageView *lineimg=[[UIImageView alloc]init];
        [lineimg setImage:[UIImage imageNamed:@"footer_line"]];
        NSInteger width=self.view.frame.size.width/count;
        lineimg.frame=CGRectMake(width*(i+1), 0, 2, 50);
        [bgimg addSubview:lineimg];
    }
    [self.tabBar addSubview:bgimg];
    XNTabBar *myView = [[XNTabBar alloc] init]; //设置代理必须改掉前面的类型,不能用UIView
    myView.delegate = self; //设置代理
    myView.frame = rect;
    [self.tabBar addSubview:myView]; //添加到系统自带的tabBar上, 这样可以用的的事件方法. 而不必自己去写
    
    //为控制器添加按钮
    for (int i=0; i<count; i++) { //根据有多少个子视图控制器来进行添加按钮
        
        NSString *imageName = [NSString stringWithFormat:@"TabBar%d", i + 1];
        NSString *imageNameSel = [NSString stringWithFormat:@"TabBar%dSel", i + 1];
        
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *imageSel = [UIImage imageNamed:imageNameSel];
        
        [myView addButtonWithImage:image selectedImage:imageSel];
    }
}

/**永远别忘记设置代理*/
- (void)tabBar:(XNTabBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to {
    self.selectedIndex = to;
}

//购物车页面跳转
-(void)shopcartshow
{
    shopcart *_shopcart=[[shopcart alloc]init];
    _shopcart.mydelegate=self;
    [self.navigationController pushViewController:_shopcart animated:NO];
}

//设置页面跳转
-(void)settingviewshow
{
    [self.view addSubview:hiddenview];
    [self.view addSubview:settingview];
}

//点击settingview以外的地方触发事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    if (!CGRectContainsPoint([settingview frame], pt)) {
        //to-do
        [settingview removeFromSuperview];
        [hiddenview removeFromSuperview];
    }
}

//刷新购物车数量显示
-(void)refleshBuycutData
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    sqlService *shopcar=[[sqlService alloc] init];
    NSArray *shoppingcartlist=[shopcar GetBuyproductList:myDelegate.entityl.uId];
    if ([shoppingcartlist count]!=0) {
        [buycountbtn setTitle:[NSString stringWithFormat:@"%d",[shoppingcartlist count]] forState:UIControlStateNormal];
        [buycountbtn setHidden:NO];
    }else{
        buycountbtn.hidden=YES;
    }
    
}

//退出登录
-(void)logout
{
    isverson=0;
    NSString *rowString =@"是否退出登录？";
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alter show];
}

//会员中心
-(void)setmembercenter
{
    if (self.viewControllers.count!=1) {
        membercenter *_membercenter=[[membercenter alloc]init];
        self.viewControllers=[NSArray arrayWithObjects:_membercenter,nil];
        [settingview removeFromSuperview];
        [hiddenview removeFromSuperview];
        
        //测试添加自己的视图
        CGRect rect = self.tabBar.frame;
        
        //底层视图
        bgview=[[UIView alloc]initWithFrame:rect];
        //背景
        bgfimg=[[UIImageView alloc]initWithFrame:rect];
        [bgfimg setImage:[UIImage imageNamed:@"footer_bg1"]];
        
        //返回按钮
        UIButton *backbutton=[[UIButton alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
        [backbutton setImage:[UIImage imageNamed:@"return_icon"] forState:UIControlStateNormal];
        [backbutton addTarget:self action:@selector(closemembercenter) forControlEvents:UIControlEventTouchDown];
        
        //标题
        UIButton *titlebtn=[[UIButton alloc] initWithFrame:CGRectMake(45, 5, 100, 40)];
        [titlebtn setTitle:@"返回首页" forState:UIControlStateNormal];
        titlebtn.titleLabel.font=[UIFont boldSystemFontOfSize:17.0f];
        [titlebtn setTitleColor:[UIColor colorWithRed:190/255.0 green:148/255.0 blue:80/255.0 alpha:1.0f]forState:UIControlStateNormal];
        [titlebtn addTarget:self action:@selector(closemembercenter) forControlEvents:UIControlEventTouchDown];
        [bgview addSubview:titlebtn];
        
        [bgview addSubview:backbutton];
        
        [self.view addSubview:bgfimg];
        [self.view addSubview:bgview];
    }
}

-(void)closemembercenter
{
    [self addcontroller];
    [self identitytabbar];
    [bgfimg removeFromSuperview];
    [bgview removeFromSuperview];
}

//alertview响应事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (isverson==0) {
        if (buttonIndex==1) {
            AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
            myDelegate.entityl=[[LoginEntity alloc]init];
            
            login * _login=[[login alloc] init];
            [self.navigationController pushViewController:_login animated:NO];
        }
    }else if (isverson==1)
    {
        
        isverson=0;
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        [settingview removeFromSuperview];
        [hiddenview removeFromSuperview];
    }
}


//版本更新
-(void)updateVerson
{
    isverson=1;
    getNowTime * time=[[getNowTime alloc] init];
    NSString * nowt=[time nowTime];
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    
    NSString * uId=myDelegate.entityl.uId;
    NSString * Upt=@"0";//获取上一次的更新时间
    if (myDelegate.entityl.puptime) {
        Upt=myDelegate.entityl.puptime;
    }
    //Kstr=md5(uId|type|Upt|Key|Nowt|cid)
    NSString * Kstr=[Commons md5:[NSString stringWithFormat:@"%@|%@|%@|%@|%@",uId,@"9998",Upt,apikey,nowt]];
    
    NSString * surl = [NSString stringWithFormat:@"/app/aifacen.php?uId=%@&type=9998&Upt=%@&Nowt=%@&Kstr=%@",uId,Upt,nowt,Kstr];
    
    
    NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
    NSMutableDictionary * dict = [DataService GetDataService:URL];
    NSString *status=[NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]];
    if ([status isEqualToString:@"true"]) {
        NSArray *versoninfo=[[dict objectForKey:@"result"] objectAtIndex:0];
        url=[NSString stringWithFormat:@"%@",[versoninfo objectAtIndex:0]];
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *oldappVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSString *newappVersion=[NSString stringWithFormat:@"%@",[versoninfo objectAtIndex:2]];
        if (![oldappVersion isEqualToString:newappVersion]) {
            NSString *rowString =[NSString stringWithFormat:@"更新内容：%@",[versoninfo objectAtIndex:1]];
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"发现新版本%@,是否升级？",newappVersion] message:rowString delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alter show];
        }else
        {
            NSString *rowString =@"当前版本已是最新版本";
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }
    }else
    {
        NSString *rowString =@"未知错误";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
