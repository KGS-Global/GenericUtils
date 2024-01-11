//
//  ExceptionLog.m
//  RequestSynchronizer
//
//  Created by Towhid Islam on 8/25/14.
//  Copyright (c) 2016 KiteGamesStudio Ltd. All rights reserved.
//

#import "CDExceptionLog.h"
#import "LogTracker.h"

@implementation CDExceptionLog

static BOOL DEBUG_MODE_ON = YES;
static BOOL TRACKING_MODE_ON = NO;

+ (LogTracker*) getExceptionTracker{
    
    static LogTracker *_tracker2 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tracker2 = [[LogTracker alloc] initWithPersistenceFileName:@"__log_manager__exception"];
    });
    return _tracker2;
}

+ (void)message:(NSString *)format, ...{
    
    @try {
        va_list args;
        va_start(args, format);
        NSString *fLog = [[NSString alloc] initWithFormat:format arguments:args];
        if (TRACKING_MODE_ON) [[CDExceptionLog getExceptionTracker] addToLogBook:fLog];
        if (DEBUG_MODE_ON) NSLog(@"%@",fLog);
    }
    @catch (NSException *exception) {
        NSLog(@"ExceptionLog %@",[exception reason]);
    }
}

+ (void)message:(NSString *)format args:(va_list)args{
    
    @try {
        NSString *fLog = [[NSString alloc] initWithFormat:format arguments:args];
        if (TRACKING_MODE_ON) [[CDExceptionLog getExceptionTracker] addToLogBook:fLog];
        if (DEBUG_MODE_ON) NSLog(@"%@",fLog);
    }
    @catch (NSException *exception) {
        NSLog(@"Debug %@",[exception reason]);
    }
}

+ (void)save{
    
    [[CDExceptionLog getExceptionTracker] save];
}

+ (void)printSavedLog{
    
    if (DEBUG_MODE_ON) {
        [[CDExceptionLog getExceptionTracker] printSavedLog];
    }
}

//+ (void)sendFeedbackTo:(DNFileUploadRequest *)binary{
//    
//    [[ExceptionLog getExceptionTracker] sendFeedbackTo:binary];
//}

@end
