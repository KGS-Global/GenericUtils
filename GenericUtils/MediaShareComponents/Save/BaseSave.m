//
//  BaseSaveMedia.m
//  MediaShareController
//
//  Created by Tuhin Kumer on 12/15/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import "BaseSave.h"
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>

@implementation BaseSave

- (NSURL *)assetUrl{
    return nil;
}

- (PHAsset *)asset{
    return nil;
}

-(PHAssetCollection *) getAlbum:(NSString *)strAlbumName{
    
    PHFetchOptions *option = [PHFetchOptions new];
    option.predicate = [NSPredicate predicateWithFormat: @"title = %@", strAlbumName];
    
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:option];
    if(result.count == 0)
        return nil;
    else{
        return  [result firstObject];
    }
}

- (void) createAlbum:(NSString*)albumName onCompletion:(void (^)(BOOL, NSError * _Nullable))completion{
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle: albumName];
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        completion(success, error);
    }];
}

- (BOOL)isSaved{
    return NO;
}

- (void)saveToAlbum:(NSString *)strAlbumName fromURL:(NSURL *)mediaUrl onCompletion:(SaveCompletion)block{
    NSLog(@"PLease Subclass");
}

- (void)saveToAlbum:(NSString *)strAlbumName fromImage:(UIImage *)image onCompletion:(SaveCompletion)block{
    NSLog(@"PLease Subclass");
}


-( MEDIA ) getMediaType : (NSURL*)mediaUrl{
    
    NSString *path = [mediaUrl path];
    NSString *extension = [path pathExtension];
    
    //#import <MobileCoreServices/MobileCoreServices.h> needed to import
    NSString *UTI = (__bridge_transfer NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)extension, NULL);
    NSString *contentType = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass((__bridge CFStringRef)UTI, kUTTagClassMIMEType);
    
    if ([contentType rangeOfString:@"image"].location != NSNotFound ) {
        return MEDIA_IMAGE;
    }
    else if ([contentType rangeOfString:@"video"].location != NSNotFound) {
        return MEDIA_VIDEO;
    }
    
    return MEDIA_OTHERSTYPE;
}

@end
