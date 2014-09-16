//
//  NakedDiamondindex.m
//  zhubao_iphone
//
//  Created by johnson on 14-9-15.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "NakedDiamondindex.h"
#import "NakedDiamondselecttype.h"
#import "getNowTime.h"

@interface NakedDiamondindex ()

@end

@implementation NakedDiamondindex

@synthesize pkey;
@synthesize pvalue;
@synthesize selecttag;
@synthesize modelButton;
@synthesize colorButton;
@synthesize netButton;
@synthesize cutButton;
@synthesize chasingButton;
@synthesize symmetryButton;
@synthesize fluorescenceButton;
@synthesize diplomaButton;

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
    list=[[NSMutableArray alloc]initWithCapacity:1];
    
}

-(void)passValue:(NSString *)value key:(NSString *)key tag:(NSString *)tag
{
    NSInteger tagint=[tag integerValue];
    if (!key) {
        key=@"全部";
        value=@"";
    }
    NSString *name=@"";
    if (tagint==0) {
        name=@"形状";
        
    }else if(tagint==1)
    {
        name=@"颜色";
    }else if(tagint==2)
    {
        name=@"净度";
    }else if(tagint==3)
    {
        name=@"切工";
    }else if(tagint==4)
    {
        name=@"抛光";
    }else if(tagint==5)
    {
        name=@"对称";
    }else if(tagint==6)
    {
        name=@"荧光";
    }else if(tagint==7)
    {
        name=@"证书";
    }
    
    NSArray *btnarray=[[NSArray alloc]initWithObjects:modelButton,colorButton,netButton,cutButton,chasingButton,symmetryButton,fluorescenceButton,diplomaButton, nil];
    for (UIButton *btn in btnarray) {
        if (btn.tag==tagint) {
            [btn setTitle:[NSString stringWithFormat:@"%@：%@",name,key] forState:UIControlStateNormal];
        }
    }
}



//选择类型
-(IBAction)choosetype:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    NakedDiamondselecttype *_NakedDiamondselecttype=[[NakedDiamondselecttype alloc]init];
    _NakedDiamondselecttype.btntag=[NSString stringWithFormat:@"%d",btn.tag];
    _NakedDiamondselecttype.delegate=self;
    [self.navigationController pushViewController:_NakedDiamondselecttype animated:NO];
}

-(IBAction)searchresult:(id)sender
{
//    getNowTime * time=[[getNowTime alloc] init];
//    NSString * nowt=[time nowTime];
//    
//    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
//    
//    NSString * uId=myDelegate.entityl.uId;
//    NSString * Upt=@"";//获取上一次的更新时间
//    if (myDelegate.entityl.puptime) {
//        Upt=myDelegate.entityl.puptime;
//    }
//    
//    //Kstr=md5(uId|type|Upt|Key|Nowt|cid)
//    NSString * Kstr=[Commons md5:[NSString stringWithFormat:@"%@|%@|%@|%@|%@",uId,@"1011",Upt,apikey,nowt]];
//    
//    NSString * surl = [NSString stringWithFormat:@"/app/aifacen.php?uId=%@&type=1011&Upt=%@&Nowt=%@&Kstr=%@&cid=0&MaxPerPage=%d&Ptype=%@&Pmetrial=%@&Pxk=%@&Pxilie=%@&twid=%@&page=%d",uId,Upt,nowt,Kstr,MaxPerPage,Ptype,Pmetrial,Pxk,Pxilie,twid,page];
//    
//    
//    NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
//    NSMutableDictionary * dict = [DataService GetDataService:URL];
//    NSArray *productlist=[dict objectForKey:@"result"];
//    [list addObjectsFromArray:productlist];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
