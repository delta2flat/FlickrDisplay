//
//  ViewController.m
//  FlickrDisplay
//
//  Created by Corbin Miller on 4/10/15.
//  Copyright (c) 2015 Corbin Miller. All rights reserved.
//

#import "ViewController.h"
#import "FlickrKit.h"
#import "FKAuthViewController.h"
#import "FKPhotosViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@property (nonatomic, retain) FKDUNetworkOperation *completeAuthOp;
@property (nonatomic, retain) FKFlickrNetworkOperation *myPhotostreamOp;
@property (nonatomic, retain) NSString *userID;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[FlickrKit sharedFlickrKit] initializeWithAPIKey:@"8f4b2a420266b1ef2210067c482016fa" sharedSecret:@"83be6519e3ab4781"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userAuthenticateCallback:) name:@"UserAuthCallbackNotification" object:nil];
    
    self.showButton.enabled = NO;
    
    // draw borders
    [[self.authButton layer] setBorderWidth:1.0f];
    [[self.authButton layer] setCornerRadius:4.0f];
    [[self.authButton layer] setBorderColor:[UIColor blueColor].CGColor];
    [[self.showButton layer] setBorderWidth:1.0f];
    [[self.showButton layer] setCornerRadius:4.0f];
    [[self.showButton layer] setBorderColor:[UIColor grayColor].CGColor];
}

#pragma mark - Auth Actions

- (void) userLoggedIn:(NSString *)username userID:(NSString *)userID {
    self.userID = userID;
    [self.authButton setTitle:@"LOGOUT" forState:UIControlStateNormal];
    self.navigationItem.title = [NSString stringWithFormat:@"You are logged in as %@", username];
}

- (void) userLoggedOut {
    [self.authButton setTitle:@"LOGIN..." forState:UIControlStateNormal];
    self.navigationItem.title = @"Please Login to Flickr";
}

#pragma mark - Auth Callback

- (void) userAuthenticateCallback:(NSNotification *)notification {
    NSURL *callbackURL = notification.object;
    self.completeAuthOp = [[FlickrKit sharedFlickrKit] completeAuthWithURL:callbackURL completion:^(NSString *userName, NSString *userId, NSString *fullName, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                [self userLoggedIn:userName userID:userId];
                self.showButton.enabled = YES;
            } else {
                self.showButton.enabled = NO;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }];
}

#pragma mark - User Actions

-(IBAction) authButtonPressed:(id)sender {
    if ([FlickrKit sharedFlickrKit].isAuthorized) {
        [[FlickrKit sharedFlickrKit] logout];
        [self userLoggedOut];
    }
    else {
        FKAuthViewController *authView = [[FKAuthViewController alloc] init];
        [self.navigationController pushViewController:authView animated:YES];
    }	
}


-(IBAction) showButtonPressed:(id)sender {
    if ([FlickrKit sharedFlickrKit].isAuthorized) {
        if ([FlickrKit sharedFlickrKit].isAuthorized) {
            /*
             Example using the string/dictionary method of using flickr kit
             */
            self.myPhotostreamOp = [[FlickrKit sharedFlickrKit] call:@"flickr.photos.search" args:@{@"user_id": self.userID, @"per_page": @"15"} maxCacheAge:FKDUMaxAgeNeverCache completion:^(NSDictionary *response, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (response) {
                        NSMutableArray *photoURLs = [NSMutableArray array];
                        for (NSDictionary *photoDictionary in [response valueForKeyPath:@"photos.photo"]) {
                            NSURL *url = [[FlickrKit sharedFlickrKit] photoURLForSize:FKPhotoSizeSmall240 fromPhotoDictionary:photoDictionary];
                            [photoURLs addObject:url];
                        }
                        
                        FKPhotosViewController *fivePhotos = [[FKPhotosViewController alloc] initWithURLArray:photoURLs];
                        [self.navigationController pushViewController:fivePhotos animated:YES];
                        
                    } else {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [alert show];
                    }
                });			
            }];		
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please login first" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }

    }
}

@end
