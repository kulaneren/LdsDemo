//
//  MovieDetailViewController.m
//  LdsDemo
//
//  Created by eren on 29.07.2018.
//  Copyright © 2018 lds. All rights reserved.
//

#import "MovieDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@import Firebase;

@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initItems];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [FIRAnalytics logEventWithName:kFIREventSelectContent
                        parameters:@{
                                     kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", self.lblTitle.text],
                                     kFIRParameterItemName:self.lblTitle.text,
                                     kFIRParameterContentType:@"movieDetailPage"
                                     }];
}

-(void)initItems{
    _lblTitle.text = _movie.title;
    _lblType.text = _movie.type;
    _lblYear.text = _movie.year;
    
    [_imgPoster sd_setImageWithURL:[NSURL URLWithString:_movie.poster] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            NSLog(@"sdWebImageError : %@", error.description);
        }else{
            self->_imgPoster.image = image;
        }
    }];
}

@end
