//
//  updatememberdata.m
//  zhubao_iphone
//
//  Created by johnson on 14-9-16.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "updatememberdata.h"
#import "AppDelegate.h"

@interface updatememberdata ()

@end

@implementation updatememberdata

@synthesize companyname;
@synthesize username;
@synthesize userphone;
@synthesize usertel;
@synthesize paddr;
@synthesize caddr;
@synthesize addr;
@synthesize division;
@synthesize tview;

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
    selecttable=0;
    paddr.userInteractionEnabled=YES;
    caddr.userInteractionEnabled=YES;
    division.userInteractionEnabled=YES;
    tableviewframe=tview.frame;
    
    Divisionlist = [[NSArray alloc] initWithObjects:@"办公室", @"市场部",
                              @"采购部", @"技术部",@"人力资源",@"其他", nil];
    
   provincelist = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"]];
    
    //初始化数据
    [self loaddata];
}

//初始化数据
-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    companyname.text=myDelegate.entityl.userTrueName;
    username.text=myDelegate.entityl.lxrName;
    userphone.text=myDelegate.entityl.Lxphone;
    usertel.text=myDelegate.entityl.Phone;
    paddr.text=myDelegate.entityl.Sf;
    caddr.text=myDelegate.entityl.Cs;
    addr.text=myDelegate.entityl.Address;
    
    //初始化城市列表
    NSInteger count=[provincelist count];
    for (int i=0; i<count; i++) {
        
        NSDictionary *rowString = [provincelist objectAtIndex:i];
        NSString * proname=[rowString objectForKey:@"state"];
        
        if ([myDelegate.entityl.Sf hasPrefix:proname]) {
            citylist=[rowString objectForKey:@"cities"];
            i=count;
        }
    }
    
    @try {
        if (!myDelegate.entityl.bmName) {
            division.text=@"其他";
        }else if ([ myDelegate.entityl.bmName isEqualToString:@"1"]) {
            division.text=@"办公室";
        }else if ([ myDelegate.entityl.bmName isEqualToString:@"2"]){
            division.text=@"市场部";
        }else if ([ myDelegate.entityl.bmName isEqualToString:@"3"]){
            division.text=@"采购部";
        }else if ([ myDelegate.entityl.bmName isEqualToString:@"4"]){
            division.text=@"技术部";
        }else if ([ myDelegate.entityl.bmName isEqualToString:@"5"]){
            division.text=@"人力资源";
        }else if ([ myDelegate.entityl.bmName isEqualToString:@"6"]){
            division.text=@"其他";
        }
    }
    @catch (NSException *exception) {
        division.text=@"其他";
    }
    @finally {
        
    }
}

//tableview显示位置
-(IBAction)selecttableview:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    selecttable=btntag;
    tview.hidden=NO;
    //省
    if (btntag==0) {
        
        tview.frame=tableviewframe;
        list=provincelist;
     //市
    }else if (btntag==1){
        
        tview.frame=CGRectMake(tableviewframe.origin.x, tableviewframe.origin.y+40, tableviewframe.size.width, tableviewframe.size.height);
        list=citylist;
     //部门
    }else if (btntag==2){
        
        tview.frame=CGRectMake(tableviewframe.origin.x, tableviewframe.origin.y+120, tableviewframe.size.width, tableviewframe.size.height);
        list=Divisionlist;
    }
    [tview reloadData];
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
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
    if (selecttable==0) {
        NSDictionary *rowString = [provincelist objectAtIndex:[indexPath row]];
        cell.textLabel.text = [rowString objectForKey:@"state"];
        
    }else if (selecttable==1){
        cell.textLabel.text = [citylist objectAtIndex:row];
    }else if (selecttable==2){
        cell.textLabel.text = [Divisionlist objectAtIndex:row];
    }
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selecttable==0) {
        NSDictionary *rowString = [provincelist objectAtIndex:[indexPath row]];
        NSString * proname=[rowString objectForKey:@"state"];
        NSArray * cities=[rowString objectForKey:@"cities"];
        
        paddr.text=proname;
        citylist=cities;
        caddr.text=nil;
        
    }else if (selecttable==1){
        NSString *rowString = [citylist objectAtIndex:[indexPath row]];
        caddr.text=rowString;
        
    }else if (selecttable==2){
        NSString *rowString = [Divisionlist objectAtIndex:[indexPath row]];
        division.text=rowString;
    }
    tview.hidden=YES;
}

//点击tableview以外得地方关闭
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    //点击其他地方消失
    if (!CGRectContainsPoint([tview frame], pt)) {
        //to-do
        tview.hidden=YES;
    }
    [companyname resignFirstResponder];
    [username resignFirstResponder];
    [userphone resignFirstResponder];
    [usertel resignFirstResponder];
    [addr resignFirstResponder];
}

//会员资料修改保存操作
-(IBAction)updatemember:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        myDelegate.entityl.userTrueName=companyname.text;
        myDelegate.entityl.lxrName=username.text;
        myDelegate.entityl.Phone=userphone.text;
        myDelegate.entityl.Lxphone=usertel.text;
        myDelegate.entityl.Sf=paddr.text;
        myDelegate.entityl.Cs=caddr.text;
        myDelegate.entityl.Address=addr.text;
        if ([division.text isEqualToString:@"办公室"]) {
            myDelegate.entityl.bmName=@"1";
        }else if ([division.text isEqualToString:@"市场部"]){
            myDelegate.entityl.bmName=@"2";
        }else if ([division.text isEqualToString:@"采购部"]){
            myDelegate.entityl.bmName=@"3";
        }else if ([division.text isEqualToString:@"技术部"]){
            myDelegate.entityl.bmName=@"4";
        }else if ([division.text isEqualToString:@"人力资源"]){
            myDelegate.entityl.bmName=@"5";
        }else if ([division.text isEqualToString:@"其他"]){
            myDelegate.entityl.bmName=@"6";
        }
    
    
    NSString * uId=myDelegate.entityl.uId;
    NSString * Upt=@"0";//获取上一次的更新时间
    
    getNowTime * time=[[getNowTime alloc] init];
    NSString * Nowt=[time nowTime];
    
    //        userTrueName	String	“”	真实姓名/企业名称
    //        sfUrl	String	“”	个人身份证扫描件图片地址
    //        lxrName	String	“”	企业联系人姓名
    //        Sex	Int	0	企业联系人性别/个人用户性别
    //        bmName	Int	0	企业联系人所在部门
    //        Email	String	“”	邮箱
    //        Phone	String	“”	企业联系人电话，个人用户手机号
    //        Lxphone	String	“”	企业联系人手机号
    //        Sf	String	“”	省份
    //        Cs	String	“”	城市
    //        Address	String	“”	详细街道地址
    
    NSString * params=[NSString stringWithFormat:@"userTrueName=%@&sfUrl=%@&lxrName=%@&Sex=%@&bmName=%@&Email=%@&Phone=%@&Lxphone=%@&Sf=%@&Cs=%@&Address=%@&",myDelegate.entityl.userTrueName,myDelegate.entityl.sfUrl,myDelegate.entityl.lxrName,myDelegate.entityl.Sex,myDelegate.entityl.bmName,myDelegate.entityl.Email,myDelegate.entityl.Phone,myDelegate.entityl.Lxphone,myDelegate.entityl.Sf,myDelegate.entityl.Cs,myDelegate.entityl.Address];
    
    //Kstr=md5(uId|type|Upt|Key|Nowt)
    NSString * Kstr=[Commons md5:[NSString stringWithFormat:@"%@|%@|%@|%@|%@",uId,@"502",Upt,apikey,Nowt]];
    
    NSString * surl = [NSString stringWithFormat:@"/app/aiface.php?uId=%@&type=502&Upt=%@&Nowt=%@&Kstr=%@",uId,Upt,Nowt,Kstr];
    
    NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
    
    NSMutableDictionary * dict = [DataService PostDataService:URL postDatas:(NSString*)params];
    NSString *state=[NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]];
    
    if ([state isEqualToString:@"true"]) {
        myDelegate.entityl.puptime=[NSString stringWithFormat:@"%@",[dict objectForKey:@"uptime"]];
        NSString *rowString =@"修改成功！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }else{
        NSString *rowString =@"修改失败！";
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
