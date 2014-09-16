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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    modelvalue=@"";
    colorvalue=@"";
    netvalue=@"";
    cutvalue=@"";
    chasingvalue=@"";
    symmetryvalue=@"";
    fluorescencevalue=@"";
    diplomavalue=@"";
    
}

-(void)passValue:(NSString *)value key:(NSString *)key tag:(NSString *)tag
{
    NSInteger tagint=[tag integerValue];
    if (!key) {
        key=@"全部";
        value=@"";
    }
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
    
    NSArray *btnarray=[[NSArray alloc]initWithObjects:modelButton,colorButton,netButton,cutButton,chasingButton,symmetryButton,fluorescenceButton,diplomaButton, nil];
    for (UIButton *btn in btnarray) {
        if (btn.tag==tagint) {
            [btn setTitle:[NSString stringWithFormat:@"%@：%@",name,key] forState:UIControlStateNormal];
        }
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
    [self.navigationController pushViewController:_NakedDiamondlist animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
