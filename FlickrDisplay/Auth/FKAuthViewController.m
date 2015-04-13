//
//  FKAuthViewController.m
//  FlickrDisplay
//
//  Created by Corbin Miller on 4/10/15.
//  Copyright (c) 2015 Corbin Miller. All rights reserved.
//


#import "FKAuthViewController.h"
#import "FlickrKit.h"

@interface FKAuthViewController ()

@property (nonatomic, retain) FKDUNetworkOperation *authOp;

@end


@implementation FKAuthViewController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
	NSString *callbackURLString = @"flickrdisplay://auth";
	
	// Begin the authentication process
	self.authOp = [[FlickrKit sharedFlickrKit] beginAuthWithCallbackURL:[NSURL URLWithString:callbackURLString] permission:FKPermissionDelete completion:^(NSURL *flickrLoginPageURL, NSError *error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			if (!error) {
				NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:flickrLoginPageURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];			
				[self.webView loadRequest:urlRequest];
			} else {			
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
				[alert show];
			}
        });		
	}];
}

- (void) viewWillDisappear:(BOOL)animated {
    [self.authOp cancel];
    [super viewWillDisappear:animated];
}

#pragma mark - Web View

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //If they click NO DONT AUTHORIZE, this is where it takes you by default...
	
    NSURL *url = [request URL];
    
	// If it's the callback url, then lets trigger that
    if (![url.scheme isEqual:@"http"] && ![url.scheme isEqual:@"https"]) {
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            [[UIApplication sharedApplication]openURL:url];
            return NO;
        }
    }
    
    return YES;
	
}

@end
