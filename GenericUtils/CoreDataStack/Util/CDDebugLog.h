//
//  Debug.h
//  RequestSynchronizer
//
//  Created by Towhid Islam on 7/27/14.
//  Copyright (c) 2016 KiteGamesStudio Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DNFileUploadRequest;

@interface CDDebugLog : NSObject
+ (BOOL) isDebugModeOn;
+ (void) setDebugModeOn:(BOOL)on;
+ (void) setTrackingModeOn:(BOOL)on;
+ (void) message:(NSString*)format, ...;
+ (void) message:(NSString *)format args:(va_list)args;
+ (void) save;
+ (void) printSavedLog;
//+ (void) sendFeedbackTo:(DNFileUploadRequest*)binary;
@end
