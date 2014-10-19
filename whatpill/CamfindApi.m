    //
    //  CamfindApi.m
    //  whatpill
    //
    //  Created by Claudius Mbemba on 10/18/14.
    //  Copyright (c) 2014 Claudius Mbemba. All rights reserved.
    //


#import "CamfindApi.h"
#import <UNIRest.h>

#define host @"https://camfind.p.mashape.com/image_requests"

@implementation CamfindApi


+ (CamfindApi *) sharedClient
{
    static CamfindApi * _sharedClient =nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate,
                  ^{_sharedClient = [[self alloc]initWithBaseURL:[NSURL URLWithString:host]];
                      
                  });
    return _sharedClient;
    
    
}

- (CamfindApi *) init{
    self = [super init];
    
    if(self != nil){
        
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}


-(void) withId:(NSString *) call optionalStr:(NSString *) oStr onCompletion:(JSONResponseBlock)completionBlock
{
    
        //    NSData * uploadfile = nil;
        //
        //    if ([params objectForKey:@"image_request[image]"]) {
        //        uploadfile = (NSData *)[params objectForKey:@"image_request[image]"];
        //        [params removeObjectForKey:@"image_request[image]"];
        //    }
        //
        //    NSURL *baseURL = [NSURL URLWithString:host];
        //
        //    NSLog(@"BaseURL: %@", baseURL);
        //
        //    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc]initWithBaseURL:baseURL];
        //
        //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //
        //    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        //    securityPolicy.allowInvalidCertificates = YES;
        //    manager.securityPolicy = securityPolicy;
        //
        //    [manager.requestSerializer setValue:@"EzqC4zIoYrmshqcchE6zPHxqpgx9p1LP5iNjsnqHSHy8QUUDRl" forHTTPHeaderField:@"X-Mashape-Key"];
        //    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
        //
        //
        //    [manager POST:@""
        //       parameters:params
        //constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //
        //    if(uploadfile){
        //        [formData appendPartWithFileData:uploadfile name:@"image_request[image]" fileName:@"pill.jpg" mimeType:@"image/jpeg"];
        //    }
        //
        //} success:^(NSURLSessionDataTask *task, id responseObject) {
        //
        //    NSLog(@"Success: %@", responseObject);
        //
        //    completionBlock(responseObject);
        //
        //
        //} failure:^(NSURLSessionDataTask *task, NSError *error) {
        //
        //    NSLog(@"Failure: %@", [error localizedDescription]);
        //
        //    completionBlock([NSDictionary dictionaryWithObject:[error localizedDescription] forKey:@"error"]);
        //}];
    
    if([call isEqualToString:@"getToken"]){
        
        NSDictionary *headers = @{@"X-Mashape-Key": @"EzqC4zIoYrmshqcchE6zPHxqpgx9p1LP5iNjsnqHSHy8QUUDRl"};
        NSDictionary *parameters = @{ @"image_request[locale]": @"en_US",@"image_request[remote_image_url]": @"http://i.walmartimages.com/i/p/00/30/04/50/29/0030045029512_500X500.jpg"};
        
        UNIUrlConnection *asyncConnection = [[UNIRest post:^(UNISimpleRequest *request) {
            [request setUrl:host];
            [request setHeaders:headers];
            [request setParameters:parameters];
        }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {

            UNIJsonNode *body = response.body;
            
            NSDictionary * dict;
            if(!body.isArray){
                dict = body.JSONObject;
                
            }else{
                NSArray * arr = body.JSONArray;
                NSLog(@"Error, expected NSDictionary but got Array: %@", arr);
                
            }
            
            NSLog(@"TOKEN: %@", dict);
            
            completionBlock(dict);
            
        }];
        
    }else if([call isEqualToString:@"getName"]){
        
        
        NSString * str = [NSString stringWithFormat:@"https://camfind.p.mashape.com/image_responses/%@",oStr];
        
        NSLog(@"String 1: %@", str);
        
        NSDictionary *headers = @{@"X-Mashape-Key": @"EzqC4zIoYrmshqcchE6zPHxqpgx9p1LP5iNjsnqHSHy8QUUDRl"};
        
        UNIUrlConnection *asyncConnection = [[UNIRest get:^(UNISimpleRequest *request) {
            [request setUrl:str];
            [request setHeaders:headers];
        }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {

            UNIJsonNode *body = response.body;
            
            NSDictionary * dict;
            if(!body.isArray){
                dict = body.JSONObject;
                
            }else{
                NSArray * arr = body.JSONArray;
                NSLog(@"Error, expected NSDictionary but got Array: %@", arr);
                
            }
            
            NSLog(@"NAME: %@", dict);
            
            completionBlock(dict);
            
        }];
        
    }else{
        
        
        NSString * str = [NSString stringWithFormat:@"http://104.131.92.64/drugs/%@", oStr];
        
        NSLog(@"String 2: %@", str);
        
        UNIUrlConnection *asyncConnection = [[UNIRest get:^(UNISimpleRequest *request) {
            [request setUrl:str];
        }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
            
            UNIJsonNode *body = response.body;
            
            NSDictionary * dict;
            if(!body.isArray){
                dict = body.JSONObject;
                
            }else{
                NSArray * arr = body.JSONArray;
                NSLog(@"Error, expected NSDictionary but got Array: %@", arr);
                
            }
            
            NSLog(@"RESULT: %@", dict);
            completionBlock(dict);
            
        }];

        
        
    }
    
}

@end
