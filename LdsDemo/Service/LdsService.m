//
//  LdsService.m
//  LdsDemo
//
//  Created by eren on 28.07.2018.
//  Copyright © 2018 lds. All rights reserved.
//

#import "LdsService.h"
#import "Reachability.h"

@implementation LdsService
@synthesize totalProcessCount;

-(BOOL)checkInternetConnection {
    totalProcessCount++;
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    return networkStatus != NotReachable;
}

-(void)sendServiceResponse:(LdsError*)error withData:(id)data withFinishBlock:(FinishBlock)block {
    totalProcessCount--;
    if (block) {
        dispatch_async(dispatch_get_main_queue(), ^{
            block(error, data);
        });
    }
}

-(void)uncatchedErrorHandling:(NSError*)error withFinishBlock:(FinishBlock)block {
    if (error) {//Error Domain  NSURLErrorDomain
        if ([error.domain isEqualToString:NSURLErrorDomain] || [error.domain isEqualToString:NSCocoaErrorDomain]) {
            LdsError* err;
            
            if (error.code == 3840)
                err = [LdsError errorWithErrorCode:error_ContentCanNotRead];
            else
                err = [LdsError errorWithErrorCode:error_CannotConnectToServer];
            
            [self sendServiceResponse:err withData:nil withFinishBlock:block];
            return;
        } else {
            [self sendServiceResponse:[LdsError errorWithErrorCode:error_UnknownError] withData:nil withFinishBlock:block];
            return;
        }
    }
}
-(NSMutableURLRequest*)createRequest:(NSString*)url {
    NSURL *requestUrl = [NSURL URLWithString:[url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:requestUrl];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"GET";
    
    return request;
}

-(void)getMovie:(NSString *)title success:(void(^)(LdsError *error, NSArray<LdsMovie *> *arryResults))successBlock{
    if (![self checkInternetConnection]) {
        [self sendServiceResponse:[LdsError errorWithErrorCode:error_NoHasInternetConnection]
                         withData:nil withFinishBlock:successBlock];
        return;
    }
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",URL_OMDB_API,title];
    NSMutableURLRequest * request = [self createRequest:strUrl];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!data) {
            [self uncatchedErrorHandling:error withFinishBlock:successBlock];
            return;
        } else {
            NSData *resData = data;
            if (resData && resData.length > 0) {
                NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:resData options:0 error:nil];
                NSString *resp = [dictData objectForKey:@"Response"];
                
                if ([resp isEqualToString:@"True"]) {
                    NSDictionary *dictMovies = [dictData objectForKey:@"Search"];
                    if (dictMovies) {
                        NSMutableArray *arryMovies = [NSMutableArray new];
                        for (NSDictionary *dict in dictMovies) {
                            LdsMovie *movie = [LdsMovie new];
                            [movie parseFromDictionary:dict];
                            [arryMovies addObject:movie];
                          
                        }
                        NSArray *arryReturnMovies = [NSArray arrayWithArray:arryMovies];
                        [self sendServiceResponse:nil withData:arryReturnMovies withFinishBlock:successBlock];
                        return;
                    }
                }
                NSString * errorText = NO_RESULT;
                [self sendServiceResponse:[LdsError errorWithDescription:errorText] withData:nil withFinishBlock:successBlock];
            }
        }
    }];
}





-(void)fetchConfigWithDuration:(long)duration success:(void(^)(LdsError *error, NSString *cName))successBlock{
    
    if (![self checkInternetConnection]) {
        [self sendServiceResponse:[LdsError errorWithErrorCode:error_NoHasInternetConnection]
                         withData:nil withFinishBlock:successBlock];
        return;
    }
}


@end
