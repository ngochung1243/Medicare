//
//  KaoProduct.h
//  Medicare
//
//  Created by Mai Hưng on 6/7/18.
//  Copyright © 2018 hungmai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KaoProduct : NSObject
@property (strong, nonatomic) NSString *_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *imageURL;

- (instancetype)initWithId:(NSString *)_id name:(NSString *)name image:(NSString *)imagePath;
@end
