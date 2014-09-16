//
//  updatememberdata.m
//  zhubao_iphone
//
//  Created by johnson on 14-9-16.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "updatememberdata.h"

@interface updatememberdata ()

@end

@implementation updatememberdata

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
    
    Divisionlist = [[NSArray alloc] initWithObjects:@"办公室", @"市场部",
                              @"采购部", @"技术部",@"人力资源",@"其他", nil];
    
   provincelist = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
