//
//  buyproduct.h
//  zhubao
//
//  Created by moko on 14-6-5.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "productEntity.h"
#import "productdia.h"

@interface buyproduct : NSObject

@property (nonatomic, retain) NSString * Id;
@property (nonatomic, retain) NSString * productid;//产品的id
@property (nonatomic, retain) NSString * pcolor;//颜色
@property (nonatomic, retain) NSString * pcount;//数量
@property (nonatomic, retain) NSString * pdetail;//详情说明
@property (nonatomic, retain) NSString * psize;//尺寸
@property (nonatomic, retain) NSString * pprice;//价格
@property (nonatomic, retain) NSString * customerid;//用户id
@property (nonatomic, retain) NSString * producttype;//旧的类型（0代表是商品，1是钻，2高级定制）新的类型 1商品 3裸钻 9高级定制
@property (nonatomic, retain) NSString * pvvs;//主石净度
@property (nonatomic, retain) NSString * pweight;//重量
@property (nonatomic, retain) NSString * pgoldtype;//材质

@property (nonatomic, retain) NSString * pname;//名称(为钻石时为：石头证书号 商品时：商品型号)

@property (nonatomic, retain) NSString * photos;//图片1(高级定制)
@property (nonatomic, retain) NSString * photom;//图片2(高级定制)
@property (nonatomic, retain) NSString * photob;//图片3(高级定制)
@property (nonatomic, retain) NSString * Dia_Z_weight;//主石重	单位克拉(高级定制)
@property (nonatomic, retain) NSString * Dia_Z_count;//主石数量(高级定制)
@property (nonatomic, retain) NSString * Dia_F_weight;//副石重	单位克拉(高级定制)
@property (nonatomic, retain) NSString * Dia_F_count;//副石数量(高级定制)





@end
