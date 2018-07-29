//
//  MovieDetailViewController.h
//  LdsDemo
//
//  Created by eren on 29.07.2018.
//  Copyright © 2018 lds. All rights reserved.
//

#import "BaseViewController.h"
#import "LdsMovie.h"

@interface MovieDetailViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblType;
@property (weak, nonatomic) IBOutlet UILabel *lblYear;
@property (weak, nonatomic) IBOutlet UIImageView *imgPoster;

@property (strong, nonatomic) LdsMovie *movie;

@end
