//
//  MedicarePlace.h
//  Medicare
//
//  Created by Mai Hưng on 6/7/18.
//  Copyright © 2018 hungmai. All rights reserved.
//

#import <Foundation/Foundation.h>

#define QUAN_1 @"QUAN_1"
#define QUAN_3 @"QUAN_3"
#define QUAN_5 @"QUAN_5"
#define QUAN_7 @"QUAN_7"
#define QUAN_9 @"QUAN_9"
#define QUAN_2 @"QUAN_2"
#define QUAN_11 @"QUAN_11"
#define QUAN_10 @"QUAN_10"
#define QUAN_TAN_BINH @"QUAN_TAN_BINH"
#define QUAN_BINH_THANH @"QUAN_BINH_THANH"
#define QUAN_THU_DUC @"QUAN_THU_DUC"
#define BINH_DUONG @"BINH_DUONG"
#define DONG_NAI @"DONG_NAI"

@interface MedicarePlace : NSObject
@property (strong, nonatomic) NSString *district;
@property (strong, nonatomic) NSString *address;

- (instancetype)initWithDistrict:(NSString *)district address:(NSString *)address;
@end
