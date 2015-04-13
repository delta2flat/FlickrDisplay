//
//  FKFlickrPhotosetsGetInfo.m
//  FlickrKit
//
//  Generated by FKAPIBuilder on 19 Sep, 2014 at 10:49.
//  Copyright (c) 2013 DevedUp Ltd. All rights reserved. http://www.devedup.com
//
//  DO NOT MODIFY THIS FILE - IT IS MACHINE GENERATED


#import "FKFlickrPhotosetsGetInfo.h" 

@implementation FKFlickrPhotosetsGetInfo



- (BOOL) needsLogin {
    return NO;
}

- (BOOL) needsSigning {
    return NO;
}

- (FKPermission) requiredPerms {
    return -1;
}

- (NSString *) name {
    return @"flickr.photosets.getInfo";
}

- (BOOL) isValid:(NSError **)error {
    BOOL valid = YES;
	NSMutableString *errorDescription = [[NSMutableString alloc] initWithString:@"You are missing required params: "];
	if(!self.photoset_id) {
		valid = NO;
		[errorDescription appendString:@"'photoset_id', "];
	}

	if(error != NULL) {
		if(!valid) {	
			NSDictionary *userInfo = @{NSLocalizedDescriptionKey: errorDescription};
			*error = [NSError errorWithDomain:FKFlickrKitErrorDomain code:FKErrorInvalidArgs userInfo:userInfo];
		}
	}
    return valid;
}

- (NSDictionary *) args {
    NSMutableDictionary *args = [NSMutableDictionary dictionary];
	if(self.photoset_id) {
		[args setValue:self.photoset_id forKey:@"photoset_id"];
	}

    return [args copy];
}

- (NSString *) descriptionForError:(NSInteger)error {
    switch(error) {
		case FKFlickrPhotosetsGetInfoError_PhotosetNotFound:
			return @"Photoset not found";
		case FKFlickrPhotosetsGetInfoError_InvalidAPIKey:
			return @"Invalid API Key";
		case FKFlickrPhotosetsGetInfoError_ServiceCurrentlyUnavailable:
			return @"Service currently unavailable";
		case FKFlickrPhotosetsGetInfoError_WriteOperationFailed:
			return @"Write operation failed";
		case FKFlickrPhotosetsGetInfoError_FormatXXXNotFound:
			return @"Format \"xxx\" not found";
		case FKFlickrPhotosetsGetInfoError_MethodXXXNotFound:
			return @"Method \"xxx\" not found";
		case FKFlickrPhotosetsGetInfoError_InvalidSOAPEnvelope:
			return @"Invalid SOAP envelope";
		case FKFlickrPhotosetsGetInfoError_InvalidXMLRPCMethodCall:
			return @"Invalid XML-RPC Method Call";
		case FKFlickrPhotosetsGetInfoError_BadURLFound:
			return @"Bad URL found";
  
		default:
			return @"Unknown error code";
    }
}

@end
