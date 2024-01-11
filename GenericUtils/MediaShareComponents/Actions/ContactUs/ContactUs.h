//
//  ContactUs.h
//  MediaShareController
//
//  Created by Towhidul Islam on 12/11/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionComponentProtocol.h"
#import "ContactUsContent.h"

@interface ContactUs : NSObject <ActionComponentProtocol>
- (instancetype)initWithContent:(ContactUsContent*)content;
- (void) addContent:(ContactUsContent*)content;
@end
