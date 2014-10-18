//
//  CamfindApi.h
//  whatpill
//
//  Created by Claudius Mbemba on 10/18/14.
//  Copyright (c) 2014 Claudius Mbemba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

    //API call completion block with result as json
typedef void (^JSONResponseBlock) (NSDictionary * json);

@interface CamfindApi : AFHTTPSessionManager

+(CamfindApi * ) sharedClient;

    //send an API command to the server
-(void) commandWithParams: (NSMutableDictionary *)params
             onCompletion: (JSONResponseBlock) completionBlock;


@end
