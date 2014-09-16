//
//  productdetail.m
//  zhubao_iphone
//
//  Created by johnson on 14-9-15.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "productdetail.h"

@interface productdetail ()

@end

@implementation productdetail

@synthesize pdSView;

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
    pdSView.backgroundColor=[UIColor  colorWithPatternImage:[UIImage imageNamed:@"backgroundcolor"]];
    
    
    
    [self loaddata];
}

-(void)loaddata
{
    UIImageView *pdimg=[[UIImageView alloc]initWithFrame:CGRectMake(160, 5, 50, 100)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
