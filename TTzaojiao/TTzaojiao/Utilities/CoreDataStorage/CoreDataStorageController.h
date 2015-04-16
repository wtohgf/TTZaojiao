//
//  CoreDataStorageController.h
//  Gamification
//
//  Created by Innocellence on 12/17/13.
//  Copyright (c) 2014 Eli Lilly and Company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@protocol SFCacheControllerDelegate;
@interface CoreDataStorageController : NSObject

@property (nonatomic, strong) NSMutableArray *delegates;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// Singleton Creation
+ (id)sharedModel;
+ (id)sharedModel:(id<SFCacheControllerDelegate>)delegate;
+ (void)addDelegate:(id<SFCacheControllerDelegate>)delegate;
+ (void)removeDelegate:(id<SFCacheControllerDelegate>)delegate;
+ (id)allocWithZone:(NSZone *)zone;

- (id)initWithDelegate:(id<SFCacheControllerDelegate>)newDelegate;

// Context Operations
- (void)undo;
- (void)redo;
- (void)rollback;
- (void)reset;
- (BOOL)saveContext;
+ (NSString*) stringWithUUID;

// Model Accessors (These are the methods you edit and create for your specific model)
- (NSArray *)distinctElementFromEntity:(NSString *)entityName PredicateFromat:(NSPredicate*)predicateFromat DistinctKey:(NSString *)distinctkey SortKey:(NSString *)sortkey;
- (NSArray*)selectElementFromEntity:(NSString*)entityName PredicateFromat:(NSPredicate*)predicateFromat SortKey:(NSString*)key Ascending:(BOOL)ascending;
- (id)insertElementIntoEntity:(NSString*)entityName;
- (BOOL)removeAllElements:(id)entity;
- (BOOL)removeElement:(NSArray *)elements;

// Core Data Utilities
- (NSURL *)applicationDocumentsDirectory;

@end

@protocol SFCacheControllerDelegate <NSObject>
- (void)persistentStoreDidChange;

@end
