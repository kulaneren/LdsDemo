//
//  LdsMovie.m
//  LdsDemo
//
//  Created by eren on 29.07.2018.
//  Copyright © 2018 lds. All rights reserved.
//

#import "LdsMovie.h"

@implementation LdsMovie

-(void)parseFromDictionary:(NSDictionary *)dict{
    _title = [dict objectForKey:@"Title"];
    _year = [dict objectForKey:@"Year"];
    _imdbID = [dict objectForKey:@"imdbID"];
    _type = [dict objectForKey:@"Type"];
    _poster = [dict objectForKey:@"Poster"];
}

@end
