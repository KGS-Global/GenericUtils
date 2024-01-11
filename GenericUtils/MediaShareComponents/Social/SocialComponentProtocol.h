//
//  SocialComponentProtocol.h
//  MediaShareController
//
//  Created by Towhidul Islam on 12/11/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "ActionComponentProtocol.h"

@protocol SocialComponentProtocol <ActionComponentProtocol>
@required
- (void) addUrl:(NSURL*)url;
@optional
- (void) addInitialText:(NSString*)text;
- (void) addImage:(UIImage*)image;
@end
