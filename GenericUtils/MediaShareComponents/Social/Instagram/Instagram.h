//
//  Instagram.h
//  MediaShareController
//
//  Created by Towhidul Islam on 12/11/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocialComponentProtocol.h"

@interface Instagram : NSObject <SocialComponentProtocol>
- (instancetype)initWithSourceUrl:(NSURL*)url andMessage : (NSString*) message;
@end
