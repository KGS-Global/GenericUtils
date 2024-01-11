//
//  RateUs.m
//  MediaShareController
//
//  Created by Tuhin Kumer on 12/18/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import "RateUs.h"

@interface RateUs()

@property (nonatomic, strong) NSString * strAppID;

@end

@implementation RateUs

-(instancetype) initWithAppID :(NSString*) appID{
    
    if (self = [super init]) {
        
        self.strAppID = appID;
    }

    return self;
}


- (BOOL)isComponentEnabled{
    //TODO:
    
    return YES;
}


- (void) presentOn:(UIViewController*)viewController onCompletion:(ActionCompletion)block{
    
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat: ITUNES_URL,self.strAppID]]];
}

@end
