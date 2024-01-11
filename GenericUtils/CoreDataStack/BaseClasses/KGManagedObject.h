//
//  DyanaManagedObject.h
//  CoreDataTest
//
//  Created by Towhid Islam on 4/12/14.
//  Copyright (c) 2016 KiteGamesStudio Ltd. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "KGManagedObjectProtocol.h"

@interface KGManagedObject : NSManagedObject <KGManagedObjectProtocol>
- (instancetype)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context updateWithInfo:(NSDictionary*)info;
- (instancetype)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context updateWithJSON:(NSData*)json;
@end
