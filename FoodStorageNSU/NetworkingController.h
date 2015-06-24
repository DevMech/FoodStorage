//
//  NetworkingController.h
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/19/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkingController : NSObject

+ (NetworkingController *)sharedInstance;

- (void)getProductByUPC:(NSString *)upc;
@end
