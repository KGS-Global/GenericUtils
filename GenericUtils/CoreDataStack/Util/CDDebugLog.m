//
//  Debug.m
//  RequestSynchronizer
//
//  Created by Towhid Islam on 7/27/14.
//  Copyright (c) 2016 KiteGamesStudio Ltd. All rights reserved.
//

#import "CDDebugLog.h"
#import "LogTracker.h"

@implementation CDDebugLog

static BOOL DEBUG_MODE_ON = YES;
static BOOL TRACKING_MODE_ON = NO;

+ (LogTracker*) getTracker{
    
    static LogTracker *_tracker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tracker = [[LogTracker alloc] initWithPersistenceFileName:@"__log_manager__data"];
    });
    return _tracker;
}

+ (BOOL)isDebugModeOn{
    return DEBUG_MODE_ON;
}

+ (void)setDebugModeOn:(BOOL)on{
    DEBUG_MODE_ON = on;
    [LogTracker setDebugModeOn:on];
}

+ (void)setTrackingModeOn:(BOOL)on{
    TRACKING_MODE_ON = on;
}

+ (void)message:(NSString *)format, ...{
    
    @try {
        va_list args;
        va_start(args, format);
        NSString *fLog = [[NSString alloc] initWithFormat:format arguments:args];
        if (TRACKING_MODE_ON) [[CDDebugLog getTracker] addToLogBook:fLog];
        if (DEBUG_MODE_ON) NSLog(@"%@",fLog);
    }
    @catch (NSException *exception) {
        NSLog(@"Debug %@",[exception reason]);
    }
}

+ (void)message:(NSString *)format args:(va_list)args{
    
    @try {
        NSString *fLog = [[NSString alloc] initWithFormat:format arguments:args];
        if (TRACKING_MODE_ON) [[CDDebugLog getTracker] addToLogBook:fLog];
        if (DEBUG_MODE_ON) NSLog(@"%@",fLog);
    }
    @catch (NSException *exception) {
        NSLog(@"Debug %@",[exception reason]);
    }
}

+ (void)save{
    
    [[CDDebugLog getTracker] save];
}

+ (void)printSavedLog{
    
    if (DEBUG_MODE_ON) {
        [[CDDebugLog getTracker] printSavedLog];
    }
}

//+ (void)sendFeedbackTo:(DNFileUploadRequest *)binary{
//    
//    [[DebugLog getTracker] sendFeedbackTo:binary];
//}

@end
