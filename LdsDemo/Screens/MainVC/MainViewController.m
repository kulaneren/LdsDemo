//
//  MainViewController.m
//  LdsDemo
//
//  Created by eren on 29.07.2018.
//  Copyright © 2018 lds. All rights reserved.
//

#import "MainViewController.h"
#import "LdsMovie.h"
#import "LdsService.h"
#import "MovieDetailViewController.h"

@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (nonatomic, strong) NSArray<LdsMovie *>* arryMovies;
@end

@implementation MainViewController{
    
}

static NSString *simpleTableIdentifier = @"SimpleTableItem";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initItems];
}

-(void)initItems{
    _tblMovies.delegate= self;
    _tblMovies.dataSource = self;

    _sbSearch.delegate = self;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arryMovies.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    LdsMovie *movie = [_arryMovies objectAtIndex:indexPath.row];
    cell.textLabel.text = movie.title;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MovieDetailViewController *vc = [sb instantiateViewControllerWithIdentifier:@"MovieDetailViewController"];
    LdsMovie *movie = [_arryMovies objectAtIndex:indexPath.row];
    vc.movie = movie;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    NSLog(@"Search Clicked");
    [self showIndicator];
    LdsService *service = [LdsService new];
    
    [service getMovie:searchBar.text success:^(LdsError *error, NSArray<LdsMovie *> *arryResults) {
        if (error) {
            [self showAlertView:error.description];
        }else{
            self->_arryMovies = arryResults; //[NSArray arrayWithArray:arryPassengers];
            if (self->_arryMovies && self->_arryMovies.count >0) {
                [self->_tblMovies reloadData];
            }
        }
        [self dismissIndicator];
    }];
}




@end
