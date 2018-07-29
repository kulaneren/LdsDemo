//
//  BaseViewController.m
//  LdsDemo
//
//  Created by eren on 29.07.2018.
//  Copyright © 2018 lds. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController{
    UIView *viewIndicatorBackground;
    UIActivityIndicatorView *activityIndicator ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    viewIndicatorBackground = [[UIView alloc] init];
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
}

-(void)showIndicator {
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    CGRect indiFrame = [UIScreen mainScreen].bounds;
    if (self.view.frame.size.width > self.view.frame.size.height) {
        indiFrame.size.height = indiFrame.size.width;
        indiFrame.size.width = self.view.frame.size.height;
    }
    [viewIndicatorBackground setFrame:indiFrame];
    [viewIndicatorBackground setBackgroundColor:[UIColor blackColor]];
    [viewIndicatorBackground setAlpha:0.6];
    viewIndicatorBackground.layer.zPosition = NSIntegerMax;
    
    activityIndicator.alpha = 1;
    [viewIndicatorBackground addSubview:activityIndicator];
    activityIndicator.center = CGPointMake(indiFrame.size.width/2, indiFrame.size.height/2);
    if ([UIApplication sharedApplication].keyWindow) {
        [[UIApplication sharedApplication].keyWindow addSubview:viewIndicatorBackground];
    }else{
        [[[[UIApplication sharedApplication] delegate] window] addSubview:viewIndicatorBackground];
    }
    
    [activityIndicator startAnimating];
}

-(void)dismissIndicator {
    [activityIndicator stopAnimating];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    [viewIndicatorBackground removeFromSuperview];
}

-(void)showAlertView:(NSString *)alertText {
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"routewix" message:alertText delegate:nil cancelButtonTitle:@"Tamam" otherButtonTitles:nil];
    //    [alert show];
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:COMPANY_NAME
                                 message:alertText
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:OK
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle your yes please button action here
                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                   
                               }];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)showAlertViewWithRefreshPageAction:(NSString *)alertText{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:COMPANY_NAME
                                 message:alertText
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:OK
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle your yes please button action here
                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                   [self dismissViewControllerAnimated:YES completion:nil];
                               }];
    
    UIAlertAction* refreshButton = [UIAlertAction
                                    actionWithTitle:REFRESH
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                        [self dismissViewControllerAnimated:YES completion:nil];
                                        [self refreshScreenForError];
                                    }];
    [alert addAction:okButton];
    [alert addAction:refreshButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)refreshScreenForError{
    NSLog(@"refresh in  base");
}

@end
