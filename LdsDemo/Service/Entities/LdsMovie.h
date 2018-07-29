//
//  LdsMovie.h
//  LdsDemo
//
//  Created by eren on 29.07.2018.
//  Copyright © 2018 lds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LdsMovie : NSObject
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* year;
@property (strong, nonatomic) NSString* imdbID;
@property (strong, nonatomic) NSString* type;
@property (strong, nonatomic) NSString* poster;

-(void)parseFromDictionary:(NSDictionary *)dict;

@end
