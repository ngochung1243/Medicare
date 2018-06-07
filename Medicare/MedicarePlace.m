//
//  MedicarePlace.m
//  Medicare
//
//  Created by Mai Hưng on 6/7/18.
//  Copyright © 2018 hungmai. All rights reserved.
//

#import "MedicarePlace.h"

@implementation MedicarePlace
- (instancetype)initWithDistrict:(NSString *)district address:(NSString *)address {
    if (self = [super init]) {
        _district = district;
        _address = address;
    }
    return self;
}
@end
