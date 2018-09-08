//
//  Mark+CoreDataProperties.h
//  My Student Space
//
//  Created by Mahdi Amirmazaheri on 24/10/2015.
//  Copyright © 2015 Mohamadmahdi Amirmazaheri. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Mark.h"

NS_ASSUME_NONNULL_BEGIN

@interface Mark (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *markUnitID;
@property (nullable, nonatomic, retain) NSString *markUnitName;
@property (nullable, nonatomic, retain) NSString *markUnitGrade;
@property (nullable, nonatomic, retain) NSManagedObject *student;

@end

NS_ASSUME_NONNULL_END
