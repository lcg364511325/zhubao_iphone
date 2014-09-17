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
        if ([goods.diaentiy.Dia_Shape isEqualToString:@"RB"]) {
            cell.fLabel.text=@"圆形";
            cell.logoimg.image=[UIImage imageNamed:@"round.jpg"];
        }
        else if ([goods.diaentiy.Dia_Shape isEqualToString:@"PE"]){
            cell.fLabel.text=@"公主方";
            cell.logoimg.image=[UIImage imageNamed:@"princess2.jpg"];
        }
        else if ([goods.diaentiy.Dia_Shape isEqualToString:@"EM"]){
            cell.fLabel.text=@"祖母绿";
            cell.logoimg.image=[UIImage imageNamed:@"Emerald.jpg"];
        }
        else if ([goods.diaentiy.Dia_Shape isEqualToString:@"RD"]){
            cell.fLabel.text=@"雷蒂恩";
            cell.logoimg.image=[UIImage imageNamed:@"radiant.jpg"];
        }
        else if ([goods.diaentiy.Dia_Shape isEqualToString:@"OL"]){
            cell.fLabel.text=@"椭圆形";
            cell.logoimg.image=[UIImage imageNamed:@"Oval.jpg"];
        }
        else if ([goods.diaentiy.Dia_Shape isEqualToString:@"MQ"]){
            cell.fLabel.text=@"橄榄形";
            cell.logoimg.image=[UIImage imageNamed:@"marquise.jpg"];
        }
        else if ([goods.diaentiy.Dia_Shape isEqualToString:@"CU"]){
            cell.fLabel.text=@"枕形";
            cell.logoimg.image=[UIImage imageNamed:@"cushion.jpg"];
        }
        else if ([goods.diaentiy.Dia_Shape isEqualToString:@"PR"]){
            cell.fLabel.text=@"梨形";
            cell.logoimg.image=[UIImage imageNamed:@"Pear2.jpg"];
        }
        else if ([goods.diaentiy.Dia_Shape isEqualToString:@"HT"]){
            cell.fLabel.text=@"心形";
            cell.logoimg.image=[UIImage imageNamed:@"Heart.jpg"];
        }
        else if ([goods.diaentiy.Dia_Shape isEqualToString:@"ASH"]){
            cell.fLabel.text=@"镭射刑";
            cell.logoimg.image=[UIImage imageNamed:@"Asscher2.jpg"];
        }
        if (goods.diaentiy.Dia_Lab) {
            cell.fLabel.text=[@"  证书:" stringByAppendingString:goods.diaentiy.Dia_Lab];
        }
        if (goods.diaentiy.Dia_ART) {
            cell.fLabel.text=[cell.fLabel.text stringByAppendingString:[NSString stringWithFormat:@"  编号:%@",goods.diaentiy.Dia_ART]];
        }
        if (goods.pweight) {
            cell.sLabel.text=[cell.sLabel.text stringByAppendingString:[NSString stringWithFormat:@"  钻重:%@",goods.pweight]];
        }
        if (goods.pcolor) {
            cell.sLabel.text=[cell.sLabel.text stringByAppendingString:[NSString stringWithFormat:@"  颜色:%@",goods.pcolor]];
        }
        if (goods.pvvs) {
            cell.sLabel.text=[cell.sLabel.text stringByAppendingString:[NSString stringWithFormat:@"  净度:%@",goods.pvvs]];
        }
        if (goods.diaentiy.Dia_Cut) {
            cell.sLabel.text=[cell.sLabel.text stringByAppendingString:[NSString stringWithFormat:@"  切工:%@",goods.diaentiy.Dia_Cut]];
        }
        if (goods.diaentiy.Dia_Pol) {
            cell.sLabel.text=[cell.sLabel.text stringByAppendingString:[NSString stringWithFormat:@"  抛光:%@",goods.diaentiy.Dia_Pol]];
        }
        if (goods.diaentiy.Dia_Sym) {
            cell.tLabel.text=[@"对称:" stringByAppendingString:goods.diaentiy.Dia_Sym];
        }else{
            cell.tLabel.text=nil;
        }
        cell.countLabel.text=goods.pcount;
    }else if([goods.producttype isEqualToString:@"1"] || [goods.producttype isEqualToString:@"2"]){
        NSURL *imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://seyuu.com%@",goods.proentiy.Pro_smallpic]];
        if (hasCachedImage(imgUrl)) {
            cell.logoimg.image=[UIImage imageWithContentsOfFile:pathForURL(imgUrl)];
        }else
        {
            cell.logoimg.image=[UIImage imageNamed:@"diamonds"];
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",cell.logoimg,@"imageView",nil];
            [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
            
        }
        if (goods.proentiy.Pro_number) {
            cell.fLabel.text=goods.proentiy.Pro_number;
        }else{
            cell.fLabel.text=nil;
        }
        if (goods.proentiy.Pro_goldWeight) {
            cell.sLabel.text=[@"金重:" stringByAppendingString:goods.proentiy.Pro_goldWeight];
        }
        if (goods.pgoldtype) {
            cell.sLabel.text=[cell.sLabel.text stringByAppendingString:[NSString stringWithFormat:@"  材质:%@",goods.pgoldtype]];
        }
        if (goods.proentiy.Pro_Z_weight) {
            cell.sLabel.text=[cell.sLabel.text stringByAppendingString:[NSString stringWithFormat:@"  钻重:%@",goods.proentiy.Pro_Z_weight]];
        }
        if (goods.proentiy.Pro_f_clarity) {
            cell.sLabel.text=[cell.sLabel.text stringByAppendingString:[NSString stringWithFormat:@"  净度:%@",goods.proentiy.Pro_f_clarity]];
        }
        if (goods.proentiy.Pro_Z_color) {
            cell.sLabel.text=[cell.sLabel.text stringByAppendingString:[NSString stringWithFormat:@"  颜色:%@",goods.proentiy.Pro_Z_color]];
        }
        cell.tLabel.text=nil;
        cell.countLabel.text=goods.pcount;
    }
    else if ([goods.producttype isEqualToString:@"9"])
    {
        NSString *fullpath =goods.photos;
        UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullpath];
        [cell.logoimg setImage:savedImage];
        if (goods.pgoldtype) {
            cell.fLabel.text=[@"材质:" stringByAppendingString:goods.pgoldtype];
        }
        if (goods.pweight) {
            cell.fLabel.text=[cell.fLabel.text stringByAppendingString:[NSString stringWithFormat:@"  金重:%@g",goods.pweight]];
        }
        if (goods.Dia_Z_weight) {
            cell.sLabel.text=[NSString stringWithFormat:@"主石重:%@Ct",goods.Dia_Z_weight];
        }
        if (goods.Dia_Z_count) {
            cell.sLabel.text=[cell.sLabel.text stringByAppendingString:[NSString stringWithFormat:@"  主石数:%@",goods.Dia_Z_count]];
        }
        if (goods.Dia_F_weight) {
            cell.sLabel.text=[cell.sLabel.text stringByAppendingString:[NSString stringWithFormat:@"  副石重:%@Ct",goods.Dia_F_weight]];
        }
        if (goods.Dia_F_count) {
            cell.sLabel.text=[cell.sLabel.text stringByAppendingString:[NSString stringWithFormat:@"  副石数:%@",goods.Dia_F_count]];
        }
        if (goods.psize) {
            cell.sLabel.text=[cell.sLabel.text stringByAppendingString:[NSString stringWithFormat:@"  手寸:%@",goods.psize]];
        }
        if (goods.pdetail) {
            cell.tLabel.text=[@"刻字:" stringByAppendingString:goods.pdetail];
        }else{
            cell.tLabel.text=nil;
        }
    }
    
    [cell.deleteButton addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSString *rowString = [self.list objectAtIndex:[indexPath row]];
    //Nakeddisplay.hidden=YES;
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
