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
    searchfont.textColor=[UIColor colorWithRed:152.0f/255.0f green:152.0f/255.0f blue:152.0f/255.0f alpha:1];
    searchfont.text = @"   钻石编号:";
    searchfont.font=[UIFont boldSystemFontOfSize:10.0f];
    [searchfont sizeToFit];
    searchfont.backgroundColor=[UIColor colorWithRed:234.0f/255.0f green:234.0f/255.0f blue:234.0f/255.0f alpha:1];
    noText.leftView=searchfont;
    noText.leftViewMode = UITextFieldViewModeAlways;

    
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
-(void)passValue:(NSString *)value key:(NSString *)key tag:(NSString *)tag
{
    NSInteger tagint=[tag integerValue];
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
-(IBAction)choosetype:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    NakedDiamondselecttype *_NakedDiamondselecttype=[[NakedDiamondselecttype alloc]init];
    _NakedDiamondselecttype.btntag=[NSString stringWithFormat:@"%d",btn.tag];
    _NakedDiamondselecttype.delegate=self;
    [self.navigationController pushViewController:_NakedDiamondselecttype animated:NO];
}


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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
