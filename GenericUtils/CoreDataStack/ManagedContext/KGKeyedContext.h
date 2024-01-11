//
//  MultiDataContextManager.h
//  RequestSynchronizer
//
//  Created by Towhid Islam on 7/18/14.
//  Copyright (c) 2014 Towhid Islam. All rights reserved.
//

#import "KGCoreDataContext.h"

@interface KGKeyedContext : KGCoreDataContext
+ (instancetype) sharedInstance;
- (NSManagedObjectContext*) contextForKey:(NSString*)key;
- (NSManagedObjectContext*) cloneContextForKey:(NSString*)key;
- (void)saveContextForKey:(NSString*)key;
- (void)mergeContextForKey:(NSString*)key fromContext:(NSManagedObjectContext*)context;
@end
