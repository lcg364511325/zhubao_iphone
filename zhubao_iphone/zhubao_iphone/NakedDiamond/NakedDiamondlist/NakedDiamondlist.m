//
//  NakedDiamondlist.m
//  zhubao_iphone
//
//  Created by johnson on 14-9-16.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "NakedDiamondlist.h"
#import "NakedDiamondsrCell.h"
#import "AppDelegate.h"
#import "MJRefresh.h"
#import "NakedDiamonddetail.h"

@interface NakedDiamondlist ()

@end

@implementation NakedDiamondlist

@synthesize condition;
@synthesize nksrTView;
@synthesize countLabel;

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
    
    page=1;
    pagesize=10;
    list=[[NSMutableArray alloc]initWithCapacity:1];
    
    //获得条件值
    [self getconditionvalue];
    //初始化数据
    [self loaddata];
    
    if ([list count]==0) {
        countLabel.text=@"共搜索到0颗钻石";
    }else
    {
        NSString *count=[[list objectAtIndex:0] objectAtIndex:29];
        countLabel.text=[NSString stringWithFormat:@"共搜索到%@颗钻石",count];
    }
    
    //上拉刷新下拉加载提示
    [nksrTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [nksrTView reloadData];
        [nksrTView headerEndRefreshing];
    }];
    
    [nksrTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];;
        [nksrTView reloadData];
        [nksrTView footerEndRefreshing];
    }];
    
    
}

//获得条件值
-(void)getconditionvalue
{
    modelvalue=[NSString stringWithFormat:@"%@",[condition objectForKey:@"modelvalue"]];
    if (!modelvalue) {
        modelvalue=@"";
    }
    colorvalue=[NSString stringWithFormat:@"%@",[condition objectForKey:@"colorvalue"]];
    if (!colorvalue) {
        colorvalue=@"";
    }
    netvalue=[NSString stringWithFormat:@"%@",[condition objectForKey:@"netvalue"]];
    if (!netvalue) {
        netvalue=@"";
    }
    cutvalue=[NSString stringWithFormat:@"%@",[condition objectForKey:@"cutvalue"]];
    if (!cutvalue) {
        cutvalue=@"";
    }
    chasingvalue=[NSString stringWithFormat:@"%@",[condition objectForKey:@"chasingvalue"]];
    if (!chasingvalue) {
        chasingvalue=@"";
    }
    symmetryvalue=[NSString stringWithFormat:@"%@",[condition objectForKey:@"symmetryvalue"]];
    if (!symmetryvalue) {
        symmetryvalue=@"";
    }
    fluorescencevalue=[NSString stringWithFormat:@"%@",[condition objectForKey:@"fluorescencevalue"]];
    if (!fluorescencevalue) {
        fluorescencevalue=@"";
    }
    diplomavalue=[NSString stringWithFormat:@"%@",[condition objectForKey:@"diplomavalue"]];
    if (!diplomavalue) {
        diplomavalue=@"";
    }
    novalue=[NSString stringWithFormat:@"%@",[condition objectForKey:@"no"]];
    if ([novalue isEqualToString:@"(null)"]) {
        novalue=@"";
    }
    minheight=[NSString stringWithFormat:@"%@",[condition objectForKey:@"minheight"]];
    if ([minheight isEqualToString:@"(null)"]) {
        minheight=@"";
    }
    maxheight=[NSString stringWithFormat:@"%@",[condition objectForKey:@"maxheight"]];
    if ([maxheight isEqualToString:@"(null)"]) {
        maxheight=@"";
    }
    minprice=[NSString stringWithFormat:@"%@",[condition objectForKey:@"minprice"]];
    if ([minprice isEqualToString:@"(null)"]) {
        minprice=@"";
    }
    maxprice=[NSString stringWithFormat:@"%@",[condition objectForKey:@"maxprice"]];
    if ([maxprice isEqualToString:@"(null)"]) {
        maxprice=@"";
    }
}

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
    
    NSString * surl = [NSString stringWithFormat:@"/app/aifacen.php?uId=%@&type=1011&Upt=%@&Nowt=%@&Kstr=%@&Dia_CertNo=%@&price_a=%@&price_b=%@&kl_a=%@&kl_b=%@&iCut=%@&iClear=%@&iColor=%@&iPol=%@&iSys=%@&iFlur=%@&iLab=%@&iShape=%@&cid=%@&MaxPerPage=%d&page=%d",uId,Upt,nowt,Kstr,novalue,minprice,maxprice,minheight,maxheight,cutvalue,netvalue,colorvalue,chasingvalue,symmetryvalue,fluorescencevalue,diplomavalue,modelvalue,@"",pagesize,page];
    
    
    NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
    NSMutableDictionary * dict = [DataService GetDataService:URL];
    NSString *status=[NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]];
    if ([status isEqualToString:@"true"])
    {
        NSArray *productlist=[dict objectForKey:@"result"];
        [list addObjectsFromArray:productlist];
    }
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"NakedDiamondsrCell";
    
    NakedDiamondsrCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"NakedDiamondsrCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSArray *result=[list objectAtIndex:[indexPath row]];
    NSString *modelindex=[NSString stringWithFormat:@"%@",[result objectAtIndex:9]];
    NSArray *modelarray=[self showmodelandimg:modelindex];
    cell.modelLabel.text=[modelarray objectAtIndex:0];
    cell.logoimg.image=[UIImage imageNamed:[modelarray objectAtIndex:1]];
    
    NSString * oweight=[result objectAtIndex:3];
    double sds=[oweight doubleValue];
    if(!sds || sds<1){
        oweight=[NSString stringWithFormat:@"0%@",oweight];
    }
    cell.heightLabel.text=[NSString stringWithFormat:@"钻重：%@ 颜色：%@ 净度：%@",oweight,[result objectAtIndex:5],[result objectAtIndex:4]];
    cell.cutLabel.text=[NSString stringWithFormat:@"切工：%@",[result objectAtIndex:6]];
    cell.priceLabel.text=[NSString stringWithFormat:@"¥%@",[result objectAtIndex:14]];
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *result=[list objectAtIndex:[indexPath row]];
    NakedDiamonddetail *_NakedDiamonddetail=[[NakedDiamonddetail alloc]init];
    _NakedDiamonddetail.nid=[result objectAtIndex:0];
    _NakedDiamonddetail.mydelegate=_mydelegate;
    [self.navigationController pushViewController:_NakedDiamonddetail animated:NO];
}


-(NSArray *)showmodelandimg:(NSString *)modeltype
{
    NSString *name;
    NSString *imgname;
    if ([modeltype isEqualToString:@"RB"]) {
        name=@"圆形";
        imgname=@"diamond01";
    }
    else if ([modeltype isEqualToString:@"PE"]){
        name=@"公主方";
        imgname=@"diamond02";
    }
    else if ([modeltype isEqualToString:@"EM"]){
        name=@"祖母绿";
        imgname=@"diamond03";
    }
    else if ([modeltype isEqualToString:@"RD"]){
        name=@"雷蒂恩";
        imgname=@"diamond04";
    }
    else if ([modeltype isEqualToString:@"OL"]){
        name=@"椭圆形";
        imgname=@"diamond05";
    }
    else if ([modeltype isEqualToString:@"MQ"]){
        name=@"橄榄形";
        imgname=@"diamond06";
    }
    else if ([modeltype isEqualToString:@"CU"]){
        name=@"枕形";
        imgname=@"diamond07";
    }
    else if ([modeltype isEqualToString:@"PR"]){
        name=@"梨形";
        imgname=@"diamond08";
    }
    else if ([modeltype isEqualToString:@"HT"]){
        name=@"心形";
        imgname=@"diamond09";
    }
    else if ([modeltype isEqualToString:@"ASH"]){
        name=@"辐射形";
        imgname=@"diamond10";
    }
    NSArray *valuearray=[[NSArray alloc]initWithObjects:name,imgname, nil];
    return valuearray;
    
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
