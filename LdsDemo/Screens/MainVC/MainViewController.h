//
//  MainViewController.h
//  LdsDemo
//
//  Created by eren on 29.07.2018.
//  Copyright © 2018 lds. All rights reserved.
//

#import "BaseViewController.h"

@interface MainViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UISearchBar *sbSearch;

@property (weak, nonatomic) IBOutlet UITableView *tblMovies;
@end
