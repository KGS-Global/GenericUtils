//
//  ContactUsContent.h
//  MediaShareController
//
//  Created by Towhidul Islam on 12/11/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, MimeType){
    mov,
    jpeg,
    png,
    jpg
};

@interface ContactUsContent : NSObject

@property (nonatomic, strong) NSString *strSubject;

@property (nonatomic, strong) NSArray *strRecipients;

@property (nonatomic, strong) NSString *strMessageBody;

@property (nonatomic, strong) NSData *dataAttachment;

@property (nonatomic, assign) MimeType mimeType;

@property (nonatomic, strong) NSString *fileName;

- (NSString*) getParsedMimeType;

@end
