//
//  frontindex.m
//  zhubao_iphone
//
//  Created by johnson on 14-9-11.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "frontindex.h"
#import "Tool.h"

@interface frontindex ()

@end

@implementation frontindex

@synthesize logoimg;

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
    
    NSString *logopath = [[Tool getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"logopath.png"]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:logopath]) {
        [logoimg setImage:[[UIImage alloc] initWithContentsOfFile:logopath]];
    }
    else {
        [logoimg setImage:[UIImage imageNamed:@"logoshengyu"]];
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
    {
        logoimg.frame=CGRectMake(logoimg.frame.origin.x, logoimg.frame.origin.y, logoimg.frame.size.width, logoimg.frame.size.height+52);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
