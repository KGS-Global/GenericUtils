//
//  SaveMedia.m
//  MediaShareController
//
//  Created by Tuhin Kumer on 12/13/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import "PHAssetLibrarySave.h"

@interface PHAssetLibrarySave ()
@property (nonatomic, strong) PHObjectPlaceholder *tempAsset;
@property (nonatomic, strong) SaveCompletion onCompletion;
@property (nonatomic, assign) BOOL isMediaSaved;
@end



@implementation PHAssetLibrarySave

- (BOOL)isSaved{
    return self.isMediaSaved;
}

- (PHAsset *)asset{
    PHFetchResult *result = [PHAsset fetchAssetsWithLocalIdentifiers:@[[self.tempAsset localIdentifier]] options:nil];
    return  ([result count] > 0) ? [result objectAtIndex:0] : nil;
}

-(void) saveToAlbum :( NSString*) strAlbumName fromURL :(NSURL*) mediaUrl onCompletion:(SaveCompletion)block{
    
    self.onCompletion = block;
    
    __block PHAssetCollection *assetCollection = [self getAlbum: strAlbumName];
    if(!assetCollection){
        [self createAlbum:strAlbumName onCompletion:^(BOOL success, NSError * _Nullable error) {
            __weak PHAssetLibrarySave *weakSelf = self;
            
            if(success){
                assetCollection = [self getAlbum: strAlbumName];
                [self addMedia: mediaUrl ToAlbum: assetCollection];
            }
            else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.onCompletion(success,nil,error);
                });
            }
        }];
    }
    else{
        [self addMedia: mediaUrl ToAlbum: assetCollection];
    }
}


-(void) addMedia:(NSURL *) mediaUrl ToAlbum:(PHAssetCollection *) assetCollection {
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        PHAssetChangeRequest *assetChangeRequest;
        
        if ([self getMediaType:mediaUrl] == MEDIA_IMAGE ) {
            
            assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:mediaUrl];
            
        }
        else if([self getMediaType:mediaUrl] == MEDIA_VIDEO){
            
            assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL: mediaUrl];
        }
        else{
            
            NSLog(@"File type not supported");
            return ;
        }
        
        PHAssetCollectionChangeRequest *assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        self.tempAsset = [assetChangeRequest placeholderForCreatedAsset];
        [assetCollectionChangeRequest addAssets:@[self.tempAsset]];
        
    } completionHandler:^(BOOL success, NSError *error) {
        
        __weak PHAssetLibrarySave *weakSelf = self;
        
        if (!success) {
            NSLog(@"Error creating asset: %@", error);
        }
        weakSelf.isMediaSaved = success;
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.onCompletion(success, weakSelf.asset, error);
        });
    }];
}




-(void) saveToAlbum:(NSString*)strAlbumName fromImage:(UIImage*)image onCompletion:(SaveCompletion)block{
    
    self.onCompletion = block;
    
    __block PHAssetCollection *assetCollection = [self getAlbum: strAlbumName];
    if(!assetCollection){
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            
            [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle: strAlbumName];
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            
            __weak PHAssetLibrarySave *weakSelf = self;
            
            if(success){
                assetCollection = [self getAlbum: strAlbumName];
                [self addImage: image ToAlbum: assetCollection];
            }
            else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.onCompletion(success, nil, error);
                });
            }
        }];
    }
    else{
        [self addImage: image ToAlbum: assetCollection];
    }
}


-(void) addImage:(UIImage *) image ToAlbum:(PHAssetCollection *) assetCollection {
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        
        PHAssetCollectionChangeRequest *assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        self.tempAsset = [assetChangeRequest placeholderForCreatedAsset];
        [assetCollectionChangeRequest addAssets:@[self.tempAsset]];
        
    } completionHandler:^(BOOL success, NSError *error) {
        
//        __weak PHAssetLibrarySave *weakSelf = self;
        
        if (!success) {
            NSLog(@"Error creating asset: %@", error);
        }
        
//        dispatch_async(dispatch_get_main_queue(), ^{
        self.onCompletion(success, self.asset, error);
        
//        });
    }];
}


@end
