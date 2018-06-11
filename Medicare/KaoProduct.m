//
//  KaoProduct.m
//  Medicare
//
//  Created by Mai Hưng on 6/7/18.
//  Copyright © 2018 hungmai. All rights reserved.
//

#import "KaoProduct.h"

@implementation KaoProduct
-(instancetype)initWithName:(NSString *)name image:(NSString *)imagePath {
    if (self = [super init]) {
        _name = name;
        _imageURL = imagePath;
    }
    return self;
}

- (instancetype)initWithId:(NSString *)_id name:(NSString *)name image:(NSString *)imagePath {
    if (self = [super init]) {
        __id = _id;
        _name = name;
        _imageURL = imagePath;
    }
    return self;
}
@end
