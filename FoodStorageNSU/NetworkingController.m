//
//  NetworkingController.m
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/19/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import "NetworkingController.h"

@implementation NetworkingController

+ (NetworkingController *)sharedInstance {
    
    static NetworkingController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkingController alloc] init];
    });
    return sharedInstance;
}

- (void)getProductByUPC:(NSString *)upc {
    
    NSString *URLString = [NSString stringWithFormat:@"https://api.nutritionix.com/v1_1/item?upc=%@&appId=78c55fea&appKey=cd8ce9942548c48a2d84461a2d451b76", upc];
    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
            
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                NSDictionary *item = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                
                NSLog(@"%@", item);
            }else {
                NSLog(@"Request Failed");
            }
        }
    }];
    
    [task resume];
    
    
    
    
}


@end
