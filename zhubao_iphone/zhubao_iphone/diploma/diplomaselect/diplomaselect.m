//
//  diplomaselect.m
//  zhubao_iphone
//
//  Created by johnson on 14-9-16.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "diplomaselect.h"
#import "diplomaWeb.h"

@interface diplomaselect ()

@end

@implementation diplomaselect

@synthesize typeText;
@synthesize noText;
@synthesize heightLabel;
@synthesize dipTView;

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
    list=[[NSArray alloc] initWithObjects:@"GIA(美国宝石学院)", @"NGTC(国家珠宝玉石质量监督中心)",
          @"IGI(世界宝石学院)", @"HRD(比利时钻石高阶层会议)", @"AGS(美国宝石学学会)", @"EGL(欧洲宝石学院)", nil];
    typeText.userInteractionEnabled=NO;
    typeText.text=[list objectAtIndex:0];
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
    //只有一组，数组数即为行数。
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [list objectAtIndex:row];
    cell.textLabel.font=[UIFont boldSystemFontOfSize:12.0f];
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *rowString = [list objectAtIndex:[indexPath row]];
    typeText.text=rowString;
    diptype=[indexPath row];
    dipTView.hidden=YES;
    
}

//点击tableview以外得地方关闭
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    //点击其他地方消失
    if (!CGRectContainsPoint([dipTView frame], pt)) {
        //to-do
        dipTView.hidden=YES;
    }
    
    [heightLabel resignFirstResponder];
    [noText resignFirstResponder];
    
}

//证书下拉选择
- (IBAction)diplomaselect:(id)sender
{
    dipTView.hidden=NO;
}

//证书查询浏览器页面跳转
//0为GIA，1为NGTC，2为IGI，3为HRD，4为AGS，5为EGL
-(IBAction)diplomasearch:(id)sender
{
    NSString *url;
    if(diptype<0){
        NSString *rowString =@"请选择证书类型！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    
    NSString *nostr=[NSString stringWithFormat:@"%@",noText.text];
    NSString *heightstr=[NSString stringWithFormat:@"%@",heightLabel.text];
//    if([nostr isEqualToString:@""] || [nostr isEqualToString:@"(null)"] || [heightstr isEqualToString:@""] || [heightstr isEqualToString:@"(null)"]){
//        NSString *rowString =@"内容不能为空";
//        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alter show];
//        return;
//    }
    
    if (diptype==0) {
        url=[@"https://myapps.gia.edu/ReportCheckPortal/getReportData.do?&reportno=" stringByAppendingString:nostr];
        url=[url stringByAppendingString:@"&weight="];
        url=[url stringByAppendingString:heightstr];
    }else if (diptype==1){
        url=[@"HTTP://seyuu.com/Unrelated/TurnTongtc.asp?reportno=" stringByAppendingString:nostr];
        url=[url stringByAppendingString:@"&weight="];
        url=[url stringByAppendingString:heightstr];
    }else if (diptype==2){
        url=[@"HTTP://seyuu.com/Unrelated/TurnToIGI.asp?reportno=" stringByAppendingString:nostr];
        url=[url stringByAppendingString:@"&weight="];
        url=[url stringByAppendingString:heightstr];
    }else if (diptype==3){
        url=[@"http://www.hrdantwerplink.be/?record_number=" stringByAppendingString:nostr];
        url=[url stringByAppendingString:@"&weight="];
        url=[url stringByAppendingString:heightstr];
        url=[url stringByAppendingString:@"&L="];
    }else if (diptype==4){
        url=[@"http://agslab.com/reportTypes/dqr.php?StoneID=" stringByAppendingString:nostr];
        url=[url stringByAppendingString:@"&Weight="];
        url=[url stringByAppendingString:heightstr];
        url=[url stringByAppendingString:@"&D=1"];
    }else if (diptype==5){
        url=[@"http://www.eglusa.com/oresults/SearchPage3.php?st_num=" stringByAppendingString:nostr];
    }
    diplomaWeb *_diplomaWeb=[[diplomaWeb alloc]init];
    _diplomaWeb.url=url;
    [self.navigationController pushViewController:_diplomaWeb animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
