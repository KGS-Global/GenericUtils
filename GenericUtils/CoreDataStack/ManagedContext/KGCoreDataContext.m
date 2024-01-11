//
//  CoreDataContextManager.m
//  CoreDataTest
//
//  Created by Towhid Islam on 1/25/14.
//  Copyright (c) 2014 Towhid Islam. All rights reserved.
//

#import "KGCoreDataContext.h"
#import "CDDebugLog.h"

@interface KGCoreDataContext ()
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSString *defaultModelFileName;
@end

@implementation KGCoreDataContext
@synthesize context = _context;

+ (instancetype)sharedInstance{
    
    static KGCoreDataContext *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[KGCoreDataContext alloc] init];
    });
    return sharedInstance;
}

- (id)init{
    
    if (self = [super init]) {
        NSBundle *mainBundel = [NSBundle mainBundle];
        NSArray *array = [mainBundel pathsForResourcesOfType:@"momd" inDirectory:nil];
        NSString *fileName = [[array lastObject] lastPathComponent];
        fileName = [fileName stringByReplacingOccurrencesOfString:@".momd" withString:@""];
        _defaultModelFileName = fileName;
        _context = [self createFromDataModelFileName:fileName];
    }
    return self;
}

- (void)dealloc{
    [CDDebugLog message:@"dealloc %@",NSStringFromClass([self class])];
}

- (NSManagedObjectContext*) defaultContext{
    
    return self.context;
}

- (NSManagedObjectContext *)cloneDefaultContext{
    
    if (!self.context) {
        return nil;
    }
    
    NSManagedObjectContext *clone = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [clone setParentContext: self.context];
    return clone;
}

-(NSManagedObjectContext*) createFromDataModelFileName:(NSString*)name{
    
    if (!name) {
        return nil;
    }
    
    //Create ManagedObjectModel
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:name ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    //Create PersistanceStorage
    NSString *storeName = [name stringByAppendingPathExtension:@"sqlite"];
    NSString *fPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *storeURL = [NSURL fileURLWithPath: [fPath stringByAppendingPathComponent: storeName]];
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                             nil];
    NSError *error = nil;
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                                                initWithManagedObjectModel:managedObjectModel];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil
                                                            URL:storeURL
                                                        options:options
                                                          error:&error]) {
        
        [CDDebugLog message:@"Unresolved error %@, %@", error, [error userInfo]];
        abort();
    }
    //Create Context
    NSManagedObjectContext *managedObjectContext_ = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [managedObjectContext_ setPersistentStoreCoordinator:persistentStoreCoordinator];
    
    return managedObjectContext_;
}

- (void)saveDefaultContext{
    [self saveContext:self.context];
}

- (void)saveContext:(NSManagedObjectContext*)context{
    
    if (!context) {
        return;
    }
    
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = context;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            [CDDebugLog message:@"Unresolved error %@, %@", error, [error userInfo]];
             NSLog(@"SaveDefaultContextError %@",error.userInfo);
            abort();
        }
    }
}

/**
 *There are two possible ways to adopt Thread confinement Pattern:
 
 ->Create a separate managed object context for each thread and share a single persistent store coordinator.
 This is the typically-recommended approach.
 
 ->Create a separate managed object context and persistent store coordinator for each thread.
 This approach provides for greater concurrency at the expense of greater complexity (particularly if you need to communicate changes between different contexts) and increased memory usage.
 *
 */
/** Sharing single persistent store coordinator with multiple MOC
 * Although the NSPersistentStoreCoordinator is not thread safe either,
 * the NSManagedObjectContext knows how to lock it properly when in use.
 * Therefore, we can attach as many NSManagedObjectContext objects to
 * a single NSPersistentStoreCoordinator as we want without fear of collision.
 */
/*Rule Of Thumb :: Don't pass the ManagedObjects across the thread boundaries. NSManagedObjects are not thread safe.
 *But NSManagedObjectId is thread safe, so these can be passes arround threads.
 */

- (void)mergeDefaultContextFromContext:(NSManagedObjectContext *)context{
    
    //Test If this is calling on main thread or not.
    [CDDebugLog message:@"mergeDefaultContextFromContext execution queue :: %s",dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL)];
    //
    
    if (!self.context || !context) {
        return;
    }
    
    if (context == self.context) {
        [CDDebugLog message:@"Both are same no need to merge"];
        return;
    }

    NSError *error;
    if (![context save:&error]) {
        // Update to handle the error appropriately.
        [CDDebugLog message:@"Unresolved error %@, %@", error, [error userInfo]];
        //remove observer from notification center;
        NSLog(@"MergeCloneContextError %@",error.userInfo);
        abort();
    }
    
    [self.context performBlockAndWait:^{
        NSError *error = nil;
        if (![self.context save:&error]) {
            NSLog(@"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
            abort();
        }
    }];
}

NSString* const KGDefaultManagedContextDidMergeNotification = @"AppDefaultContextDidMergeNotification";


@end
