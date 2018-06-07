//
//  MedicareManager.m
//  Medicare
//
//  Created by Mai Hưng on 6/7/18.
//  Copyright © 2018 hungmai. All rights reserved.
//

#import "MedicareManager.h"

@interface MedicareManager ()
@property (strong, nonatomic) NSDictionary *medicareDistrictMap;
@property (strong, nonatomic) NSArray *districts;
@end

@implementation MedicareManager
+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static MedicareManager *shareInstance;
    dispatch_once(&onceToken, ^{
        shareInstance = [MedicareManager new];
    });
    return shareInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _medicareDistrictMap = [self generatePlaces];
        _districts = [self generateDistricts];
    }
    return self;
}

- (NSArray *)generateDistricts {
    return @[QUAN_1,
             QUAN_2,
             QUAN_3,
             QUAN_5,
             QUAN_7,
             QUAN_9,
             QUAN_10,
             QUAN_11,
             QUAN_TAN_BINH,
             QUAN_BINH_THANH,
             QUAN_THU_DUC,
             BINH_DUONG,
             DONG_NAI];
}

- (NSDictionary *)generatePlaces {
    NSMutableDictionary *medicareCityMap = [NSMutableDictionary new];
    
    MedicarePlace *q1 = [[MedicarePlace alloc] initWithDistrict:QUAN_1 address:@"340, Thoại Ngọc Hầu..."];
    MedicarePlace *q2 = [[MedicarePlace alloc] initWithDistrict:QUAN_1 address:@"340, Thoại Ngọc Hầu..."];
    MedicarePlace *q3 = [[MedicarePlace alloc] initWithDistrict:QUAN_1 address:@"340, Thoại Ngọc Hầu..."];
    MedicarePlace *q4 = [[MedicarePlace alloc] initWithDistrict:QUAN_1 address:@"340, Thoại Ngọc Hầu..."];
    MedicarePlace *q5 = [[MedicarePlace alloc] initWithDistrict:QUAN_1 address:@"340, Thoại Ngọc Hầu..."];
    
    [self addPlace:q1 toMap:medicareCityMap];
    [self addPlace:q2 toMap:medicareCityMap];
    [self addPlace:q3 toMap:medicareCityMap];
    [self addPlace:q4 toMap:medicareCityMap];
    [self addPlace:q5 toMap:medicareCityMap];
    
    return medicareCityMap;
}

- (void)addPlace:(MedicarePlace *)medicarePlace toMap:(NSMutableDictionary *)districtMap {
    NSMutableArray *medicarePlaces = districtMap[medicarePlace.district];
    if (!medicarePlaces) {
        medicarePlaces = [NSMutableArray new];
        districtMap[medicarePlace.district] = medicarePlaces;
    }
    [medicarePlaces addObject:medicarePlace];
}

- (NSArray *)getMedicarePlaceAtDistrict:(NSString *)district {
    if (!district) {
        return nil;
    }
    
    return self.medicareDistrictMap[district];
}
@end
