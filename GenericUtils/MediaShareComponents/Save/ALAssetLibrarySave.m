//
//  UrlSaveMedia.m
//  MediaShareController
//
//  Created by Tuhin Kumer on 12/15/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import "ALAssetLibrarySave.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ALAssetLibrarySave ()
@property (nonatomic, assign) BOOL isUrlSaved;
@property (nonatomic, strong) SaveCompletion onCompletion;
@property (nonatomic, strong) ALAssetsLibrary *library;
@property (nonatomic, strong) NSURL *savedUrl;

@end

@implementation ALAssetLibrarySave

- (ALAssetsLibrary *)library{
    if (_library == nil) {
        _library = [[ALAssetsLibrary alloc] init];
    }
    return _library;
}


- (NSURL *)assetUrl{
    return self.savedUrl;
}


- (BOOL)isSaved{
    return self.isUrlSaved;
}


- (void)saveToAlbum:(NSString *)albumName fromImage:(UIImage *)image onCompletion:(SaveCompletion)block{
    self.onCompletion = block;
    PHAssetCollection *collection = [self getAlbum:albumName];
    if (collection == nil) {
        [self createAlbum:albumName onCompletion:^(BOOL success, NSError *error) {
            [self saveUsingAlAssetLib:albumName fromImage:image];
        }];
    }else{
        [self saveUsingAlAssetLib:albumName fromImage:image];
    }
}


- (void) saveUsingAlAssetLib:(NSString *)albumName fromImage:(UIImage *)image{
    
    ALAssetsLibrary *library = [self library];
//    mediaUrl = [mediaUrl isFileURL] == YES ? [NSURL URLWithString: mediaUrl.path] : mediaUrl;
    
    __weak ALAssetLibrarySave *weakSelf = self;
    
    
    [library writeImageToSavedPhotosAlbum: image.CGImage
                                 metadata:nil
                          completionBlock:^(NSURL *assetURL, NSError *error){
                              
                              if (assetURL != nil) {
                                  weakSelf.isUrlSaved = YES;
                                  weakSelf.savedUrl = assetURL;
                                  
                                  [weakSelf moveAsset:assetURL toAlbum:albumName];
                                  
                                  if(weakSelf.onCompletion != nil){
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          weakSelf.onCompletion(YES, assetURL, nil);
                                      });
                                  }
                              }else{
                                  if(weakSelf.onCompletion != nil){
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          weakSelf.onCompletion(NO, nil, error);
                                      });
                                  }
                              }
                          }];
    
}

- (void)saveToAlbum:(NSString *)albumName fromURL:(NSURL *)mediaUrl onCompletion:(SaveCompletion)block{
    self.onCompletion = block;
    PHAssetCollection *collection = [self getAlbum:albumName];
    if (collection == nil) {
        [self createAlbum:albumName onCompletion:^(BOOL success, NSError *error) {
            [self saveUsingAlAssetLib:albumName fromURL:mediaUrl];
        }];
    }else{
        [self saveUsingAlAssetLib:albumName fromURL:mediaUrl];
    }
}

- (void) saveUsingAlAssetLib:(NSString *)albumName fromURL:(NSURL *)mediaUrl{
    
    ALAssetsLibrary *library = [self library];
    mediaUrl = [mediaUrl isFileURL] == YES ? [NSURL URLWithString: mediaUrl.path] : mediaUrl;
    
    __weak ALAssetLibrarySave *weakSelf = self;
        
    [library writeVideoAtPathToSavedPhotosAlbum: mediaUrl
                                completionBlock:^(NSURL *assetURL, NSError *error){
                                    if (assetURL != nil) {
                                        weakSelf.isUrlSaved = YES;
                                        weakSelf.savedUrl = assetURL;
                                        
                                        [weakSelf moveAsset:assetURL toAlbum:albumName];
                                        
                                        
                                        if(weakSelf.onCompletion != nil){
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                weakSelf.onCompletion(YES, assetURL, nil);
                                            });
                                        }
                                    }else{
                                        if(weakSelf.onCompletion != nil){
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                weakSelf.onCompletion(NO, nil, error);
                                            });
                                        }
                                    }
                                }];
    
}

-(void) moveAsset:(NSURL*)assetURL toAlbum:(NSString *)albumName{

    ALAssetsLibrary *library = [self library];
    __block ALAssetsGroup* groupToAddTo;
    
    [library enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:albumName]) {
            groupToAddTo = group;
            // try to get the asset
            [library assetForURL:assetURL
                     resultBlock:^(ALAsset *asset) {
                         // assign the photo to the album
                         [groupToAddTo addAsset:asset];
                         NSLog(@"Added %@ to %@", [[asset defaultRepresentation] filename], albumName);
                     }
                    failureBlock:^(NSError* error) {
                        NSLog(@"failed to retrieve image asset:\nError: %@ ", [error localizedDescription]);
                    }];
        }
        
    } failureBlock:^(NSError *error) {
        //
    }];
    
}






@end
