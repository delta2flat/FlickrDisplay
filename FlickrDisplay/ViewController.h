//
//  ViewController.h
//  FlickrDisplay
//
//  Created by Corbin Miller on 4/10/15.
//  Copyright (c) 2015 Corbin Miller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *authButton;
@property (weak, nonatomic) IBOutlet UIButton *showButton;
@property (weak, nonatomic) IBOutlet UILabel *authLabel;

- (IBAction)authButtonPressed:(id)sender;
- (IBAction)showButtonPressed:(id)sender;

@end

