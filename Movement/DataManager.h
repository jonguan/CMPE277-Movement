//
//  DataManager.h
//  Movement
//
//  Created by Jon Guan on 5/11/14.
//  Copyright (c) 2014 Scanadu, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataManager : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (DataManager *)sharedManager;

- (void)saveSteps:(NSInteger)steps withDate:(NSDate *)date;

@end
