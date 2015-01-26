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
#import "NakedDiamondlist.h"

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
@synthesize noText;
@synthesize minheight;
@synthesize maxheight;
@synthesize minprice;
@synthesize maxprice;
@synthesize selectview;

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
//        [self resetdata:nil];
//    }
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    btnarray=[[NSArray alloc]initWithObjects:modelButton,colorButton,netButton,cutButton,chasingButton,symmetryButton,fluorescenceButton,diplomaButton, nil];
    for (UIButton *btn in btnarray) {
        btn.titleLabel.numberOfLines=2;
    }
    modelvalue=@"";
    colorvalue=@"";
    netvalue=@"";
    cutvalue=@"";
    chasingvalue=@"";
    symmetryvalue=@"";
    fluorescencevalue=@"";
    diplomavalue=@"";
    
    noText.keyboardType=UIKeyboardTypeNumberPad;
    minprice.keyboardType=UIKeyboardTypeDecimalPad;
    maxprice.keyboardType=UIKeyboardTypeDecimalPad;
    minheight.keyboardType=UIKeyboardTypeDecimalPad;
    maxheight.keyboardType=UIKeyboardTypeDecimalPad;
    
    isfirst=0;
    
    UILabel *searchfont = [ [UILabel alloc]initWithFrame:CGRectZero];
    searchfont.textColor=[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1];
    searchfont.text = @"   钻石编号:";
    searchfont.font=[UIFont systemFontOfSize:10.0f];
    [searchfont sizeToFit];
    searchfont.backgroundColor=[UIColor colorWithRed:234.0f/255.0f green:234.0f/255.0f blue:234.0f/255.0f alpha:1];
    noText.leftView=searchfont;
    noText.leftViewMode = UITextFieldViewModeAlways;
    
    if ([selectview respondsToSelector:@selector(setSeparatorInset:)]) {
        [selectview setSeparatorInset:UIEdgeInsetsZero];
    }
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    frame = textField.frame;
    if (oldframe.origin.y!=frame.origin.y) {
        int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
        
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    //点击其他地方消失
    if (!CGRectContainsPoint([selectview frame], pt)) {
        //to-do
        selectview.hidden=YES;
    }
    
    [noText resignFirstResponder];
    [minheight resignFirstResponder];
    [maxheight resignFirstResponder];
    [minprice resignFirstResponder];
    [maxprice resignFirstResponder];
    oldframe=self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (oldframe.origin.y!=frame.origin.y) {
        self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
}


//接受回调参数
-(void)passValue:(NSString *)value key:(NSString *)key tag:(NSInteger)tag
{
    NSInteger tagint=tag;
    if (!key) {
        
        value=@"";
        NSString *name=@"";
        if (tagint==0) {
            name=@"形状";
            modelvalue=value;
            
        }else if(tagint==1)
        {
            name=@"颜色";
            colorvalue=value;
        }else if(tagint==2)
        {
            name=@"净度";
            netvalue=value;
        }else if(tagint==3)
        {
            name=@"切工";
            cutvalue=value;
        }else if(tagint==4)
        {
            name=@"抛光";
            chasingvalue=value;
        }else if(tagint==5)
        {
            name=@"对称";
            symmetryvalue=value;
        }else if(tagint==6)
        {
            name=@"荧光";
            fluorescencevalue=value;
        }else if(tagint==7)
        {
            name=@"证书";
            diplomavalue=value;
        }
        key=name;
    }else{
        if (tagint==0) {
            modelvalue=value;
            
        }else if(tagint==1)
        {
            colorvalue=value;
        }else if(tagint==2)
        {
            netvalue=value;
        }else if(tagint==3)
        {
            cutvalue=value;
        }else if(tagint==4)
        {
            chasingvalue=value;
        }else if(tagint==5)
        {
            symmetryvalue=value;
        }else if(tagint==6)
        {
            fluorescencevalue=value;
        }else if(tagint==7)
        {
            diplomavalue=value;
        }
    }
    for (UIButton *btn in btnarray) {
        if (btn.tag==tagint) {
            [btn setTitle:[NSString stringWithFormat:@"%@",key] forState:UIControlStateNormal];
        }
    }
}

-(IBAction)resetdata:(id)sender
{
    modelvalue=@"";
    colorvalue=@"";
    netvalue=@"";
    cutvalue=@"";
    chasingvalue=@"";
    symmetryvalue=@"";
    fluorescencevalue=@"";
    diplomavalue=@"";
    int i;
    int count=[btnarray count];
    NSString *name;
    for (i=0 ; i<count; i++) {
        if (i==0) {
            name=@"形状";
        }
        else if(i==1)
        {
            name=@"颜色";
        }else if(i==2)
        {
            name=@"净度";
        }else if(i==3)
        {
            name=@"切工";
        }else if(i==4)
        {
            name=@"抛光";
        }else if(i==5)
        {
            name=@"对称";
        }else if(i==6)
        {
            name=@"荧光";
        }else if(i==7)
        {
            name=@"证书";
        }
        
        UIButton *btn=[btnarray objectAtIndex:i];
        [btn setTitle:[NSString stringWithFormat:@"%@",name] forState:UIControlStateNormal];
        noText.text=@"";
        minheight.text=@"";
        maxheight.text=@"";
        minprice.text=@"";
        maxprice.text=@"";
        
    }
    
}



//选择类型
//-(IBAction)choosetype:(id)sender
//{
//    UIButton *btn=(UIButton *)sender;
//    NakedDiamondselecttype *_NakedDiamondselecttype=[[NakedDiamondselecttype alloc]init];
//    _NakedDiamondselecttype.btntag=[NSString stringWithFormat:@"%d",btn.tag];
//    _NakedDiamondselecttype.delegate=self;
//    [self.navigationController pushViewController:_NakedDiamondselecttype animated:NO];
//}


//搜索结果页面跳转
-(IBAction)searchresult:(id)sender
{
    NSMutableDictionary *condition = [NSMutableDictionary dictionaryWithCapacity:10];
    [condition setValue:modelvalue forKey:@"modelvalue"];
    [condition setValue:colorvalue forKey:@"colorvalue"];
    [condition setValue:netvalue forKey:@"netvalue"];
    [condition setValue:cutvalue forKey:@"cutvalue"];
    [condition setValue:chasingvalue forKey:@"chasingvalue"];
    [condition setValue:symmetryvalue forKey:@"symmetryvalue"];
    [condition setValue:fluorescencevalue forKey:@"fluorescencevalue"];
    [condition setValue:diplomavalue forKey:@"diplomavalue"];
    [condition setValue:noText.text forKey:@"no"];
    [condition setValue:minheight.text forKey:@"minheight"];
    [condition setValue:maxheight.text forKey:@"maxheight"];
    [condition setValue:minprice.text forKey:@"minprice"];
    [condition setValue:maxprice.text forKey:@"maxprice"];
    NakedDiamondlist *_NakedDiamondlist=[[NakedDiamondlist alloc]init];
    _NakedDiamondlist.condition=condition;
    _NakedDiamondlist.mydelegate=_mydelegate;
    [self.navigationController pushViewController:_NakedDiamondlist animated:NO];
}

-(IBAction)showtableview:(id)sender
{
    UIButton* btn=(UIButton *)sender;
    int btnvalue=btn.tag;
    selecttdtag=btn.tag;
    if (btnvalue==0) {
        selectview.frame=CGRectMake(0, 84, 72, 184);
        //        titleLabel.text=@"形状";
        list=[[NSArray alloc] initWithObjects:@"形状",@"圆形",@"公主方",@"祖母绿",@"雷蒂恩",@"椭圆形",@"橄榄形",@"枕形",@"梨形",@"心形",@"辐射形",nil];
        listvalue=[[NSArray alloc] initWithObjects:@"",@"RB",@"PE",@"EM",@"RD",@"OL",@"MQ",@"CU",@"PR",@"HT",@"ASH",nil];
        
    }else if(btnvalue==1)
    {
        //        titleLabel.text=@"颜色";
        selectview.frame=CGRectMake(72, 84, 80, 184);
        list=listvalue=[[NSArray alloc] initWithObjects:@"颜色",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M", nil];
    }else if(btnvalue==2)
    {
        //        titleLabel.text=@"净度";
        selectview.frame=CGRectMake(152, 84, 80, 184);
        list=listvalue=[[NSArray alloc] initWithObjects:@"净度",@"FL",@"IF",@"VVS1",@"VVS2",@"VS1",@"VS2",@"SI1",@"SI2",@"I1",@"I2", nil];
    }else if(btnvalue==3)
    {
        //        titleLabel.text=@"切工";
        selectview.frame=CGRectMake(232, 84, 88, 170);
        list=listvalue=[[NSArray alloc] initWithObjects:@"切工",@"EX",@"VG",@"GD",@"Fair", nil];
    }else if(btnvalue==4)
    {
        //        titleLabel.text=@"抛光";
        selectview.frame=CGRectMake(0, 129, 72, 170);
        list=listvalue=[[NSArray alloc] initWithObjects:@"抛光",@"EX",@"VG",@"GD",@"Fair", nil];
    }else if(btnvalue==5)
    {
        //        titleLabel.text=@"对称";
        selectview.frame=CGRectMake(72, 129, 80, 180);
        list=listvalue=[[NSArray alloc] initWithObjects:@"对称",@"EX",@"VG",@"GD",@"Fair", nil];
    }else if(btnvalue==6)
    {
        //        titleLabel.text=@"荧光";
        selectview.frame=CGRectMake(152, 129, 80, 184);
        list=[[NSArray alloc] initWithObjects:@"荧光",@"N",@"F",@"M",@"S",@"VS", nil];
        listvalue=[[NSArray alloc] initWithObjects:@"",@"Non,None",@"Fnt",@"Med",@"Stg,Sl",@"Vsl,Vst", nil];
    }else if(btnvalue==7)
    {
        //        titleLabel.text=@"证书";
        selectview.frame=CGRectMake(232, 129, 88, 210);
        list=[[NSArray alloc] initWithObjects:@"证书",@"GIA",@"IGI",@"NGTC",@"HRD",@"EGL",@"Other", nil];
        listvalue=[[NSArray alloc] initWithObjects:@"",@"GIA",@"IGI",@"NGTC",@"HRD",@"EGL",@"", nil];
    }
    
    [selectview reloadData];
    selectview.hidden=NO;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

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
    cell.textLabel.text = [list objectAtIndex:row];
    cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
    cell.textLabel.textColor=[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *rowString = [list objectAtIndex:[indexPath row]];
    NSString *value=[listvalue objectAtIndex:[indexPath row]];
    if([rowString isEqualToString:@"全部"])
    {
        rowString=nil;
        value=@"";
    }
    [self passValue:value key:rowString tag:selecttdtag];
    [selectview setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
