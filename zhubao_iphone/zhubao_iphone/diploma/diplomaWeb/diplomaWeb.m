//
//  diplomaWeb.m
//  zhubao_iphone
//
//  Created by johnson on 14-9-16.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "diplomaWeb.h"

@interface diplomaWeb ()

@end

@implementation diplomaWeb

@synthesize dipWebview;
@synthesize url;
@synthesize clogoimg;
@synthesize UINavigationBar;

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
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    clogoimg.frame=CGRectMake(clogoimg.frame.origin.x, clogoimg.frame.origin.y, 40, 20);
    self.UINavigationBar.tintColor=[UIColor blackColor];
#endif
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [dipWebview loadRequest:request];
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
