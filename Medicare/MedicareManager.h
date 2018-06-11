//
//  MedicareManager.h
//  Medicare
//
//  Created by Mai Hưng on 6/7/18.
//  Copyright © 2018 hungmai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MedicarePlace.h"
#import "KaoProduct.h"

#define shareMedicareManager [MedicareManager shareManager]

@interface MedicareManager : NSObject
@property (strong, nonatomic) NSArray *districts;
@property (strong, nonatomic) NSArray *KAOProducts;

+ (instancetype)shareManager;
- (NSArray *)getMedicarePlaceAtDistrict:(NSString *)district;
- (NSArray *)getKAOProductsOfMedicarePlace:(MedicarePlace *)medicarePlace;
- (void)saveKAOProduct:(KaoProduct *)product toMedicarePlace:(MedicarePlace *)medicarePlace;
- (void)clearKAOProduct:(KaoProduct *)product atMedicarePlace:(MedicarePlace *)medicarePlace;
- (void)clearKAOProductsAtPlace:(MedicarePlace *)medicarePlace;
- (void)clearAllKAOProducts;

@end
