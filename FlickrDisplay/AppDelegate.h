//
//  AppDelegate.h
//  FlickrDisplay
//
//  Created by Corbin Miller on 4/10/15.
//  Copyright (c) 2015 Corbin Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTableViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, weak) MyTableViewController *myTableViewController;
@property (nonatomic, retain) IBOutlet UIWindow *window;


@end

