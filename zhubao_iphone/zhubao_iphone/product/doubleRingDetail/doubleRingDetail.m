//
//  doubleRingDetail.m
//  zhubao_iphone
//
//  Created by johnson on 15-1-8.
//  Copyright (c) 2015年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "doubleRingDetail.h"
#import "productdetail.h"
#import "AppDelegate.h"
#import "productApi.h"
#import "decorateView.h"

@interface doubleRingDetail ()

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

@implementation doubleRingDetail

@synthesize pdSView;
@synthesize pid;
@synthesize pdetailView;
@synthesize bgimg1;
@synthesize logoimg;
@synthesize mlogoimg;
@synthesize clogoimg;
@synthesize nameLabel;
@synthesize priceLabel;
@synthesize womanweightLabel;
@synthesize manweightLabel;
@synthesize TView;
@synthesize remarkText;

//女戒
@synthesize wmaincountLabel;
@synthesize wfitweightLabel;
@synthesize wmianinlayText;
@synthesize wnetText;
@synthesize wcolorText;
@synthesize wtexttureText;
@synthesize wsizeText;
@synthesize wfontLabel;

//男戒
@synthesize mmaincountLabel;
@synthesize mfitweightLabel;
@synthesize mmianinlayText;
@synthesize mnetText;
@synthesize mcolorText;
@synthesize mtexttureText;
@synthesize msizeText;
@synthesize mfontLabel;

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
    pdSView.contentSize=CGSizeMake(320, pdetailView.frame.size.height+50);
    pdSView.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    pdSView.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    pdSView.scrollEnabled=YES;
    
    //设置背景图片圆角和边框
    bgimg1.layer.masksToBounds=YES;
    CALayer *layer = [bgimg1 layer];
    layer.borderColor=[UIColor colorWithRed:133.0/255.0 green:130.0/255.0 blue:154.0/255.0 alpha:0.5].CGColor;
    layer.borderWidth=0.7f;
    
    //初始化数组
    mnetlist=netlist=[[NSArray alloc]initWithObjects:@"SI",@"VVS",@"VS",@"P", nil];
    mcolorlist=colorlist=[[NSArray alloc]initWithObjects:@"I-J",@"F-G",@"H",@"K-L",@"M-N", nil];
    mtextturelist=textturelist=[[NSArray alloc] initWithObjects:@"18K黄",@"18K白",@"18K双色",@"18K玫瑰金",@"PT900",@"PT950",@"PD950", nil];
    sizelist=[[NSArray alloc] initWithObjects:@"9号",@"10号",@"11号",@"12号",@"13号",@"14号",@"15号",@"16号",@"17号",@"18号",@"19号",@"20号",@"21号",@"22号",@"23号",@"24号",@"25号",@"26号",@"27号",@"28号",@"29号",@"30号", nil];
    
    //限制数字键盘
    wsizeText.keyboardType=UIKeyboardTypeDecimalPad;
    
    if ([TView respondsToSelector:@selector(setSeparatorInset:)]) {
        [TView setSeparatorInset:UIEdgeInsetsZero];
    }
    
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
                nameLabel.text=[NSString stringWithFormat:@"%@  %@",[productlist objectAtIndex:3],[productlist objectAtIndex:1]];
                
                
                //主石数量
                wmaincountLabel.text=[NSString stringWithFormat:@" X %@颗",[productlist objectAtIndex:31]];
                
                //主石
                winlaylist=[self checkinlay:pid];
                if ([winlaylist count]<1) {
                    
                    //主石
                    NSString *wmt=[productlist objectAtIndex:34];
                    if(wmt==nil || [wmt isEqualToString:@""])
                    {
                        wmianinlayText.text=@"0.0";
                    }else{
                        wmianinlayText.text=[NSString stringWithFormat:@"%@",wmt];
                    }
                    
                    //副石重量
                    NSString *wfl=[productlist objectAtIndex:44];
                    if(wfl==nil || [wfl isEqualToString:@""])
                    {
                        wfitweightLabel.text=[NSString stringWithFormat:@"0.0ct  X %@颗",[productlist objectAtIndex:41]];
                    }else{
                        
                        wfitweightLabel.text=[NSString stringWithFormat:@"%@ct  X %@颗",wfl,[productlist objectAtIndex:41]];
                    }
                    
                    //约重
                    NSString *wwl=[productlist objectAtIndex:17];
                    if(wwl==nil || [wwl isEqualToString:@""])
                    {
                        womanweightLabel.text=@"女：0.0g";
                    }else{
                        womanweightLabel.text=[NSString stringWithFormat:@"女：%@g",wwl];
                    }
                }else{
                    
                    //主石
                    NSString *wmt=[[winlaylist objectAtIndex:0] objectAtIndex:2];
                    if((NSNull *)wmt==[NSNull null] || wmt==nil || [wmt isEqualToString:@""])
                    {
                        wmianinlayText.text=@"0.0";
                    }else{
                        wminlay=[wmt floatValue];
                        wmianinlayText.text=[NSString stringWithFormat:@"%.2f",wminlay];
                    }
                    
                    //副石重量
                    NSString *wfl=[[winlaylist objectAtIndex:0] objectAtIndex:7];
                    if((NSNull *)wfl==[NSNull null] || wfl==nil || [wfl isEqualToString:@""])
                    {
                        wfitweightLabel.text=[NSString stringWithFormat:@"0.0ct  X %@颗",[productlist objectAtIndex:41]];
                    }else{
                        
                        wfitweightLabel.text=[NSString stringWithFormat:@"%.3fct  X %@颗",[wfl floatValue],[productlist objectAtIndex:41]];
                    }
                    
                    //约重
                    NSString *wwl=[[winlaylist objectAtIndex:0] objectAtIndex:3];
                    if((NSNull *)wwl==[NSNull null] || wwl==nil || [wwl isEqualToString:@""])
                    {
                        womanweightLabel.text=@"女：0.0g";
                    }else{
                        wmweight=[wwl floatValue];
                        womanweightLabel.text=[NSString stringWithFormat:@"女：%.3fg",wmweight];
                    }
                }
                
                //净度
                wnetText.text=@"净度";
                //颜色
                wcolorText.text=@"颜色";
                //材质
                wtexttureText.text=@"18K白";
                
                //男戒
                NSString *surl = [NSString stringWithFormat:@"/app/aifacen.php?uId=%@&type=1001&Upt=%@&Nowt=%@&Kstr=%@&twid=%@",uId,Upt,nowt,Kstr,pid];
                NSString *URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
                NSMutableDictionary * dict = [DataService GetDataService:URL];
                NSString *status=[NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]];
                if ([status isEqualToString:@"true"])
                {
                    manpdetail= [[NSMutableArray alloc] init];
                    [manpdetail setArray:[[dict objectForKey:@"result"] objectAtIndex:0]];
                    
                    //logo图片
                    NSString *murl=[NSString stringWithFormat:@"http://seyuu.com%@",[manpdetail objectAtIndex:8]];
                    NSURL *mimgUrl=[NSURL URLWithString:murl];
                    if (hasCachedImage(mimgUrl)) {
                        [mlogoimg setImage:[UIImage imageWithContentsOfFile:pathForURL(mimgUrl)]];
                    }else{
                        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:mimgUrl,@"url",mlogoimg,@"imageView",nil];
                        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
                    }
                    
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
                    mmaincountLabel.text=[NSString stringWithFormat:@" X %@颗",[manpdetail objectAtIndex:31]];
                    
                    //主石
                    minlaylist=[self checkinlay:[NSString stringWithFormat:@"%@",[manpdetail objectAtIndex:0]]];
                    if ([minlaylist count]<1) {
                        
                        //主石
                        NSString *mmt=[manpdetail objectAtIndex:34];
                        if(mmt==nil || [mmt isEqualToString:@""])
                        {
                            mmianinlayText.text=@"0.0";
                        }else{
                            mmianinlayText.text=[NSString stringWithFormat:@"%@",mmt];
                        }
                        
                        //副石重量
                        NSString *mfl=[manpdetail objectAtIndex:44];
                        if(mfl==nil || [mfl isEqualToString:@""])
                        {
                            mfitweightLabel.text=[NSString stringWithFormat:@"0.0ct  X %@颗",[manpdetail objectAtIndex:41]];
                        }else{
                            
                            mfitweightLabel.text=[NSString stringWithFormat:@"%@ct  X %@颗",mfl,[manpdetail objectAtIndex:41]];
                        }
                        
                        //约重
                        NSString *mwl=[manpdetail objectAtIndex:17];
                        if(mwl==nil || [mwl isEqualToString:@""])
                        {
                            manweightLabel.text=@"男：0.0g";
                        }else{
                            manweightLabel.text=[NSString stringWithFormat:@"男：%@g",mwl];
                        }
                    }else{
                        
                        //主石
                        NSString *mmt=[[minlaylist objectAtIndex:0] objectAtIndex:2];
                        if((NSNull *)mmt==[NSNull null] || mmt==nil || [mmt isEqualToString:@""])
                        {
                            mmianinlayText.text=@"0.0";
                        }else{
                            mminlay=[mmt floatValue];
                            mmianinlayText.text=[NSString stringWithFormat:@"%.2f",mminlay];
                        }
                        
                        //副石重量
                        
                        NSString *mfl=[[winlaylist objectAtIndex:0] objectAtIndex:7];
                        if((NSNull *)mfl==[NSNull null] || mfl==nil || [mfl isEqualToString:@""])
                        {
                            mfitweightLabel.text=[NSString stringWithFormat:@"0.0ct  X %@颗",[productlist objectAtIndex:41]];
                        }else{
                            
                            mfitweightLabel.text=[NSString stringWithFormat:@"%.3fct  X %@颗",[mfl floatValue],[productlist objectAtIndex:41]];
                        }
                        
                        //约重
                        NSString *mwl=[[minlaylist objectAtIndex:0] objectAtIndex:3];
                        if((NSNull *)mwl==[NSNull null] || mwl==nil || [mwl isEqualToString:@""])
                        {
                            manweightLabel.text=@"男：0.0g";
                        }else{
                            mmweight=[mwl floatValue];
                            manweightLabel.text=[NSString stringWithFormat:@"男：%.3fg",mmweight];
                        }
                    }
                    
                    //净度
                    mnetText.text=@"净度";
                    //颜色
                    mcolorText.text=@"颜色";
                    //材质
                    mtexttureText.text=@"18K白";
                }
                
                [self getPrice:[NSString stringWithFormat:@"%.3f",wmweight] minlay:[NSString stringWithFormat:@"%.3f",mmweight]];
            }
            
        });
    });
    
    wsizeText.text=[sizelist objectAtIndex:0];
    msizeText.text=[sizelist objectAtIndex:0];
    
}

-(void)getPrice:(NSString *)wweight minlay:(NSString *)mweight
{
    @try {
        //可以在此加代码提示用户说正在加载数据中
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作（异步操作）
            
            NSString *proprice=nil;
            wcolor=wcolorText.text;
            wnet=wnetText.text;
            mcolor=mcolorText.text;
            mnet=mnetText.text;
            productApi *priceApi=[[productApi alloc]init];
            if ([wcolorText.text isEqualToString:@"颜色"]) {
                wcolor=@"";
            }
            if ([wnetText.text isEqualToString:@"净度"]) {
                wnet=@"";
            }
            if ([mcolorText.text isEqualToString:@"颜色"]) {
                mcolor=@"";
            }
            if ([mnetText.text isEqualToString:@"净度"]) {
                mnet=@"";
            }
            womanprice=[priceApi getPrice:proclass goldType:wtexttureText.text goldWeight:wweight mDiaWeight:wmianinlayText.text mDiaColor:wcolor mVVS:wnet sDiaWeight:[NSString stringWithFormat:@"%@",[productlist objectAtIndex:44]] sCount:[NSString stringWithFormat:@"%@",[productlist objectAtIndex:41]] proid:pid];
            
            float womp=[womanprice floatValue];
            if ([proclass isEqualToString:@"3"] && [protypeWenProId isEqualToString:@"0"] && womp>0) {
                                priceApi=[[productApi alloc]init];
                                manprice=[priceApi getPrice:[NSString stringWithFormat:@"%@",[manpdetail objectAtIndex:5]] goldType:mtexttureText.text goldWeight:mweight mDiaWeight:mmianinlayText.text mDiaColor:mcolor mVVS:mnet sDiaWeight:[NSString stringWithFormat:@"%@",[manpdetail objectAtIndex:44]] sCount:[NSString stringWithFormat:@"%@",[manpdetail objectAtIndex:41]] proid:[NSString stringWithFormat:@"%@",[manpdetail objectAtIndex:0]]];
                
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
                    priceLabel.text=[NSString stringWithFormat:@"¥%@",[price objectAtIndex:0]];
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
        TView.frame=CGRectMake(58, 472, 68, 180);
        list=winlaylist;
    }else if (btntag==1)
    {
        TView.frame=CGRectMake(154, 472, 54, 120);
        list=netlist;
    }else if (btntag==2)
    {
        TView.frame=CGRectMake(216, 472, 54, 150);
        list=colorlist;
    }
    else if (btntag==3)
    {
        TView.frame=CGRectMake(58, 583, 80, 180);
        list=textturelist;
    }else if (btntag==4)
    {
        TView.frame=CGRectMake(58, 623, 60, 120);
        list=sizelist;
    }else if (btntag==5)
    {
        TView.frame=CGRectMake(58, 516, 68, 120);
        list=minlaylist;
    }else if (btntag==6)
    {
        TView.frame=CGRectMake(154, 516, 54, 120);
        list=mnetlist;
    }else if (btntag==7)
    {
        TView.frame=CGRectMake(216, 516, 54, 150);
        list=mcolorlist;
    }else if (btntag==8)
    {
        TView.frame=CGRectMake(154, 583, 81, 180);
        list=mtextturelist;
    }else if (btntag==9)
    {
        TView.frame=CGRectMake(154, 623, 60, 120);
        list=sizelist;
    }
    TView.hidden=NO;
    [TView reloadData];
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

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
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
    if (btntag==0 || btntag==5) {
        cell.textLabel.text = [NSString stringWithFormat:@"%.2f",[[[list objectAtIndex:row] objectAtIndex:2] floatValue]];
    }else{
        cell.textLabel.text = [list objectAtIndex:row];
    }
    
    cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
    cell.textLabel.textColor=[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSString *rowstring;
    if (btntag==0 || btntag==5) {
        rowstring = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%.2f",[[[list objectAtIndex:row] objectAtIndex:2] floatValue]]];
    }else{
        rowstring = [NSString stringWithFormat:@"%@",[list objectAtIndex:row]];
    }
    
    if (btntag==0) {
        rowindex=row;
        wminlay=[[[list objectAtIndex:row] objectAtIndex:2] floatValue];
        wmianinlayText.text=rowstring;
        NSString *nowtextture=wtexttureText.text;
        NSRange range=[nowtextture rangeOfString:@"18K"];
        if (range.length>0) {
            wmweight=[[[list objectAtIndex:row] objectAtIndex:3] floatValue];
            womanweightLabel.text=[NSString stringWithFormat:@"女戒：%.3fg",wmweight];
        }else{
            wmweight=[[[list objectAtIndex:row] objectAtIndex:4] floatValue];
            womanweightLabel.text=[NSString stringWithFormat:@"女戒：%.3fg",wmweight];
        }
        
        NSString *wfl=[[list objectAtIndex:row] objectAtIndex:7];
        if ((NSNull*)wfl!=[NSNull null] && wfl!=nil && ![wfl isEqualToString:@""]) {
        wfitweightLabel.text=[NSString stringWithFormat:@"%.3fct  X %@颗",[[[list objectAtIndex:row] objectAtIndex:7] floatValue],[productlist objectAtIndex:41]];
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
        
        NSString *nowtextture=wtexttureText.text;
        NSRange range=[nowtextture rangeOfString:@"18K"];
        if (range.length>0) {
            wmweight=[[[winlaylist objectAtIndex:rowindex] objectAtIndex:3] floatValue];
            womanweightLabel.text=[NSString stringWithFormat:@"女戒：%.3fg",wmweight];
        }else{
            wmweight=[[[winlaylist objectAtIndex:rowindex] objectAtIndex:4] floatValue];
            womanweightLabel.text=[NSString stringWithFormat:@"女戒：%.3fg",wmweight];
        }
    }else if (btntag==4)
    {
        wsizeText.text=rowstring;
    }else if (btntag==5)
    {
        mrowindex=row;
        mminlay=[[[list objectAtIndex:row] objectAtIndex:2] floatValue];
        mmianinlayText.text=rowstring;
        
        NSString *mnowtextture=mtexttureText.text;
        NSRange range=[mnowtextture rangeOfString:@"18K"];
        if (range.length>0) {
            mmweight=[[[list objectAtIndex:row] objectAtIndex:3] floatValue];
            manweightLabel.text=[NSString stringWithFormat:@"%.3fg",mmweight];
        }else{
            mmweight=[[[list objectAtIndex:row] objectAtIndex:4] floatValue];
            manweightLabel.text=[NSString stringWithFormat:@"%.3fg",mmweight];
        }
        
        NSString *mfl=[[list objectAtIndex:row] objectAtIndex:7];
        if ((NSNull*)mfl!=[NSNull null] && mfl!=nil && ![mfl isEqualToString:@""]) {
            mfitweightLabel.text=[NSString stringWithFormat:@"%.3fct  X %@颗",[mfl floatValue],[manpdetail objectAtIndex:41]];
        }
        
    }else if (btntag==6)
    {
        mnetText.text=rowstring;
    }else if (btntag==7)
    {
        mcolorText.text=rowstring;
    }else if (btntag==8)
    {
        mtexttureText.text=rowstring;
        
        NSString *mnowtextture=mtexttureText.text;
        NSRange range=[mnowtextture rangeOfString:@"18K"];
        if (range.length>0) {
            mmweight=[[[minlaylist objectAtIndex:mrowindex] objectAtIndex:3] floatValue];
            manweightLabel.text=[NSString stringWithFormat:@"%.3fg",mmweight];
        }else{
            mmweight=[[[minlaylist objectAtIndex:mrowindex] objectAtIndex:4] floatValue];
            manweightLabel.text=[NSString stringWithFormat:@"%.3fg",mmweight];
        }
    }else if (btntag==9)
    {
        msizeText.text=rowstring;
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
    
    [remarkText resignFirstResponder];
    [wfontLabel resignFirstResponder];
    [mfontLabel resignFirstResponder];
    oldframe=self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

//商品添加到购物车
-(IBAction)addshopcart:(id)sender{
    if ([wcolor isEqualToString:@""] || [wnet isEqualToString:@""] || [mcolor isEqualToString:@""] || [mnet isEqualToString:@""]) {
        NSString *rowString =@"请选择颜色或净度！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }else{
        sqlService * sql=[[sqlService alloc] init];
        //productEntity *goods=[sql GetProductDetail:productnumber];
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        buyproduct * entity=[[buyproduct alloc]init];
        entity.producttype=@"1";
        entity.productid=pid;
        entity.pcount=@"1";
        entity.pcolor=wcolorText.text;
        entity.pdetail=wfontLabel.text;
        entity.pvvs=wnetText.text;
        entity.psize=wsizeText.text;
        entity.pgoldtype=wtexttureText.text;
        entity.pweight=wmianinlayText.text;
        entity.customerid=myDelegate.entityl.uId;
        entity.pprice=womanprice;
        entity.pname=[productlist objectAtIndex:1];
        entity.Dia_Z_weight=[NSString stringWithFormat:@"%@",[productlist objectAtIndex:7]];
        entity.photos=[NSString stringWithFormat:@"%@(%@)",[productlist objectAtIndex:1],[productlist objectAtIndex:2]];
        
        entity.photom=[NSString stringWithFormat:@"金重：%.3f  材质：%@  钻重：%@",wmweight,wtexttureText.text,[productlist objectAtIndex:34]];
        entity.photob=[NSString stringWithFormat:@"净度：%@  颜色：%@  手寸：%@",wnetText.text,wcolorText.text,wsizeText.text];
        entity.remark=remarkText.text;
        buyproduct *successadd=[sql addToBuyproduct:entity];
        buyproduct *successaddman=[[buyproduct alloc]init];
        if ([proclass isEqualToString:@"3"] && [protypeWenProId isEqualToString:@"0"]) {
            buyproduct * manentity=[[buyproduct alloc]init];
            manentity.producttype=@"1";
            manentity.productid=[NSString stringWithFormat:@"%@",[manpdetail objectAtIndex:0]];
            manentity.pcount=@"1";
            manentity.pcolor=mcolorText.text;
            manentity.pdetail=mfontLabel.text;
            manentity.pvvs=mnetText.text;
            manentity.psize=msizeText.text;
            manentity.pgoldtype=mtexttureText.text;
            manentity.pweight=mmianinlayText.text;
            manentity.customerid=myDelegate.entityl.uId;
            manentity.pprice=manprice;
            manentity.pname=[NSString stringWithFormat:@"%@",[manpdetail objectAtIndex:1]];
            manentity.Dia_Z_weight=[NSString stringWithFormat:@"%@",[manpdetail objectAtIndex:7]];
            manentity.photos=[NSString stringWithFormat:@"%@(%@)",[manpdetail objectAtIndex:1],[manpdetail objectAtIndex:2]];
            
            manentity.photom=[NSString stringWithFormat:@"金重：%.3f  材质：%@  钻重：%@",mmweight,mtexttureText.text,[manpdetail objectAtIndex:34]];
            manentity.photob=[NSString stringWithFormat:@"净度：%@  颜色：%@  手寸：%@",mnetText.text,mcolorText.text,msizeText.text];
            manentity.remark=remarkText.text;
            sql=[[sqlService alloc]init];
            successaddman=[sql addToBuyproduct:manentity];
        }
        
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
    UIButton *btn=(UIButton *)sender;
    if (btn.tag==1) {
        patht=[NSString stringWithFormat:@"http://seyuu.com%@",[manpdetail objectAtIndex:7]];
    }
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

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    frame = textView.frame;
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

- (void)textViewDidEndEditing:(UITextView *)textView
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
