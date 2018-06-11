//
//  MedicarePlace.h
//  Medicare
//
//  Created by Mai Hưng on 6/7/18.
//  Copyright © 2018 hungmai. All rights reserved.
//

#import <Foundation/Foundation.h>

#define QUAN_1 @"Quận 1"
#define QUAN_3 @"Quận 3"
#define QUAN_5 @"Quận 5"
#define QUAN_7 @"Quận 7"
#define QUAN_9 @"Quận 9"
#define QUAN_2 @"Quận 2"
#define QUAN_11 @"Quận 11"
#define QUAN_10 @"Quận 10"
#define QUAN_TAN_BINH @"Quận Tân Bình"
#define QUAN_BINH_THANH @"Quận Bình Thạnh"
#define QUAN_THU_DUC @"Quận Thủ Đức"
#define BINH_DUONG @"Bình Dương"
#define DONG_NAI @"Đồng Nai"

@interface MedicarePlace : NSObject
@property (strong, nonatomic) NSString *district;
@property (strong, nonatomic) NSString *address;

- (instancetype)initWithDistrict:(NSString *)district address:(NSString *)address;
@end
