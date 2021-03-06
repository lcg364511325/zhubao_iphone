//
//  productindex.m
//  zhubao_iphone
//
//  Created by johnson on 14-9-11.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "productindex.h"
#import "AppDelegate.h"
#import "MJRefresh.h"
#import "productCell.h"
#import "productdetail.h"
#import "doubleRingDetail.h"

@interface productindex ()

@end

//解决scrollview无法响应view的touch事件
@implementation UIScrollView (UITouchEvent)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesMoved:touches withEvent:event];
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}

@end

@implementation productindex

@synthesize productCView;
@synthesize conditionTView;
@synthesize styleText;
@synthesize serieaText;
@synthesize textrueText;
@synthesize inlayText;
@synthesize searchbox;
@synthesize gidText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    if (isfirst==0) {
//        isfirst=1;
//    }else{
//        pagesize=10;
//        page=1;
//        styleindex=@"";
//        textrueindex=@"";
//        inlayindex=@"";
//        serieindex=@"";
//        [list removeAllObjects];
//        [self loaddata:styleindex Pmetrial:textrueindex Pxk:inlayindex Pxilie:serieindex twid:@"" MaxPerPage:pagesize];
//        [productCView reloadData];
//        styleText.text=@"全部";
//        serieaText.text=@"全部";
//        textrueText.text=@"全部";
//        inlayText.text=@"全部";
//        
//        NSInteger count=[list count];
//        if(count==0)
//        {
//            countlabel.text=@"共有首饰0件";
//        }else
//        {
//            countlabel.text=[NSString stringWithFormat:@"共有首饰%@件",[[list objectAtIndex:0] objectAtIndex:8]];
//        }
//    }
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    hidden=0;
    
    //注册collectionview的cell
    [productCView registerClass:[productCell class] forCellWithReuseIdentifier:@"productCell"];
    
    stylearray = [[NSArray alloc] initWithObjects:@"全部",@"女戒",@"男戒",@"对戒",@"吊坠",@"项链",@"手链",@"手镯",@"耳环",@"耳钉", nil];
    texturearray = [[NSArray alloc] initWithObjects:@"全部",@"18k黄",@"18K白",@"18K双色",@"18K玫瑰金",@"PT900",@"PT950",@"PD950", nil];
    inlayarray = [[NSArray alloc] initWithObjects:@"全部",@"0.00-0.02",@"0.03-0.07",@"0.08-0.12",@"0.13-0.17",@"0.18-0.22",@"0.23-0.28",@"0.29-0.39",@"0.40",@"0.50",@"0.60",@"0.70",@"0.80",@"0.90",@"1克拉以上", nil];
    seriearray = [[NSArray alloc] initWithObjects:@"全部",@"豪华系列",@"彩钻系列", nil];
    list=[[NSMutableArray alloc]initWithCapacity:1];
    pagesize=10;
    page=1;
    styleindex=@"";
    textrueindex=@"";
    inlayindex=@"";
    serieindex=@"";
    
    isfirst=0;
    
    UILabel *searchfont = [ [UILabel alloc]initWithFrame:CGRectZero];
    searchfont.textColor=[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1];
    searchfont.text = @"   产品款号:";
    searchfont.font=[UIFont systemFontOfSize:10.0f];
    [searchfont sizeToFit];
    searchfont.backgroundColor=[UIColor colorWithRed:234.0f/255.0f green:234.0f/255.0f blue:234.0f/255.0f alpha:1];
    searchbox.leftView=searchfont;
    searchbox.leftViewMode = UITextFieldViewModeAlways;
    
    //初始化数据
    gid=@"0";
    [self loaddata:@"" Pmetrial:@"" Pxk:@"" Pxilie:@"" twid:@"" MaxPerPage:10 cid:gid
];
    
    //上拉刷新下拉加载提示
    [productCView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata:styleindex Pmetrial:textrueindex Pxk:inlayindex Pxilie:serieindex twid:@"" MaxPerPage:pagesize cid:gid];
        [productCView reloadData];
        [productCView headerEndRefreshing];
    }];
    
    [productCView addFooterWithCallback:^{
        page=page+1;
        [self loaddata:styleindex Pmetrial:textrueindex Pxk:inlayindex Pxilie:serieindex twid:@"" MaxPerPage:pagesize cid:gid];
        [productCView reloadData];
        [productCView footerEndRefreshing];
    }];

    if ([conditionTView respondsToSelector:@selector(setSeparatorInset:)]) {
        [conditionTView setSeparatorInset:UIEdgeInsetsZero];
    }
}


//加载数据
-(void)loaddata:(NSString *)Ptype Pmetrial:(NSString *)Pmetrial Pxk:(NSString *)Pxk Pxilie:(NSString *)Pxilie twid:(NSString *)twid MaxPerPage:(NSInteger )MaxPerPage cid:(NSString *)cid
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
    NSString * Kstr=[Commons md5:[NSString stringWithFormat:@"%@|%@|%@|%@|%@",uId,@"1001",Upt,apikey,nowt]];
    
    NSString * surl = [NSString stringWithFormat:@"/app/aifacen.php?uId=%@&type=1001&Upt=%@&Nowt=%@&Kstr=%@&cid=%@&MaxPerPage=%d&Ptype=%@&Pmetrial=%@&Pxk=%@&Pxilie=%@&twid=%@&page=%d",uId,Upt,nowt,Kstr,cid,MaxPerPage,Ptype,Pmetrial,Pxk,Pxilie,twid,page];
    
    
    NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
    NSMutableDictionary * dict = [DataService GetDataService:URL];
    NSString *status=[NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]];
    if ([status isEqualToString:@"true"]) {
        NSArray *productlist=[dict objectForKey:@"result"];
        [list addObjectsFromArray:productlist];
    }
    
}

//显示条件下拉框
-(IBAction)showcondition:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    btntag=btn.tag;
    if (btntag==0) {
        conditionlist=stylearray;
        conditionTView.frame=CGRectMake(2, 75, 80, 310);
    }else if (btntag==1)
    {
        conditionlist=seriearray;
        conditionTView.frame=CGRectMake(152, 75, 80, 100);
    }else if (btntag==2)
    {
        conditionlist=texturearray;
        conditionTView.frame=CGRectMake(72, 75, 80, 250);
    }else if (btntag==3)
    {
        conditionlist=inlayarray;
        conditionTView.frame=CGRectMake(235, 75, 80, 320);
    }
    conditionTView.hidden=NO;
    [conditionTView reloadData];
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [conditionlist count];
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [conditionlist objectAtIndex:row];
    cell.textLabel.font=[UIFont systemFontOfSize:10.0f];
    cell.textLabel.textColor=[UIColor colorWithRed:152.0f/255.0f green:152.0f/255.0f blue:152.0f/255.0f alpha:1];
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSString *rowstring = [conditionlist objectAtIndex:row];
    if (btntag==0) {
        if ([rowstring isEqualToString:@"全部"]) {
            rowstring=@"款式";
        }
        styleText.text=rowstring;
        if (row==0) {
            styleindex=@"";
        }else
        {
           styleindex=[NSString stringWithFormat:@"%d",row];
        }
    }else if (btntag==1)
    {
        if ([rowstring isEqualToString:@"全部"]) {
            rowstring=@"系列";
        }
        serieaText.text=rowstring;
        if (row==0) {
            serieindex=@"";
        }else
        {
           serieindex=[NSString stringWithFormat:@"%d",row+1]; 
        }
    }else if (btntag==2)
    {
        if ([rowstring isEqualToString:@"全部"]) {
            rowstring=@"材质";
        }
        textrueText.text=rowstring;
        if (row==0) {
            textrueindex=@"";
        }else
        {
            textrueindex=[NSString stringWithFormat:@"%d",row];
        }
    }else if (btntag==3)
    {
        if ([rowstring isEqualToString:@"全部"]) {
            rowstring=@"镶口";
        }
        inlayText.text=rowstring;
        if (row==0) {
            inlayindex=@"";
        }else if (row==1){
            inlayindex=@"0.00-0.02";
            
        }else if (row==2){
            inlayindex=@"0.03-0.07";
            
        }else if (row==3){
            inlayindex=@"0.08-0.12";
            
        }else if (row==4){
            inlayindex=@"0.13-0.17";
            
        }else if (row==5){
            inlayindex=@"0.18-0.22";
            
        }else if (row==6){
            inlayindex=@"0.23-0.28";
            
        }else if (row==7){
            inlayindex=@"0.29-0.39";
            
        }else if (row==8){
            inlayindex=@"0.40-0.49";
            
        }else if (row==9){
            inlayindex=@"0.50-0.59";
            
        }else if (row==10){
            inlayindex=@"0.60-0.69";
            
        }else if (row==11){
            inlayindex=@"0.70-0.69";
            
        }else if (row==12){
            inlayindex=@"0.80-0.69";
            
        }else if (row==13){
            inlayindex=@"0.90-0.69";
            
        }else if (row==14){
            inlayindex=@"1-100000";
            
        }
    }
    conditionTView.hidden=YES;
    [list removeAllObjects];
    page=1;
    [self loaddata:styleindex Pmetrial:textrueindex Pxk:inlayindex Pxilie:serieindex twid:@"" MaxPerPage:pagesize cid:gid];
    [productCView reloadData];
    
}

//点击tableview以外的地方触发事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    if (!CGRectContainsPoint([conditionTView frame], pt)) {
        //to-do
        conditionTView.hidden=YES;
    }
    
    [searchbox resignFirstResponder];
}

//搜索结果数目
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [list count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    productCell *cell = (productCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"productCell" forIndexPath:indexPath];
    
    NSArray *productdetail = [list objectAtIndex:[indexPath row]];
    
    cell.nameLabel.text=[NSString stringWithFormat:@"%@",[productdetail objectAtIndex:1]];
    
    NSInteger picurlindex=0;
    if (![gid isEqualToString:@"0"]) {
        picurlindex=7;
    }else{
        picurlindex=4;
    }
    NSString *url=[NSString stringWithFormat:@"http://seyuu.com%@",[productdetail objectAtIndex:picurlindex]];
    NSURL *imgUrl=[NSURL URLWithString:url];
    if (hasCachedImage(imgUrl)) {
        [cell.productimg setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
    }else{
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",cell.productimg,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
    }
    
    return cell;
}

//点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *productdetailinfo = [list objectAtIndex:[indexPath row]];
    NSString *isdouble=@"";
    if (![gid isEqualToString:@"0"]) {
        isdouble=[productdetailinfo objectAtIndex:5];
    }else{
        isdouble=[productdetailinfo objectAtIndex:3];
    }
    
    if ([isdouble isEqualToString:@"3"]) {
        
        doubleRingDetail *_doubleRingDetail=[[doubleRingDetail alloc]init];
        _doubleRingDetail.pid=[NSString stringWithFormat:@"%@",[productdetailinfo objectAtIndex:0]];
        _doubleRingDetail.mydelegate=_mydelegate;
        [self.navigationController pushViewController:_doubleRingDetail animated:NO];
    }else{
        
        productdetail *_productdetail=[[productdetail alloc]init];
        _productdetail.pid=[NSString stringWithFormat:@"%@",[productdetailinfo objectAtIndex:0]];
        _productdetail.mydelegate=_mydelegate;
        [self.navigationController pushViewController:_productdetail animated:NO];
    }
}


//产品编号搜索
-(IBAction)cidsearch:(id)sender
{
    gid=gidText.text;
    [list removeAllObjects];
    [self loaddata:styleindex Pmetrial:textrueindex Pxk:inlayindex Pxilie:serieindex twid:@"" MaxPerPage:pagesize cid:gid];
    [productCView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
