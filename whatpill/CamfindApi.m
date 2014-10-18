//
//  CamfindApi.m
//  whatpill
//
//  Created by Claudius Mbemba on 10/18/14.
//  Copyright (c) 2014 Claudius Mbemba. All rights reserved.
//


#import "CamfindApi.h"

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


-(void) commandWithParams:(NSMutableDictionary *)params onCompletion:(JSONResponseBlock)completionBlock
{

    NSData * uploadfile = nil;
    
    if ([params objectForKey:@"image_request[image]"]) {
        uploadfile = (NSData *)[params objectForKey:@"image_request[image]"];
        [params removeObjectForKey:@"image_request[image]"];
    }

    NSURL *baseURL = [NSURL URLWithString:host];
    
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc]initWithBaseURL:baseURL];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager.requestSerializer setValue:@"EzqC4zIoYrmshqcchE6zPHxqpgx9p1LP5iNjsnqHSHy8QUUDRl" forHTTPHeaderField:@"X-Mashape-Key"];
    
    
    [manager POST:@"" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if(uploadfile){
            [formData appendPartWithFileData:uploadfile name:@"image_request[image]" fileName:@"pill.jpg" mimeType:@"image/jpeg"];
        }
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"Success: %@", responseObject);
        
        completionBlock(responseObject);
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"Success: %@", [error localizedDescription]);
        
        completionBlock([NSDictionary dictionaryWithObject:[error localizedDescription] forKey:@"error"]);
    }];
}

//-(NSData *response) apiCall
//{
//    
//    NSURL *urlimage_request[image] = [NSURL URLWithString:@"tylenol.jpeg"];
//    
//    NSDictionary *headers = @{@"X-Mashape-Key": @"EzqC4zIoYrmshqcchE6zPHxqpgx9p1LP5iNjsnqHSHy8QUUDRl"};
//    
//    NSDictionary *parameters = @{@"focus[x]": @"480", @"focus[y]": @"640", @"image_request[altitude]": @"27.912109375", @"image_request[image]": urlimage_request[image], @"image_request[language]": @"en", @"image_request[latitude]": @"35.8714220766008", @"image_request[locale]": @"en_US", @"image_request[longitude]": @"14.3583203002251", @"image_request[remote_image_url]": @"http://upload.wikimedia.org/wikipedia/en/2/2d/Mashape_logo.png"};
//    
//    UNIUrlConnection *asyncConnection = [[UNIRest post:^(UNISimpleRequest *request) {
//        [request setUrl:@"https://camfind.p.mashape.com/image_requests"];
//        [request setHeaders:headers];
//        [request setParameters:parameters];
//    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
//        NSInteger code = response.code;
//        NSDictionary *responseHeaders = response.headers;
//        UNIJsonNode *body = response.body;
//        NSData *rawBody = response.rawBody;
//    }];
//    
//}
@end
