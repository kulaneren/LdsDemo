//
//  SplashViewController.m
//  LdsDemo
//
//  Created by eren on 29.07.2018.
//  Copyright © 2018 lds. All rights reserved.
//

#import "SplashViewController.h"
#import "LdsService.h"
#import "AppDelegate.h"
#import "MainViewController.h"
@import Firebase;

@interface SplashViewController ()
@property (nonatomic, strong) FIRRemoteConfig *remoteConfig;
@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initFB];
//    [self fetchConfig];
   
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // it is here because in viewDidLoad keywindow not reachable
    [self fetchConfig];
}

-(void)initFB{
    [_lblName setText:@""];
    [FIRApp configure];
    self.remoteConfig = [FIRRemoteConfig remoteConfig];
    FIRRemoteConfigSettings *remoteConfigSettings = [[FIRRemoteConfigSettings alloc] initWithDeveloperModeEnabled:YES];
    self.remoteConfig.configSettings = remoteConfigSettings;
    // use for default config for prod
    //    [self.remoteConfig setDefaultsFromPlistFileName:@"RemoteConfigDefaults"];
    
}

-(void)fetchConfig{
    [self showIndicator];
    
    LdsService *service = [LdsService new];
    
    BOOL connection =  [service checkInternetConnection];
    if (connection) {
        long expirationDuration = 3600;
        [self.remoteConfig fetchWithExpirationDuration:expirationDuration completionHandler:^(FIRRemoteConfigFetchStatus status, NSError *error) {
            
            if (status == FIRRemoteConfigFetchStatusSuccess) {
                NSLog(@"Config fetched!");
                [self.remoteConfig activateFetched];
            } else {
                NSLog(@"Config not fetched");
                NSLog(@"Error %@", error.localizedDescription);
            }
            NSString *welcomeMessage = self.remoteConfig[@"name"].stringValue;
            if (welcomeMessage) {
                if ([welcomeMessage isEqualToString:@""] || [welcomeMessage isEqualToString:@" "]) {
                    NSLog(@"sikinti");
                }else{
                    [self->_lblName setText:welcomeMessage];
                    [NSTimer scheduledTimerWithTimeInterval:3.0
                                                     target:self
                                                   selector:@selector(goToMainPage)
                                                   userInfo:nil
                                                    repeats:NO];
                }
            }
            [self dismissIndicator];
        }];
    }else{
        [self showAlertViewWithRefreshPageAction:NO_CONNECTION];
        [self dismissIndicator];
    }
}

-(void)refreshScreenForError{
    [super refreshScreenForError];
    [self fetchConfig];
}

-(void)goToMainPage{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainViewController *vc = [sb instantiateViewControllerWithIdentifier:@"MainViewController"];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:vc];
    APP_DELEGATE.window.rootViewController = navController;
    [APP_DELEGATE.window makeKeyAndVisible];
}
@end
