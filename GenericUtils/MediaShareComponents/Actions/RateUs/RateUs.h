//
//  RateUs.h
//  MediaShareController
//
//  Created by Tuhin Kumer on 12/18/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionComponentProtocol.h"

#define ITUNES_URL @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"



@interface RateUs : NSObject<ActionComponentProtocol>

-(instancetype) initWithAppID :(NSString*) appID;

@end
