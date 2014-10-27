//
//  NakedDiamondselecttype.m
//  zhubao_iphone
//
//  Created by johnson on 14-9-15.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "NakedDiamondselecttype.h"
#import "NakedDiamondindex.h"
#import "NakedDiamondlistCell.h"

@interface NakedDiamondselecttype ()

@end

@implementation NakedDiamondselecttype

@synthesize UINavigationBar;
@synthesize clogoimg;
@synthesize btntag;
@synthesize delegate;

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
    namelist=[[NSMutableArray alloc]initWithCapacity:5];
    
    [self setbartitle];
    
    [self loaddata];
    
    //公司logo适应
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    clogoimg.frame=CGRectMake(clogoimg.frame.origin.x, clogoimg.frame.origin.y, 40, 20);
    self.UINavigationBar.tintColor=[UIColor blackColor];
#endif
}


//设置navigationbar的标题
-(void)setbartitle
{
    NSDictionary *namedic;
    NSArray *key;
    NSArray *value;
    NSInteger btnvalue=[btntag integerValue];
    if (btnvalue==0) {
        self.UINavigationItem.title=@"形状";
        
        key=[[NSArray alloc] initWithObjects:@"圆形",@"公主方",@"祖母绿",@"雷蒂恩",@"椭圆形",@"橄榄形",@"枕形",@"梨形",@"心形",@"辐射形",nil];
        value=[[NSArray alloc] initWithObjects:@"RB",@"PE",@"EM",@"RD",@"OL",@"MQ",@"CU",@"PR",@"HT",@"ASH",nil];
        
    }else if(btnvalue==1)
    {
        self.UINavigationItem.title=@"颜色";
        
        value=key=[[NSArray alloc] initWithObjects:@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M", nil];
    }else if(btnvalue==2)
    {
        self.UINavigationItem.title=@"净度";
        
        value=key=[[NSArray alloc] initWithObjects:@"FL",@"IF",@"VVS1",@"VVS2",@"VS1",@"VS2",@"SI1",@"SI2",@"I1",@"I2", nil];
    }else if(btnvalue==3)
    {
        self.UINavigationItem.title=@"切工";
        
        value=key=[[NSArray alloc] initWithObjects:@"EX",@"VG",@"GD",@"Fair", nil];
    }else if(btnvalue==4)
    {
        self.UINavigationItem.title=@"抛光";
        
        value=key=[[NSArray alloc] initWithObjects:@"EX",@"VG",@"GD",@"Fair", nil];
    }else if(btnvalue==5)
    {
        self.UINavigationItem.title=@"对称";
        
        value=key=[[NSArray alloc] initWithObjects:@"EX",@"VG",@"GD",@"Fair", nil];
    }else if(btnvalue==6)
    {
        self.UINavigationItem.title=@"荧光";
        
        key=[[NSArray alloc] initWithObjects:@"N",@"F",@"M",@"S",@"VS", nil];
        value=[[NSArray alloc] initWithObjects:@"Non,None",@"Fnt",@"Med",@"Stg,Sl",@"Vsl,Vst", nil];
    }else if(btnvalue==7)
    {
        self.UINavigationItem.title=@"证书";
        
        key=[[NSArray alloc] initWithObjects:@"GIA",@"IGI",@"NGTC",@"HRD",@"EGL",@"Other", nil];
        value=[[NSArray alloc] initWithObjects:@"GIA",@"IGI",@"NGTC",@"HRD",@"EGL",@"", nil];
    }
    
    NSInteger count=[key count];
    for (int i=0; i<count; i++) {
        namedic=[NSDictionary dictionaryWithObjectsAndKeys:[key objectAtIndex:i],@"key",[value objectAtIndex:i],@"value",nil];
        [namelist addObject:namedic];
    }
}

-(void)loaddata
{
    NSInteger count=[namelist count];
    NSInteger line=0;
    NSInteger row=1;
    for (int i=0; i<count; i++) {
        NSDictionary *dict=[namelist objectAtIndex:i];
        UIButton *btn;
        if ((row=i%3)==0) {
            line=i/3;
        }
        if (row==0) {
            btn=[[UIButton alloc]initWithFrame:CGRectMake(7, 61+50*line, 100, 30)];
        }else if (row==1){
            btn=[[UIButton alloc]initWithFrame:CGRectMake(110, 61+50*line, 100, 30)];
        }else if (row==2)
        {
            btn=[[UIButton alloc]initWithFrame:CGRectMake(213, 61+50*line, 100, 30)];
        }
        [btn setTitle:[dict objectForKey:@"key"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"categorybg"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(changgestate:) forControlEvents:UIControlEventTouchDown];
        btn.titleLabel.font=[UIFont boldSystemFontOfSize:12.0f];
        btn.tag=i;
        [self.view addSubview:btn];
        
    }
}


//按钮点击事件
-(void)changgestate:(UIButton *)btn
{
    NSDictionary *selectdata=[namelist objectAtIndex:btn.tag];
    NSMutableArray *keyMutableArray = [[NSMutableArray alloc]initWithCapacity:5];
    NSMutableArray *valueMutableArray = [[NSMutableArray alloc]initWithCapacity:5];
    if (skey.length!=0) {
        NSArray  * keyarray= [skey componentsSeparatedByString:@","];
        NSArray  * valuearray= [svalue componentsSeparatedByString:@","];
        keyMutableArray = [NSMutableArray arrayWithArray:keyarray];
        valueMutableArray = [NSMutableArray arrayWithArray:valuearray];
    }
    NSInteger count=[keyMutableArray count];
    int i;
    BOOL isequal=NO;
    for (i=0; i<count; i++) {
        isequal=[[selectdata objectForKey:@"key"] isEqualToString:[keyMutableArray objectAtIndex:i]];
        if (isequal) {
            [keyMutableArray removeObjectAtIndex:i];
            [valueMutableArray removeObjectAtIndex:i];
            i=count;
        }
    }
    if (!isequal) {
        [keyMutableArray addObject:[selectdata objectForKey:@"key"]];
        [valueMutableArray addObject:[selectdata objectForKey:@"value"]];
        [btn setBackgroundImage:[UIImage imageNamed:@"cateselected"] forState:UIControlStateNormal];
    }else
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"categorybg"] forState:UIControlStateNormal];
    }
    skey=[[NSMutableString alloc] init];
    svalue=[[NSMutableString alloc] init];
    for (NSString *index in keyMutableArray) {
        if (skey.length!=0) {
            [skey appendString:@","];
            [skey appendString:index];
        }else{
            [skey appendString:index];
        }
    }
    for (NSString *index in valueMutableArray) {
        if (svalue.length!=0) {
            [svalue appendString:@","];
            [svalue appendString:index];
        }else{
            [svalue appendString:index];
        }
    }
}

-(IBAction)returnvalue:(id)sender
{
    
    if (skey.length==0) {
        [skey appendString:@""];
        [svalue appendString:@""];
    }
    
    //回调方法更新
    [delegate passValue:svalue key:skey tag:btntag];
    
    [self.navigationController popViewControllerAnimated:NO];
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
