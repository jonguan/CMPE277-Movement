//
//  StepEntity.h
//  Movement
//
//  Created by Jon Guan on 5/11/14.
//  Copyright (c) 2014 Scanadu, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface StepEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * steps;
@property (nonatomic, retain) NSDate * date;

@end
