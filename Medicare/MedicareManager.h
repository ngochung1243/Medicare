//
//  MedicareManager.h
//  Medicare
//
//  Created by Mai Hưng on 6/7/18.
//  Copyright © 2018 hungmai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MedicarePlace.h"

#define shareMedicareManager [MedicareManager shareManager]

@interface MedicareManager : NSObject
@property (strong, nonatomic) NSArray *districts;

+ (instancetype)shareManager;
- (NSArray *)getMedicarePlaceAtDistrict:(NSString *)district;
@end
