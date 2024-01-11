//
//  MoreApps.h
//  MediaShareController
//
//  Created by Tuhin Kumer on 12/12/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionComponentProtocol.h"

@interface MoreApps : NSObject <ActionComponentProtocol>

@property (nonatomic, strong) id artistID;
@property (nonatomic) SEL loadAppsWithPathAndCompletionBlock;
- (instancetype)initWithPlacementTag:(NSString*)tag fallback:(Class)viewController;

@end
