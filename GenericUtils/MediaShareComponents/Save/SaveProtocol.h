//
//  SaveProtocol.h
//  MediaShareController
//
//  Created by Tuhin Kumer on 12/13/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

typedef void(^SaveCompletion)(BOOL, id, NSError*);

@protocol SaveProtocol <NSObject>

@required

-(BOOL) isSaved;
-(void) saveToAlbum :( NSString*) strAlbumName fromURL :(NSURL*) mediaUrl onCompletion:(SaveCompletion)block;

@optional
- (PHAsset*) asset;
- (NSURL*) assetUrl;
-(void) saveToAlbum :( NSString*) strAlbumName fromImage :(UIImage*) image onCompletion:(SaveCompletion)block;


@end