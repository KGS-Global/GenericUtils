//
//  DNCoreObject.h
//  StartupProjectSampleA
//
//  Created by Towhid Islam on 4/12/15.
//  Copyright (c) 2016 KiteGamesStudio Ltd. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "KGManagedObject.h"

typedef NS_ENUM(NSInteger, Match) {
    All,
    Any
};

typedef void (^SearchHandler)(NSFetchRequest *request);

@class KGCoreObject;

@protocol KGCoreObjectProtocol <NSObject>
+ (NSUInteger) rows:(NSManagedObjectContext*)context;
+ (NSArray*) read:(NSDictionary*)searchPaths context:(NSManagedObjectContext*)context;
- (void) write:(NSDictionary*)updateProperties;
@optional
+ (KGCoreObject*) readBy:(NSManagedObjectID*)managedId context:(NSManagedObjectContext*)context;
@end

@interface KGCoreObject : KGManagedObject <KGCoreObjectProtocol>
@property (nonatomic, retain) NSString *guid;
@property (nonatomic, retain) NSDate *eventTimeStamp;
@property (nonatomic, retain) NSNumber *eventOrder;
@property (nonatomic, retain) NSString *eventRemarks;

+ (NSString*) entityName;
+ (NSPredicate*) predicateForKey:(NSString*)key value:(id)value;
+ (NSArray*) readUsing:(NSManagedObjectContext*)context sortDescriptors:(NSArray*)descriptors searchHandler:(SearchHandler)handler;
+ (KGCoreObject*) readByGuid:(NSString*)guid context:(NSManagedObjectContext*)context;
+ (void) write:(NSDictionary *)updateProperties whereGuid:(NSString *)guid context:(NSManagedObjectContext *)context;
+ (void) write:(NSDictionary *)updateProperties whereManagedID:(NSManagedObjectID *)ID context:(NSManagedObjectContext *)context;
+ (void) insert:(NSArray*)items context:(NSManagedObjectContext *)context;
@end
