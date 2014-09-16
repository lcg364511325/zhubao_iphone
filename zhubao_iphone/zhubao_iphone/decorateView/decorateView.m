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
    
    //添加controller
    [self addcontroller];
    
    //顶部菜单
    [self createtopmenu];
    
    //自定义tabbar
    [self identitytabbar];
    
    
}

//添加controller
-(void)addcontroller
{
    frontindex *_frontindex=[[frontindex alloc]init];
    productindex *_productindex=[[productindex alloc]init];
    NakedDiamondindex *_NakedDiamondindex=[[NakedDiamondindex alloc]init];
    diplomaselect *_diplomaselect=[[diplomaselect alloc]init];
    membercenter *_membercenter=[[membercenter alloc]init];
    
    self.viewControllers=[NSArray arrayWithObjects:_frontindex,_productindex,_NakedDiamondindex,_diplomaselect,_diplomaselect,_membercenter, nil];
}


//顶部菜单
-(void)createtopmenu
{
    //菜单背景
    UIView *topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    UIImageView *topimg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    [topimg setImage:[UIImage imageNamed:@"menu_bg"]];
    
    //logo图片
    UIImageView *logoimg=[[UIImageView alloc]initWithFrame:CGRectMake(36, 0, 40, 40)];
    [logoimg setImage:[UIImage imageNamed:@"logo"]];
    [topview addSubview:logoimg];
    
    //购物车按钮
    UIButton *buycartbtn=[[UIButton alloc]initWithFrame:CGRectMake(195, 5, 40, 30)];
    [buycartbtn setImage:[UIImage imageNamed:@"shopping"] forState:UIControlStateNormal];
    [buycartbtn addTarget:self action:@selector(sss) forControlEvents:UIControlEventTouchDown];
    [topview addSubview:buycartbtn];
    
    //购物车数量显示
    UIButton *buycountbtn=[[UIButton alloc]initWithFrame:CGRectMake(buycartbtn.frame.origin.x+30, 3, 15, 15)];
    [buycountbtn setBackgroundImage:[UIImage imageNamed:@"round"] forState:UIControlStateNormal];
    [buycountbtn setTitle:@"0" forState:UIControlStateNormal];
    [buycountbtn.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    buycountbtn.tintColor=[UIColor whiteColor];
    [topview addSubview:buycountbtn];
    
    //设置按钮
    UIButton *settingbtn=[[UIButton alloc]initWithFrame:CGRectMake(buycartbtn.frame.origin.x+50, 5, 30, 30)];
    [settingbtn setImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
    [topview addSubview:settingbtn];
    
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
    UIImageView *bgimg=[[UIImageView alloc]initWithFrame:rect];
    [bgimg setImage:[UIImage imageNamed:@"footer_bg"]];
    [self.tabBar addSubview:bgimg];
    XNTabBar *myView = [[XNTabBar alloc] init]; //设置代理必须改掉前面的类型,不能用UIView
    myView.delegate = self; //设置代理
    myView.frame = rect;
    [self.tabBar addSubview:myView]; //添加到系统自带的tabBar上, 这样可以用的的事件方法. 而不必自己去写
    
    //为控制器添加按钮
    for (int i=0; i<6; i++) { //根据有多少个子视图控制器来进行添加按钮
        
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

-(void)sss
{
    frontindex *_frontindex=[[frontindex alloc]init];
    [self.navigationController pushViewController:_frontindex animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
