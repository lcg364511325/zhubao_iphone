//
//  NakedDiamonddetail.m
//  zhubao_iphone
//
//  Created by johnson on 14-9-16.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "NakedDiamonddetail.h"
#import "AppDelegate.h"
#import "NakedDiamondlist.h"
#import "decorateView.h"

@interface NakedDiamonddetail ()

@end

@implementation NakedDiamonddetail

@synthesize nid;
@synthesize logoimg;
@synthesize modelLabel;
@synthesize noLabel;
@synthesize heightLabel;
@synthesize colorLabel;
@synthesize netLabel;
@synthesize cutLabel;
@synthesize chasingLabel;
@synthesize sysLabel;
@synthesize depthLabel;
@synthesize areaLabel;
@synthesize sizeLabel;
@synthesize fluLabel;
@synthesize dipLabel;
@synthesize priceLabel;

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
    //公司logo适应
    
    //加载数据
    [self loaddata];
}

//加载数据
-(void)loaddata
{
    getNowTime * time=[[getNowTime alloc] init];
    NSString * nowt=[time nowTime];
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    
    NSString * uId=myDelegate.entityl.uId;
    NSString * Upt=@"0";//获取上一次的更新时间
    if (myDelegate.entityl.puptime) {
        Upt=myDelegate.entityl.puptime;
    }
    //Kstr=md5(uId|type|Upt|Key|Nowt|cid)
    NSString * Kstr=[Commons md5:[NSString stringWithFormat:@"%@|%@|%@|%@|%@",uId,@"1011",Upt,apikey,nowt]];
    
    NSString * surl = [NSString stringWithFormat:@"/app/aifacen.php?uId=%@&type=1011&Upt=%@&Nowt=%@&Kstr=%@&cid=%@",uId,Upt,nowt,Kstr,nid];
    
    
    NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
    NSMutableDictionary * dict = [DataService GetDataService:URL];
    nakeddiamond=[[dict objectForKey:@"result"] objectAtIndex:0];
    
    NSString *xingzhuang=[NSString stringWithFormat:@"%@",[nakeddiamond objectAtIndex:9]];
    NakedDiamondlist *_NakedDiamondlist=[[NakedDiamondlist alloc]init];
    NSArray *modeltype=[_NakedDiamondlist showmodelandimg:xingzhuang];
    logoimg.image=[UIImage imageNamed:[modeltype objectAtIndex:1]];
    modelLabel.text=[NSString stringWithFormat:@"形状：%@",[modeltype objectAtIndex:0]];
    noLabel.text=[NSString stringWithFormat:@"编号：%@",[nakeddiamond objectAtIndex:2]];
    
    NSString * oweight=[nakeddiamond objectAtIndex:3];
    double sds=[oweight doubleValue];
    if(!sds || sds<1){
        oweight=[NSString stringWithFormat:@"0%@",oweight];
    }
    heightLabel.text=[NSString stringWithFormat:@"钻重：%@",oweight];
    colorLabel.text=[NSString stringWithFormat:@"颜色：%@",[nakeddiamond objectAtIndex:5]];
    netLabel.text=[NSString stringWithFormat:@"净度：%@",[nakeddiamond objectAtIndex:4]];
    cutLabel.text=[NSString stringWithFormat:@"切工：%@",[nakeddiamond objectAtIndex:6]];
    chasingLabel.text=[NSString stringWithFormat:@"抛光：%@",[nakeddiamond objectAtIndex:7]];
    sysLabel.text=[NSString stringWithFormat:@"对称：%@",[nakeddiamond objectAtIndex:8]];
    depthLabel.text=[NSString stringWithFormat:@"深度：%@",[nakeddiamond objectAtIndex:10]];
    areaLabel.text=[NSString stringWithFormat:@"台面：%@",[nakeddiamond objectAtIndex:11]];
    sizeLabel.text=[NSString stringWithFormat:@"尺寸：%@",[nakeddiamond objectAtIndex:12]];
    fluLabel.text=[NSString stringWithFormat:@"荧光：%@",[nakeddiamond objectAtIndex:13]];
    dipLabel.text=[NSString stringWithFormat:@"证书：%@",[nakeddiamond objectAtIndex:1]];
    priceLabel.text=[NSString stringWithFormat:@"%@",[nakeddiamond objectAtIndex:14]];
}

//加入购物车
-(IBAction)addshopcart:(id)sender{
    sqlService * sql=[[sqlService alloc]init];
    buyproduct * entity=[[buyproduct alloc]init];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    entity.producttype=@"3";
    entity.productid=nid;
    entity.pcount=@"1";
    entity.pcolor=[NSString stringWithFormat:@"%@",[nakeddiamond objectAtIndex:5]];
    entity.pvvs=[NSString stringWithFormat:@"%@",[nakeddiamond objectAtIndex:4]];
    entity.psize=[NSString stringWithFormat:@"%@",[nakeddiamond objectAtIndex:12]];
    entity.pweight=[NSString stringWithFormat:@"%@",[nakeddiamond objectAtIndex:3]];
    entity.customerid=myDelegate.entityl.uId;
    entity.pprice=[NSString stringWithFormat:@"%@",[nakeddiamond objectAtIndex:14]];
    entity.pname=[NSString stringWithFormat:@"%@",[nakeddiamond objectAtIndex:2]];
    entity.Dia_Z_weight=[NSString stringWithFormat:@"%@",[nakeddiamond objectAtIndex:9]];
    entity.photos=[NSString stringWithFormat:@"证书：%@  编号：%@",[nakeddiamond objectAtIndex:1],[nakeddiamond objectAtIndex:2]];
    
    NSString * oweight=[nakeddiamond objectAtIndex:3];
    double sds=[oweight doubleValue];
    if(!sds || sds<1){
        oweight=[NSString stringWithFormat:@"0%@",oweight];
    }
    entity.photom=[NSString stringWithFormat:@"钻重：%@  颜色：%@  净度：%@",oweight,[nakeddiamond objectAtIndex:5],[nakeddiamond objectAtIndex:4]];
    entity.photob=[NSString stringWithFormat:@"切工：%@  抛光：%@  对称：%@",[nakeddiamond objectAtIndex:6],[nakeddiamond objectAtIndex:7],[nakeddiamond objectAtIndex:8]];
    
    sql=[[sqlService alloc]init];
    buyproduct *successadd=[sql addToBuyproduct:entity];
    if (successadd) {
        [_mydelegate performSelector:@selector(refleshBuycutData)];
        NSString *rowString =@"成功加入购物车！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    } else{
        NSString *rowString =@"加入购物车失败！";
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
