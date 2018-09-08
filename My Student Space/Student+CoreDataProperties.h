//
//  Student+CoreDataProperties.h
//  My Student Space
//
//  Created by Mahdi Amirmazaheri on 26/10/2015.
//  Copyright © 2015 Mohamadmahdi Amirmazaheri. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Student.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *studentAddress;
@property (nullable, nonatomic, retain) NSString *studentCourse;
@property (nullable, nonatomic, retain) NSDate *studentDateOfBirth;
@property (nullable, nonatomic, retain) NSString *studentFirstName;
@property (nullable, nonatomic, retain) NSString *studentGender;
@property (nullable, nonatomic, retain) NSNumber *studentID;
@property (nullable, nonatomic, retain) NSString *studentLastName;
@property (nullable, nonatomic, retain) NSData *studentPhoto;
@property (nullable, nonatomic, retain) NSString *studentGPA;
@property (nullable, nonatomic, retain) NSSet<Mark *> *marks;

@end

@interface Student (CoreDataGeneratedAccessors)

- (void)addMarksObject:(Mark *)value;
- (void)removeMarksObject:(Mark *)value;
- (void)addMarks:(NSSet<Mark *> *)values;
- (void)removeMarks:(NSSet<Mark *> *)values;

@end

NS_ASSUME_NONNULL_END
