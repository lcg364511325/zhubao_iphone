//
//  productdetail.m
//  zhubao_iphone
//
//  Created by johnson on 14-9-15.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "productdetail.h"
#import "AppDelegate.h"
#import "productApi.h"
#import "decorateView.h"

@interface productdetail ()

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

@implementation productdetail

@synthesize pdSView;
@synthesize pid;
@synthesize pdetailView;
@synthesize bgimg1;
@synthesize bgimg2;
@synthesize logoimg;
@synthesize clogoimg;
@synthesize nameLabel;
@synthesize priceLabel;
@synthesize noLabel;
@synthesize womanweightLabel;
@synthesize TView;

//女戒
@synthesize wmaincountLabel;
@synthesize wfitcountLabel;
@synthesize wfitweightLabel;
@synthesize wmianinlayText;
@synthesize wnetText;
@synthesize wcolorText;
@synthesize wtexttureText;
@synthesize wsizeText;
@synthesize wfontLabel;
@synthesize countLabel;

//男戒
@synthesize manweightLabel;
@synthesize mmaincountLabel;
@synthesize mfitcountLabel;
@synthesize mfitweightLabel;
@synthesize mmianinlayText;
@synthesize mnetText;
@synthesize mcolorText;
@synthesize mtexttureText;
@synthesize msizeText;
@synthesize mfontLabel;
@synthesize btn1;
@synthesize btn2;
@synthesize btn3;
@synthesize btn4;

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
    
    //设置scrollview属性
    pdSView.backgroundColor=[UIColor  colorWithPatternImage:[UIImage imageNamed:@"backgroundcolor"]];
    [pdSView addSubview:pdetailView];
    pdSView.contentSize=CGSizeMake(320, pdetailView.frame.size.height);
    pdSView.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    pdSView.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    pdSView.scrollEnabled=YES;
    
    //设置背景图片圆角和边框
    bgimg1.layer.cornerRadius=4;
    bgimg1.layer.masksToBounds=YES;
    CALayer *layer = [bgimg1 layer];
    layer.borderColor=[UIColor colorWithRed:133.0/255.0 green:130.0/255.0 blue:154.0/255.0 alpha:0.5].CGColor;
    layer.borderWidth=0.7f;
    bgimg2.layer.cornerRadius=4;
    bgimg2.layer.masksToBounds=YES;
    CALayer *layer1 = [bgimg2 layer];
    layer1.borderColor=[UIColor colorWithRed:133.0/255.0 green:130.0/255.0 blue:154.0/255.0 alpha:0.5].CGColor;
    layer1.borderWidth=0.7f;
    
    //初始化数组
    netlist=[[NSArray alloc]initWithObjects:@"SI",@"VVS",@"VS",@"P", nil];
    colorlist=[[NSArray alloc]initWithObjects:@"I-J",@"F-G",@"H",@"K-L",@"M-N", nil];
    textturelist=[[NSArray alloc] initWithObjects:@"18k黄",@"18K白",@"18K双色",@"18K玫瑰金",@"PT900",@"PT950",@"PD950", nil];
    
    //限制数字键盘
    msizeText.keyboardType=UIKeyboardTypeNumberPad;
    wsizeText.keyboardType=UIKeyboardTypeNumberPad;
    countLabel.keyboardType=UIKeyboardTypeNumberPad;
    
    //要开线程来加载数据
    [self loaddata];
}

-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作（异步操作）
        
        getNowTime * time=[[getNowTime alloc] init];
        NSString * nowt=[time nowTime];
        
        NSString * uId=myDelegate.entityl.uId;
        NSString * Upt=@"0";//获取上一次的更新时间
        if (myDelegate.entityl.puptime) {
            Upt=myDelegate.entityl.puptime;
        }
        //Kstr=md5(uId|type|Upt|Key|Nowt|cid)
        NSString * Kstr=[Commons md5:[NSString stringWithFormat:@"%@|%@|%@|%@|%@",uId,@"1001",Upt,apikey,nowt]];
        
        NSString * surl = [NSString stringWithFormat:@"/app/aifacen.php?uId=%@&type=1001&Upt=%@&Nowt=%@&Kstr=%@&cid=%@",uId,Upt,nowt,Kstr,pid];
        NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
        NSMutableDictionary * dict = [DataService GetDataService:URL];
        NSString *status=[NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]];

        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([status isEqualToString:@"true"])
            {
                productlist= [[NSMutableArray alloc] init];
                [productlist setArray:[[dict objectForKey:@"result"] objectAtIndex:0]];
                
                //小数且值小于1的，请在小数点前面补0
                NSString * oweight=[productlist objectAtIndex:34];
                double sds=[oweight doubleValue];
                if(!sds || sds<1){
                    [productlist replaceObjectAtIndex:34 withObject:[NSString stringWithFormat:@"0%@",oweight]];
                }
                oweight=[productlist objectAtIndex:44];
                sds=[oweight doubleValue];
                if(!sds || sds<1){
                    [productlist replaceObjectAtIndex:44 withObject:[NSString stringWithFormat:@"0%@",oweight]];
                }
                
                
                proclass=[NSString stringWithFormat:@"%@",[productlist objectAtIndex:5]];
                protypeWenProId=[NSString stringWithFormat:@"%@",[productlist objectAtIndex:9]];
                
                //logo图片
                NSString *url=[NSString stringWithFormat:@"http://seyuu.com%@",[productlist objectAtIndex:8]];
                NSURL *imgUrl=[NSURL URLWithString:url];
                if (hasCachedImage(imgUrl)) {
                    [logoimg setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
                }else{
                    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",logoimg,@"imageView",nil];
                    [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
                }
                
                //名称
                nameLabel.text=[NSString stringWithFormat:@"%@",[productlist objectAtIndex:3]];
                
                //型号
                noLabel.text=[NSString stringWithFormat:@"型号：%@",[productlist objectAtIndex:1]];
                
                if ([proclass isEqualToString:@"3"] && [protypeWenProId isEqualToString:@"0"]) {
                    
                    //女戒
                    
                    //主石数量
                    wmaincountLabel.text=[NSString stringWithFormat:@"女戒：%@颗",[productlist objectAtIndex:31]];
                    
                    //副石数量
                    wfitcountLabel.text=[NSString stringWithFormat:@"女戒：%@颗",[productlist objectAtIndex:41]];
                    
                    //副石重量
                    wfitweightLabel.text=[NSString stringWithFormat:@"女戒：%@ct",[productlist objectAtIndex:44]];
                    
                    //主石
                    winlaylist=[self checkinlay:pid];
                    float wminlay=[[[winlaylist objectAtIndex:0] objectAtIndex:2] floatValue];
                    wmianinlayText.text=[NSString stringWithFormat:@"%.2f",wminlay];
                    
                    //约重
                    wmweight=[[[winlaylist objectAtIndex:0] objectAtIndex:3] floatValue];
                    womanweightLabel.text=[NSString stringWithFormat:@"女戒：%.3fg",wmweight];
                    
                    //净度
                    wnetText.text=@"SI";
                    //颜色
                    wcolorText.text=@"I-J";
                    //材质
                    wtexttureText.text=@"18K黄";
                    
                    //男戒
                    [self sethiddenforno];
                    NSString *surl = [NSString stringWithFormat:@"/app/aifacen.php?uId=%@&type=1001&Upt=%@&Nowt=%@&Kstr=%@&twid=%@",uId,Upt,nowt,Kstr,pid];
                    NSString *URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
                    NSMutableDictionary * dict = [DataService GetDataService:URL];
                    NSString *status=[NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]];
                    if ([status isEqualToString:@"true"])
                    {
                        manpdetail= [[NSMutableArray alloc] init];
                        [manpdetail setArray:[[dict objectForKey:@"result"] objectAtIndex:0]];
                        
                        NSString * oweight=[manpdetail objectAtIndex:34];
                        double sds=[oweight doubleValue];
                        if(!sds || sds<1){
                            [manpdetail replaceObjectAtIndex:34 withObject:[NSString stringWithFormat:@"0%@",oweight]];
                        }
                        oweight=[manpdetail objectAtIndex:44];
                        sds=[oweight doubleValue];
                        if(!sds || sds<1){
                            [manpdetail replaceObjectAtIndex:44 withObject:[NSString stringWithFormat:@"0%@",oweight]];
                        }
                        
                        //主石数量
                        mmaincountLabel.text=[NSString stringWithFormat:@"男戒：%@颗",[manpdetail objectAtIndex:31]];
                        
                        //副石数量
                        mfitcountLabel.text=[NSString stringWithFormat:@"男戒：%@颗",[manpdetail objectAtIndex:41]];
                        
                        //副石重量
                        mfitweightLabel.text=[NSString stringWithFormat:@"男戒：%@ct",[manpdetail objectAtIndex:44]];
                        
                        //主石
                        minlaylist=[self checkinlay:[NSString stringWithFormat:@"%@",[manpdetail objectAtIndex:0]]];
                        float mminlay=[[[minlaylist objectAtIndex:0] objectAtIndex:2] floatValue];
                        mmianinlayText.text=[NSString stringWithFormat:@"%.2f",mminlay];
                        
                        //约重
                        mmweight=[[[minlaylist objectAtIndex:0] objectAtIndex:3] floatValue];
                        manweightLabel.text=[NSString stringWithFormat:@"男戒：%.3fg",mmweight];
                        
                        //净度
                        mnetText.text=@"SI";
                        //颜色
                        mcolorText.text=@"I-J";
                        //材质
                        mtexttureText.text=@"18K黄";
                        
                        
                        [self getPrice:[NSString stringWithFormat:@"%.3f",wmweight] minlay:[NSString stringWithFormat:@"%.3f",mmweight]];
                    }
                }else{
                    
                    //主石数量
                    wmaincountLabel.text=[NSString stringWithFormat:@"%@颗",[productlist objectAtIndex:31]];
                    
                    //副石数量
                    wfitcountLabel.text=[NSString stringWithFormat:@"%@颗",[productlist objectAtIndex:41]];
                    
                    //副石重量
                    wfitweightLabel.text=[NSString stringWithFormat:@"%@ct",[productlist objectAtIndex:44]];
                    
                    //主石
                    winlaylist=[self checkinlay:pid];
                    float wminlay=[[[winlaylist objectAtIndex:0] objectAtIndex:2] floatValue];
                    wmianinlayText.text=[NSString stringWithFormat:@"%.2f",wminlay];
                    
                    //约重
                    wmweight=[[[winlaylist objectAtIndex:0] objectAtIndex:3] floatValue];
                    womanweightLabel.text=[NSString stringWithFormat:@"%.3fg",wmweight];
                    mmweight=0.000;
                    
                    //净度
                    wnetText.text=@"SI";
                    //颜色
                    wcolorText.text=@"I-J";
                    //材质
                    wtexttureText.text=@"18K黄";
                    
                    [self getPrice:[NSString stringWithFormat:@"%.3f",wmweight] minlay:[NSString stringWithFormat:@"%.3f",mmweight]];
                }
            }

        });
    });
    
    countLabel.text=@"1";
    wsizeText.text=@"0";
    msizeText.text=@"0";

}

-(void)getPrice:(NSString *)wweight minlay:(NSString *)mweight
{
    @try {
        //可以在此加代码提示用户说正在加载数据中
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作（异步操作）
            
            NSString *proprice=nil;
            productApi *priceApi=[[productApi alloc]init];
            womanprice=[priceApi getPrice:proclass goldType:wtexttureText.text goldWeight:wweight mDiaWeight:wmianinlayText.text mDiaColor:wcolorText.text mVVS:wnetText.text sDiaWeight:[NSString stringWithFormat:@"%@",[productlist objectAtIndex:44]] sCount:[NSString stringWithFormat:@"%@",[productlist objectAtIndex:41]] proid:pid];
            
            float womp=[womanprice floatValue];
            if ([proclass isEqualToString:@"3"] && [protypeWenProId isEqualToString:@"0"] && womp>0) {
                priceApi=[[productApi alloc]init];
                manprice=[priceApi getPrice:[NSString stringWithFormat:@"%@",[manpdetail objectAtIndex:5]] goldType:mtexttureText.text goldWeight:mweight mDiaWeight:mmianinlayText.text mDiaColor:mcolorText.text mVVS:mnetText.text sDiaWeight:[NSString stringWithFormat:@"%@",[manpdetail objectAtIndex:44]] sCount:[NSString stringWithFormat:@"%@",[manpdetail objectAtIndex:41]] proid:[NSString stringWithFormat:@"%@",[manpdetail objectAtIndex:0]]];
                
                　float manp=[manprice floatValue];
                if (manp>0) {
                    proprice=[NSString stringWithFormat:@"%f",manp+womp];
                }else{
                    proprice=nil;
                }
            }else if(womp>0){
                proprice=womanprice;
            }else{
                proprice=nil;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (proprice) {
                    //pricelable.text=[@"¥" stringByAppendingString:proprice];
                    NSArray *price=[[NSString stringWithFormat:@"%@",proprice] componentsSeparatedByString:@"."];
                    priceLabel.text=[NSString stringWithFormat:@"售价：%@",[price objectAtIndex:0]];
                }else{
                    priceLabel.text=@"暂无价格信息";
                }
                
            });
        });
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

//显示tableview
-(IBAction)showtableview:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    btntag=btn.tag;
    if (btntag==0) {
        TView.frame=CGRectMake(53, 447, 122, 180);
        list=winlaylist;
    }else if (btntag==1)
    {
        TView.frame=CGRectMake(53, 487, 122, 180);
        list=netlist;
    }else if (btntag==2)
    {
        TView.frame=CGRectMake(53, 527, 122, 180);
        list=colorlist;
    }
    else if (btntag==3)
    {
        TView.frame=CGRectMake(53, 567, 122, 180);
        list=textturelist;
    }else if (btntag==4)
    {
        TView.frame=CGRectMake(183, 447, 122, 180);
        list=minlaylist;
    }else if (btntag==5)
    {
        TView.frame=CGRectMake(183, 487, 122, 180);
        list=netlist;
    }else if (btntag==6)
    {
        TView.frame=CGRectMake(183, 527, 122, 180);
        list=colorlist;
    }else if (btntag==7)
    {
        TView.frame=CGRectMake(183, 567, 122, 180);
        list=textturelist;
    }
    TView.hidden=NO;
    [TView reloadData];
}


//显示男戒
-(void)sethiddenforno
{
    manweightLabel.hidden=NO;
    mmaincountLabel.hidden=NO;
    mfitcountLabel.hidden=NO;
    mfitweightLabel.hidden=NO;
    mmianinlayText.hidden=NO;
    mnetText.hidden=NO;
    mcolorText.hidden=NO;
    mtexttureText.hidden=NO;
    msizeText.hidden=NO;
    mfontLabel.hidden=NO;
    btn1.hidden=NO;
    btn2.hidden=NO;
    btn3.hidden=NO;
    btn4.hidden=NO;
}


//镶口查询
-(NSArray *)checkinlay:(NSString *)cid
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
    NSString * Kstr=[Commons md5:[NSString stringWithFormat:@"%@|%@|%@|%@|%@",uId,@"1021",Upt,apikey,nowt]];
    
    NSString * surl = [NSString stringWithFormat:@"/app/aifacen.php?uId=%@&type=1021&Upt=%@&Nowt=%@&Kstr=%@&cid=%@",uId,Upt,nowt,Kstr,cid];
    NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
    NSMutableDictionary * dict = [DataService GetDataService:URL];
    NSArray *parray=[dict objectForKey:@"result"];
    
    return parray;
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
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
    if (btntag==0 || btntag==4) {
        cell.textLabel.text = [NSString stringWithFormat:@"%.2f",[[[list objectAtIndex:row] objectAtIndex:2] floatValue]];
    }else{
        cell.textLabel.text = [list objectAtIndex:row];
    }
    
    cell.textLabel.font=[UIFont boldSystemFontOfSize:12.0f];
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSString *rowstring;
    if (btntag==0 || btntag==4) {
        rowstring = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%.2f",[[[list objectAtIndex:row] objectAtIndex:2] floatValue]]];
    }else{
        rowstring = [NSString stringWithFormat:@"%@",[list objectAtIndex:row]];
    }
    
    if (btntag==0) {
        wmianinlayText.text=rowstring;
        wmweight=[[[list objectAtIndex:row] objectAtIndex:3] floatValue];
        if ([proclass isEqualToString:@"3"] && [protypeWenProId isEqualToString:@"0"]) {
            womanweightLabel.text=[NSString stringWithFormat:@"女戒：%.3fg",wmweight];
        }else{
            womanweightLabel.text=[NSString stringWithFormat:@"%.3fg",wmweight];
        }
    }else if (btntag==1)
    {
        wnetText.text=rowstring;
    }else if (btntag==2)
    {
        wcolorText.text=rowstring;
    }
    else if (btntag==3)
    {
        wtexttureText.text=rowstring;
    }else if (btntag==4)
    {
        mmianinlayText.text=rowstring;
        mmweight=[[[list objectAtIndex:row] objectAtIndex:3] floatValue];
        manweightLabel.text=[NSString stringWithFormat:@"男戒：%.3fg",mmweight];
    }else if (btntag==5)
    {
        mnetText.text=rowstring;
    }else if (btntag==6)
    {
        mcolorText.text=rowstring;
    }else if (btntag==7)
    {
        mtexttureText.text=rowstring;
    }
    TView.hidden=YES;
    
    [self getPrice:[NSString stringWithFormat:@"%.3f",wmweight] minlay:[NSString stringWithFormat:@"%.3f",mmweight]];
}

//点击tableview以外的地方触发事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    if (!CGRectContainsPoint([TView frame], pt)) {
        //to-do
        TView.hidden=YES;
    }
    
    [wsizeText resignFirstResponder];
    [msizeText resignFirstResponder];
    [wfontLabel resignFirstResponder];
    [mfontLabel resignFirstResponder];
    [countLabel resignFirstResponder];
    oldframe=self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

//商品添加到购物车
-(IBAction)addshopcart:(id)sender{
    sqlService * sql=[[sqlService alloc] init];
    //productEntity *goods=[sql GetProductDetail:productnumber];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    buyproduct * entity=[[buyproduct alloc]init];
    entity.producttype=@"1";
    entity.productid=pid;
    entity.pcount=countLabel.text;
    entity.pcolor=wcolorText.text;
    entity.pdetail=wfontLabel.text;
    entity.pvvs=wnetText.text;
    entity.psize=wsizeText.text;
    entity.pgoldtype=wtexttureText.text;
    entity.pweight=[NSString stringWithFormat:@"%.3f",wmweight];
    entity.customerid=myDelegate.entityl.uId;
    entity.pprice=womanprice;
    entity.pname=[productlist objectAtIndex:1];
    entity.Dia_Z_weight=[NSString stringWithFormat:@"%@",[productlist objectAtIndex:7]];
    entity.photos=[NSString stringWithFormat:@"%@(%@)",[productlist objectAtIndex:1],[productlist objectAtIndex:2]];
    
    entity.photom=[NSString stringWithFormat:@"金重：%.3f  材质：%@  钻重：%@",wmweight,wtexttureText.text,[productlist objectAtIndex:34]];
    entity.photob=[NSString stringWithFormat:@"净度：%@  颜色：%@  手寸：%@",wnetText.text,wcolorText.text,wsizeText.text];
    buyproduct *successadd=[sql addToBuyproduct:entity];
    buyproduct *successaddman=[[buyproduct alloc]init];
    if ([proclass isEqualToString:@"3"] && [protypeWenProId isEqualToString:@"0"]) {
        buyproduct * manentity=[[buyproduct alloc]init];
        manentity.producttype=@"1";
        manentity.productid=[NSString stringWithFormat:@"%@",[manpdetail objectAtIndex:0]];
        manentity.pcount=countLabel.text;
        manentity.pcolor=mcolorText.text;
        manentity.pdetail=mfontLabel.text;
        manentity.pvvs=mnetText.text;
        manentity.psize=msizeText.text;
        manentity.pgoldtype=mtexttureText.text;
        manentity.pweight=[NSString stringWithFormat:@"%.3f",mmweight];
        manentity.customerid=myDelegate.entityl.uId;
        manentity.pprice=manprice;
        manentity.pname=[NSString stringWithFormat:@"%@",[manpdetail objectAtIndex:1]];
        manentity.Dia_Z_weight=[NSString stringWithFormat:@"%@",[manpdetail objectAtIndex:7]];
        manentity.photos=[NSString stringWithFormat:@"%@(%@)",[manpdetail objectAtIndex:1],[manpdetail objectAtIndex:2]];
        
        manentity.photom=[NSString stringWithFormat:@"金重：%.3f  材质：%@  钻重：%@",mmweight,mtexttureText.text,[manpdetail objectAtIndex:34]];
        manentity.photob=[NSString stringWithFormat:@"净度：%@  颜色：%@  手寸：%@",mnetText.text,mcolorText.text,msizeText.text];
        sql=[[sqlService alloc]init];
        successaddman=[sql addToBuyproduct:manentity];
    }
    
    if (successadd && successaddman) {
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

//展示图片集
-(IBAction)showPhotoBrowser:(id)sender
{
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    //NSMutableArray *thumbs = [[NSMutableArray alloc] init];
    //MWPhoto *photot;
    
//    NSArray  * array= imglist;
//    int count = [array count];
//    //遍历这个数组
//    for (int i = 0; i < count; i++) {
//        //NSLog(@"普通的遍历：i = %d 时的数组对象为: %@",i,[array objectAtIndex: i]);
//        NSString * patht=[NSString stringWithFormat:@"%@",[[array objectAtIndex:i] objectForKey:@"goodsImg"]];
//        NSURL *imgUrl=[NSURL URLWithString:patht];
//        if (hasCachedImage(imgUrl)) {
//            [photos addObject:[MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]]];
//        }else
//        {
//            [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:patht]]];
//        }
//        
//        //[thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:patht]]];
//    }
    NSString *patht=[NSString stringWithFormat:@"http://seyuu.com%@",[productlist objectAtIndex:7]];
    NSArray *patharray=[patht componentsSeparatedByString:@"_"];
    for (int i=0; i<6; i++) {
        NSString *pathway=[NSString stringWithFormat:@"%@_0%d6.jpg",[patharray objectAtIndex:0],i];
        NSURL *imgUrl=[NSURL URLWithString:pathway];
        if (hasCachedImage(imgUrl)) {
            [photos addObject:[MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]]];
        }else
        {
            [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:pathway]]];
        }
    }
    self.photos = photos;
    //self.thumbs = thumbs;
    
    //    _selections = [NSMutableArray new];
    //    for (int i = 0; i < photos.count; i++) {
    //        [_selections addObject:[NSNumber numberWithBool:NO]];
    //    }
    
    // Create browser
	MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = NO;
    browser.displayNavArrows = YES;
    browser.displaySelectionButtons = NO;
    browser.alwaysShowControls = NO;
    browser.zoomPhotosToFill = YES;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    browser.wantsFullScreenLayout = YES;
#endif
    browser.enableGrid = NO;
    browser.startOnGrid = NO;
    browser.enableSwipeToDismiss = YES;
    [browser setCurrentPhotoIndex:0];
    [browser setWantsFullScreenLayout:NO];
    
    // Push
    //[self presentViewController:browser animated:YES completion:nil];
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController pushViewController:browser animated:NO];
    //[self presentPopupViewController:browser animated:YES completion:^(void) {
    //    NSLog(@"popup view presented");
    //}];
    
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

//- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
//    if (index < _thumbs.count)
//        return [_thumbs objectAtIndex:index];
//    return nil;
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    //NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    //NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    frame = textField.frame;
    if (oldframe.origin.y!=frame.origin.y) {
        int offset = frame.origin.y + 32 - (pdetailView.frame.size.height - 216.0);//键盘高度216
        
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
        if(offset > 0)
            self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
        oldframe=frame;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (oldframe.origin.y!=frame.origin.y) {
        self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
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
