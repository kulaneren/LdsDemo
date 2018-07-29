//
//  LdsService.h
//  LdsDemo
//
//  Created by eren on 28.07.2018.
//  Copyright © 2018 lds. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum ErrorCode {
    serverError_incorrectUserNameOrPassword=-1003,
    serverError_sessionTimeout=-1017,
    serverError_maximumDeviceCount=-1018,
    
    error_NoHasInternetConnection=3001,
    error_NotReadConfiguration=3002,
    error_NotReadContents=3003,
    error_MenuContentError=3004,
    error_MainPageContentError=3005,
    error_FilterContentError=3006,
    error_UserNameCannotEmpty=3007,
    error_PasswordCannotEmpty=3008,
    error_EmailAddressIsNotCorretFormat=3009,
    error_EmailCannotEmpty=3010,
    error_EntitlementMessageIsEmpty=3011,
    error_ContentCanNotRead=3012,
    error_ForbittenAirplayScreen=3013,
    error_CannotBeginContent=3014,
    error_UnknownError=3015,
    error_CannotWatchContent=3016,
    error_CannotConnectToServer=3017,
    error_InAppPurchaseSetting=3018,
    error_RequireAllField=3019,
    error_InvalidAppleId=3020,
    error_ConnectToAppStore=3021,
    error_PurhaseAccountLead=3022,
    error_PurhaseAccountExpired=3023,
    error_PurhaseAccountCanceled=3024,
    error_PurhaseAccountSuspend=3025,
    error_PurhaseSuccess=3026,
    error_PurhaseAccountExpired_end_date_null=3027,
    error_CannotContainNumericCharacterIntoName=3028,
    error_CannotContainNumericCharacterIntoSurname=3029,
    error_CannotContainNumericCharacterIntoNameSurname=3030,
    
    info_RememberingPasswordSuccess=3100,
    info_AddingFavoriteSuccess=3101,
    info_RemovingFavoriteSuccess=3102,
    info_FragmanIsNotReady=3103,
    
    question_RedirectLogin=3200,
    question_MustUpdate=3201,
    question_CanUpdate=3202,
    question_RedirectWebSite=3203,
    question_NextPart= 3204,
    question_removeFavorite = 3205
    
} ErrorCode;

@interface LdsError : NSError
@property (nonatomic, retain) NSString* action;
@property (nonatomic, retain) NSString* url;
@property (nonatomic, retain) NSString* description;
@property (nonatomic) NSInteger errorCode;

+(LdsError*)errorWithDescription:(NSString*)desc;
+(LdsError*)errorWithDescription:(NSString*)desc withErrorCode:(NSInteger)errCode;
+(LdsError*)errorWithErrorCode:(ErrorCode)errorCode;

+ (void) saveToErrordata:(NSDictionary*)errorData;
@end

typedef void(^FinishBlock)(LdsError *error, id data);

#import "LdsMovie.h"

@interface LdsService : NSObject
@property (nonatomic, assign) NSInteger *totalProcessCount;
-(BOOL)checkInternetConnection;
-(void)getMovie:(NSString *)title success:(void(^)(LdsError *error, NSArray<LdsMovie *> *arryResults))successBlock;


// FireBase i buraya entegre etmek cokta iyi bir fikir gibi gelmedi ama neden olmasin
//-(void)fetchConfigWithDuration:(long)duration success:(void(^)(LdsError *error, NSString *cName))successBlock;

@end
