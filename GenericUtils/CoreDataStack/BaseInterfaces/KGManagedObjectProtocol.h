//
//  DyanaManagedObjectProtocol.h
//  CoreDataTest
//
//  Created by Towhid Islam on 4/12/14.
//  Copyright (c) 2016 KiteGamesStudio Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KGObjectProtocol.h"

@protocol KGManagedObjectProtocol <KGObjectProtocol>
@optional
+ (instancetype) insertIntoContext:(NSManagedObjectContext *)context withProperties:(NSDictionary*)properties;
+ (instancetype) insertIntoContext:(NSManagedObjectContext *)context withJSON:(NSData*)json;
@end
