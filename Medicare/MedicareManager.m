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
        _KAOProducts = [self generateKAOProducts];
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
    
    MedicarePlace *q1 = [[MedicarePlace alloc] initWithDistrict:QUAN_1 address:@"254 Bis Trần Hưng Đạo, P.Nguyễn Cư Trinh, Q.1"];
    MedicarePlace *q2 = [[MedicarePlace alloc] initWithDistrict:QUAN_1 address:@"79 Trần Khắc Chân, P.Tân Bình, Q.1"];
    MedicarePlace *q3 = [[MedicarePlace alloc] initWithDistrict:QUAN_2 address:@"720K Thảo Điền, P.Thảo Điền, Q.2"];
    MedicarePlace *q4 = [[MedicarePlace alloc] initWithDistrict:QUAN_2 address:@"70 Trần Não, P.Bình An, Q.2"];
    MedicarePlace *q5 = [[MedicarePlace alloc] initWithDistrict:QUAN_3 address:@"Shop F1-03, tầng trệt, Nguyễn Kim Cao Thắng.\nSố19 Cao Thắng, P.2, Q.3"];
    
    [self addPlace:q1 toMap:medicareCityMap];
    [self addPlace:q2 toMap:medicareCityMap];
    [self addPlace:q3 toMap:medicareCityMap];
    [self addPlace:q4 toMap:medicareCityMap];
    [self addPlace:q5 toMap:medicareCityMap];
    
    return medicareCityMap;
}

- (NSArray *)generateKAOProducts {
    NSMutableArray *kaoProducts = [NSMutableArray new];
    
    KaoProduct *sp1 = [[KaoProduct alloc] initWithId: @"1" name:@"Biore" image:nil];
    KaoProduct *sp2 = [[KaoProduct alloc] initWithId: @"2" name:@"Biore2" image:nil];
    KaoProduct *sp3 = [[KaoProduct alloc] initWithId: @"3" name:@"Biore3" image:nil];
    KaoProduct *sp4 = [[KaoProduct alloc] initWithId: @"4" name:@"Biore4" image:nil];
    KaoProduct *sp5 = [[KaoProduct alloc] initWithId: @"5" name:@"Biore5" image:nil];
    
    [kaoProducts addObject:sp1];
    [kaoProducts addObject:sp2];
    [kaoProducts addObject:sp3];
    [kaoProducts addObject:sp4];
    [kaoProducts addObject:sp5];
    return kaoProducts;
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

- (NSArray *)getKAOProductsOfMedicarePlace:(MedicarePlace *)medicarePlace {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *kaoProducts = [userDefault valueForKey:medicarePlace.address];
    return kaoProducts;
}

- (void)saveKAOProduct:(KaoProduct *)product toMedicarePlace:(MedicarePlace *)medicarePlace {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *kaoProducts = [[userDefault valueForKey:medicarePlace.address] mutableCopy];
    if (!kaoProducts) {
        kaoProducts = [NSMutableArray new];
    }
    [kaoProducts addObject:product._id];
    [userDefault setValue:kaoProducts forKey:medicarePlace.address];
    [userDefault synchronize];
}

- (void)clearKAOProduct:(KaoProduct *)product atMedicarePlace:(MedicarePlace *)medicarePlace {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *kaoProducts = [[userDefault valueForKey:medicarePlace.address] mutableCopy];
    if (kaoProducts && [kaoProducts containsObject:product._id]) {
        [kaoProducts removeObject:product._id];
        [userDefault setValue:kaoProducts forKey:medicarePlace.address];
        [userDefault synchronize];
    }
}

- (void)clearKAOProductsAtPlace:(MedicarePlace *)medicarePlace {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:medicarePlace.address];
    [userDefault synchronize];
}

- (void)clearAllKAOProducts {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    for (NSString *district in self.districts) {
        NSArray *medicarePlaces = [self getMedicarePlaceAtDistrict:district];
        for (MedicarePlace *medicarePlace in medicarePlaces) {
            [userDefault removeObjectForKey:medicarePlace.address];
        }
    }
    [userDefault synchronize];
}
@end
