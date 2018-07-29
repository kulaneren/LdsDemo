//
//  BaseViewController.h
//  LdsDemo
//
//  Created by eren on 29.07.2018.
//  Copyright © 2018 lds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
-(void)showIndicator;
-(void)dismissIndicator;
-(void)showAlertView:(NSString *)alertText;
-(void)showAlertViewWithRefreshPageAction:(NSString *)alertText;
-(void)refreshScreenForError;

@end
