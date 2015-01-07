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

@synthesize clogoimg;
@synthesize btntag;
@synthesize delegate;
@synthesize submitButton;
@synthesize titleLabel;

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
    
//    //公司logo适应
//    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
//    {
//        clogoimg.frame=CGRectMake(clogoimg.frame.origin.x, clogoimg.frame.origin.y, 40, 20);
//    }
}


//设置navigationbar的标题
-(void)setbartitle
{
    NSDictionary *namedic;
    NSArray *key;
    NSArray *value;
    NSInteger btnvalue=[btntag integerValue];
    if (btnvalue==0) {
//        titleLabel.text=@"形状";
        
        key=[[NSArray alloc] initWithObjects:@"圆形",@"公主方",@"祖母绿",@"雷蒂恩",@"椭圆形",@"橄榄形",@"枕形",@"梨形",@"心形",@"辐射形",nil];
        value=[[NSArray alloc] initWithObjects:@"RB",@"PE",@"EM",@"RD",@"OL",@"MQ",@"CU",@"PR",@"HT",@"ASH",nil];
        
    }else if(btnvalue==1)
    {
//        titleLabel.text=@"颜色";
        
        value=key=[[NSArray alloc] initWithObjects:@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M", nil];
    }else if(btnvalue==2)
    {
//        titleLabel.text=@"净度";
        
        value=key=[[NSArray alloc] initWithObjects:@"FL",@"IF",@"VVS1",@"VVS2",@"VS1",@"VS2",@"SI1",@"SI2",@"I1",@"I2", nil];
    }else if(btnvalue==3)
    {
//        titleLabel.text=@"切工";
        
        value=key=[[NSArray alloc] initWithObjects:@"EX",@"VG",@"GD",@"Fair", nil];
    }else if(btnvalue==4)
    {
//        titleLabel.text=@"抛光";
        
        value=key=[[NSArray alloc] initWithObjects:@"EX",@"VG",@"GD",@"Fair", nil];
    }else if(btnvalue==5)
    {
//        titleLabel.text=@"对称";
        
        value=key=[[NSArray alloc] initWithObjects:@"EX",@"VG",@"GD",@"Fair", nil];
    }else if(btnvalue==6)
    {
//        titleLabel.text=@"荧光";
        
        key=[[NSArray alloc] initWithObjects:@"N",@"F",@"M",@"S",@"VS", nil];
        value=[[NSArray alloc] initWithObjects:@"Non,None",@"Fnt",@"Med",@"Stg,Sl",@"Vsl,Vst", nil];
    }else if(btnvalue==7)
    {
//        titleLabel.text=@"证书";
        
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
    UIButton *btn;
    UIImage *img;
    if ([btntag intValue]!=0) {
        for (int i=0; i<count; i++) {
            NSDictionary *dict=[namelist objectAtIndex:i];
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
            [btn setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:234.0f/255.0f blue:234.0f/255.0f alpha:1]];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(changgestate:) forControlEvents:UIControlEventTouchDown];
            btn.titleLabel.font=[UIFont boldSystemFontOfSize:12.0f];
            btn.tag=i;
            
            CALayer * downButtonLayer = [btn layer];
            [downButtonLayer setMasksToBounds:YES];
            [downButtonLayer setBorderWidth:1.0];
            [downButtonLayer setBorderColor:[[UIColor colorWithRed:223.0f/255.0f green:223.0f/255.0f blue:223.0f/255.0f alpha:1] CGColor]];
            [self.view insertSubview:btn atIndex:i];
            
            [self.view addSubview:btn];
            
        }
        
        submitButton.frame=CGRectMake(submitButton.frame.origin.x, btn.frame.origin.y+40, submitButton.frame.size.width, submitButton.frame.size.height);
        
    }else{
        for (int i=0; i<count; i++) {
            NSDictionary *dict=[namelist objectAtIndex:i];
            if ((row=i%2)==0) {
                line=i/2;
            }
            if (row==0) {
                btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 61+50*line, 160, 50)];
            }else if (row==1){
                btn=[[UIButton alloc]initWithFrame:CGRectMake(160, 61+50*line, 160, 50)];
            }
            if (i==9) {
                img=[UIImage imageNamed:@"diamond10"];
            }else{
                img=[UIImage imageNamed:[NSString stringWithFormat:@"diamond0%d",i+1]];
            }
            [btn setImage:[self scaleToSize:img :CGSizeMake(30, 30)] forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 110)];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 60)];
            [btn setTitle:[dict objectForKey:@"key"] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:234.0f/255.0f blue:234.0f/255.0f alpha:1]];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(changgestate:) forControlEvents:UIControlEventTouchDown];
            btn.titleLabel.font=[UIFont boldSystemFontOfSize:12.0f];
            btn.tag=i;
            
            CALayer * downButtonLayer = [btn layer];
            [downButtonLayer setMasksToBounds:YES];
            [downButtonLayer setBorderWidth:1.0];
            [downButtonLayer setBorderColor:[[UIColor colorWithRed:223.0f/255.0f green:223.0f/255.0f blue:223.0f/255.0f alpha:1] CGColor]];
            [self.view insertSubview:btn atIndex:i];
            
            [self.view addSubview:btn];
            
        }
        
        submitButton.frame=CGRectMake(submitButton.frame.origin.x, btn.frame.origin.y+60, submitButton.frame.size.width, submitButton.frame.size.height);
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

//图片缩放
- (UIImage *)scaleToSize:(UIImage *)image :(CGSize)newsize {
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(newsize);
    
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
