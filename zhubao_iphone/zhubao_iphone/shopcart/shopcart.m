//
//  shopcart.m
//  zhubao_iphone
//
//  Created by johnson on 14-9-17.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "shopcart.h"
#import "AppDelegate.h"
#import "shopcartCell.h"
#import "decorateView.h"

@interface shopcart ()

@end

@implementation shopcart

@synthesize shopcartTView;

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
    
    [shopcartTView setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:234.0f/255.0f blue:234.0f/255.0f alpha:1]];
    
    [self loaddata];
}

-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    sqlService *shopcar=[[sqlService alloc] init];
    shoppingcartlist=[shopcar GetBuyproductList:myDelegate.entityl.uId];
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [shoppingcartlist count];
    //只有一组，数组数即为行数。
}

// 购物车数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"shopcartCell";
    
    shopcartCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"shopcartCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    buyproduct *goods =[shoppingcartlist objectAtIndex:[indexPath row]];
    if ([goods.producttype isEqualToString:@"3"]) {
        cell.fLabel.text=[NSString stringWithFormat:@"%@",goods.photos];
        if ([goods.Dia_Z_weight isEqualToString:@"RB"]) {
            
            cell.fLabel.text=[cell.fLabel.text stringByAppendingString:@"  形状：圆形"];
            cell.logoimg.image=[UIImage imageNamed:@"diamond01"];
        }
        else if ([goods.Dia_Z_weight isEqualToString:@"PE"]){
            
            cell.fLabel.text=[cell.fLabel.text stringByAppendingString:@"  形状：公主方"];
            cell.logoimg.image=[UIImage imageNamed:@"diamond02"];
        }
        else if ([goods.Dia_Z_weight isEqualToString:@"EM"]){
            
            cell.fLabel.text=[cell.fLabel.text stringByAppendingString:@"  形状：祖母绿"];
            cell.logoimg.image=[UIImage imageNamed:@"diamond03"];
        }
        else if ([goods.Dia_Z_weight isEqualToString:@"RD"]){
            
            cell.fLabel.text=[cell.fLabel.text stringByAppendingString:@"  形状：雷蒂恩"];
            cell.logoimg.image=[UIImage imageNamed:@"diamond04"];
        }
        else if ([goods.Dia_Z_weight isEqualToString:@"OL"]){
            
            cell.fLabel.text=[cell.fLabel.text stringByAppendingString:@"  形状：椭圆形"];
            cell.logoimg.image=[UIImage imageNamed:@"diamond05"];
        }
        else if ([goods.Dia_Z_weight isEqualToString:@"MQ"]){
            
            cell.fLabel.text=[cell.fLabel.text stringByAppendingString:@"  形状：橄榄形"];
            cell.logoimg.image=[UIImage imageNamed:@"diamond06"];
        }
        else if ([goods.Dia_Z_weight isEqualToString:@"CU"]){
            
            cell.fLabel.text=[cell.fLabel.text stringByAppendingString:@"  形状：枕形"];
            cell.logoimg.image=[UIImage imageNamed:@"diamond07"];
        }
        else if ([goods.Dia_Z_weight isEqualToString:@"PR"]){
            
            cell.fLabel.text=[cell.fLabel.text stringByAppendingString:@"  形状：梨形"];
            cell.logoimg.image=[UIImage imageNamed:@"diamond08"];
        }
        else if ([goods.Dia_Z_weight isEqualToString:@"HT"]){
            
            cell.fLabel.text=[cell.fLabel.text stringByAppendingString:@"  形状：心形"];
            cell.logoimg.image=[UIImage imageNamed:@"diamond09"];
        }
        else if ([goods.Dia_Z_weight isEqualToString:@"ASH"]){
            
            cell.fLabel.text=[cell.fLabel.text stringByAppendingString:@"  形状：镭射刑"];
            cell.logoimg.image=[UIImage imageNamed:@"diamond10"];
        }
        cell.sLabel.text=[NSString stringWithFormat:@"%@",goods.photom];
        cell.tLabel.text=[NSString stringWithFormat:@"%@",goods.photob];
        cell.countLabel.text=goods.pcount;
    }else if([goods.producttype isEqualToString:@"1"] || [goods.producttype isEqualToString:@"2"]){
        NSURL *imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://seyuu.com%@",goods.Dia_Z_weight]];
        if (hasCachedImage(imgUrl)) {
            cell.logoimg.image=[UIImage imageWithContentsOfFile:pathForURL(imgUrl)];
        }else
        {
            cell.logoimg.image=[UIImage imageNamed:@"diamonds"];
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",cell.logoimg,@"imageView",nil];
            [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
            
        }
        cell.fLabel.text=[NSString stringWithFormat:@"%@",goods.photos];
        cell.sLabel.text=[NSString stringWithFormat:@"%@",goods.photom];
        cell.tLabel.text=[NSString stringWithFormat:@"%@",goods.photob];
        cell.countLabel.text=goods.pcount;
    }
    else if ([goods.producttype isEqualToString:@"9"])
    {
        NSString *fullpath;
        if ([self isnull:goods.photos]) {
            fullpath =goods.photos;
        }else if ([self isnull:goods.photob])
        {
            fullpath =goods.photob;
        }else
        {
            fullpath =goods.photom;
        }
        UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullpath];
        [cell.logoimg setImage:savedImage];
        if ([self isnull:goods.pgoldtype]) {
            cell.fLabel.text=[@"材质:" stringByAppendingString:goods.pgoldtype];
        }
        if ([self isnull:goods.pweight]) {
            cell.fLabel.text=[cell.fLabel.text stringByAppendingString:[NSString stringWithFormat:@"  金重:%@g",goods.pweight]];
        }
        if ([self isnull:goods.Dia_Z_weight]) {
            cell.sLabel.text=[NSString stringWithFormat:@"主石重:%@Ct",goods.Dia_Z_weight];
        }
        if ([self isnull:goods.Dia_Z_count]) {
            cell.sLabel.text=[cell.sLabel.text stringByAppendingString:[NSString stringWithFormat:@"  主石数:%@",goods.Dia_Z_count]];
        }
        if ([self isnull:goods.Dia_F_weight]) {
            cell.sLabel.text=[cell.sLabel.text stringByAppendingString:[NSString stringWithFormat:@"  副石重:%@Ct",goods.Dia_F_weight]];
        }
        if ([self isnull:goods.Dia_F_count]) {
            cell.tLabel.text=[cell.tLabel.text stringByAppendingString:[NSString stringWithFormat:@"副石数:%@",goods.Dia_F_count]];
        }
        if ([self isnull:goods.psize]) {
            cell.tLabel.text=[cell.tLabel.text stringByAppendingString:[NSString stringWithFormat:@"  手寸:%@",goods.psize]];
        }
        if ([self isnull:goods.pdetail]) {
            cell.tLabel.text=[cell.tLabel.text stringByAppendingString:[NSString stringWithFormat:@"  刻字:%@",goods.pdetail]];
        }
        cell.countLabel.text=goods.pcount;
    }
    [cell.deleteButton addTarget:self action:@selector(deleteshoppingcartgoods:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteButton.tag=[indexPath row];
    
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    goodselect =[shoppingcartlist objectAtIndex:[indexPath row]];
    goodnumber=goodselect.pcount;
    
    hiview=[[UIView alloc]initWithFrame:self.view.frame];
    hiview.backgroundColor=[UIColor blackColor];
    hiview.alpha=0.5;
    
    
    demoView = [[UIView alloc] initWithFrame:CGRectMake(50, 230, 220, 100)];
    [demoView setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:234.0f/255.0f blue:234.0f/255.0f alpha:1.0f]];
    
    UIImageView *bgimgview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 220, 35)];
    [bgimgview setBackgroundColor:[UIColor colorWithRed:8.0f/255.0f green:46.0f/255.0f blue:85.0f/255.0f alpha:1.0f]];
    
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 220, 35)];
    title.text=@"商品数量";
    title.textAlignment = NSTextAlignmentCenter;
    title.font=[UIFont systemFontOfSize:17.0f];
    [title setTextColor:[UIColor colorWithRed:152.0f/255.0f green:152.0f/255.0f blue:152.0f/255.0f alpha:1.0f]];
    [title setBackgroundColor:[UIColor clearColor]];
    
    UIButton *reducebtn=[[UIButton alloc]initWithFrame:CGRectMake(11, 45, 30, 30)];
    [reducebtn setTitle:@"-" forState:UIControlStateNormal];
    [reducebtn setTitleColor:[UIColor colorWithRed:152.0f/255.0f green:152.0f/255.0f blue:152.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    reducebtn.titleLabel.font=[UIFont systemFontOfSize:12.0f];
    reducebtn.tag=0;
    [reducebtn addTarget:self action:@selector(changecount:) forControlEvents:UIControlEventTouchDown];
    
    goodsno=[[UITextField alloc]initWithFrame:CGRectMake(35, 45, 150, 30)];
    [goodsno setBorderStyle:UITextBorderStyleBezel];
    [goodsno setBackground:[UIImage imageNamed:@"textbox_midbg"]];
    goodsno.font=[UIFont systemFontOfSize:12.0f];
    goodsno.text=goodnumber;
    goodsno.keyboardType=UIKeyboardTypeNumberPad;
    
    UIButton *addbtn=[[UIButton alloc]initWithFrame:CGRectMake(181, 45, 30, 30)];
    [addbtn setTitle:@"+" forState:UIControlStateNormal];
    [addbtn setTitleColor:[UIColor colorWithRed:152.0f/255.0f green:152.0f/255.0f blue:152.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    addbtn.titleLabel.font=[UIFont systemFontOfSize:12.0f];
    addbtn.tag=1;
    [addbtn addTarget:self action:@selector(changecount:) forControlEvents:UIControlEventTouchDown];
    
    UIButton *okbtn=[[UIButton alloc]initWithFrame:CGRectMake(41, 70, 30, 30)];
    [okbtn setTitle:@"确定" forState:UIControlStateNormal];
    [okbtn setTitleColor:[UIColor colorWithRed:152.0f/255.0f green:152.0f/255.0f blue:152.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    okbtn.titleLabel.font=[UIFont systemFontOfSize:15.0f];
    okbtn.tag=1;
    [okbtn addTarget:self action:@selector(demoviewtarget:) forControlEvents:UIControlEventTouchDown];
    
    UIButton *canclebtn=[[UIButton alloc]initWithFrame:CGRectMake(141, 70, 30, 30)];
    [canclebtn setTitle:@"取消" forState:UIControlStateNormal];
    [canclebtn setTitleColor:[UIColor colorWithRed:152.0f/255.0f green:152.0f/255.0f blue:152.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    canclebtn.titleLabel.font=[UIFont systemFontOfSize:15.0f];
    canclebtn.tag=0;
    [canclebtn addTarget:self action:@selector(demoviewtarget:) forControlEvents:UIControlEventTouchDown];
    
    [demoView addSubview:bgimgview];
    [demoView addSubview:okbtn];
    [demoView addSubview:canclebtn];
    [demoView addSubview:addbtn];
    [demoView addSubview:reducebtn];
    [demoView addSubview:goodsno];
    [demoView addSubview:title];
    [self.view addSubview:hiview];
    [self.view addSubview:demoView];
}

//更改数量
-(void)changecount:(UIButton *)btn
{
    NSInteger btntag=btn.tag;
    NSInteger count=[goodsno.text integerValue];
    if (btntag==0) {
        if (count>0) {
            goodsno.text=[NSString stringWithFormat:@"%d",count-1];
        }
    }else{
        goodsno.text=[NSString stringWithFormat:@"%d",count+1];
    }
}

//数量弹出框触发事件
-(void)demoviewtarget:(UIButton *)btn
{
    NSInteger btntag=btn.tag;
    if (btntag==1) {
        goodselect.pcount=goodsno.text;
        sqlService *_sqlService=[[sqlService alloc]init];
        NSString *info=[_sqlService updateBuyproduct:goodselect];
        if (!info) {
            NSString *rowString =@"未知错误";
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }else
        {
            [self loaddata];
            [shopcartTView reloadData];
        }
        
    }
    [hiview removeFromSuperview];
    [demoView removeFromSuperview];
}

//购物车删除
-(void)deleteshoppingcartgoods:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    entity1 = [shoppingcartlist objectAtIndex:btn.tag];
    NSString *rowString =@"是否删除该商品?";
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alter show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        sqlService * sql=[[sqlService alloc]init];
        NSString *successdelete=[sql deleteBuyproduct:entity1.Id];
        if (successdelete) {
            
            [_mydelegate performSelector:@selector(refleshBuycutData)];
            
            [self loaddata];
            [shopcartTView reloadData];
            
            NSString *rowString =@"删除成功！";
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
            
        }else{
            NSString *rowString =@"删除失败！";
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }
    }
}

//订单提交
-(IBAction)submitorder:(id)sender
{
    sqlService *sql=[[sqlService alloc]init];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    myDelegate.mydelegate=self;
    [sql saveOrder:myDelegate.entityl.uId];
}

-(void)refleshdata
{
    [_mydelegate performSelector:@selector(refleshBuycutData)];
    [self loaddata];
    [shopcartTView reloadData];
}


-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}


//判断是否为空
-(BOOL)isnull:(NSString *)str
{
    if (str && ![str isEqualToString:@""] && ![str isEqualToString:@"(null)"]) {
        return true;
    }else{
        return false;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
