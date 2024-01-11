//
//  ContactUsContent.m
//  MediaShareController
//
//  Created by Towhidul Islam on 12/11/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import "ContactUsContent.h"

@implementation ContactUsContent

- (NSString *)getParsedMimeType{
    
    NSString *result = @"image/jpeg";
    
    switch (self.mimeType) {
        case mov:
            result = @"video/MOV";
            break;
            
        case png:
            result = @"image/png";
            break;
            
        case jpeg:
            result = @"image/jpeg";
            break;
            
        case jpg:
            result = @"image/jpg";
            break;
            
        default:
            break;
    }
    
    return result;
}

@end
