//
//  CoreDataStorageController.m
//  Gamification
//
//  Created by Innocellence on 12/17/13.
//  Copyright (c) 2014 Eli Lilly and Company. All rights reserved.
//

#import "CoreDataStorageController.h"

#define ManagedObjectModelFileName @"TTzaojiao"

static CoreDataStorageController *sharedModel = nil;

@implementation CoreDataStorageController

@synthesize delegates = _delegates;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

-(void)dealloc {
    self.delegates = nil;
    __managedObjectContext = nil;
    __managedObjectModel = nil;
    __persistentStoreCoordinator = nil;
}

#pragma mark - Singleton Creation

+ (id)sharedModel {
    @synchronized(self){
        if(sharedModel == nil)
            sharedModel = [[self alloc] initWithDelegate:nil];
        else {
        }
    }
    
    return sharedModel;
}

+ (id)sharedModel:(id<SFCacheControllerDelegate>)delegate{
	@synchronized(self){
		if(sharedModel == nil)
			sharedModel = [[self alloc] initWithDelegate:delegate];
		else {
			if(delegate)
				[sharedModel.delegates addObject:delegate];
		}
	}
    
	return sharedModel;
}

+ (id)allocWithZone:(NSZone *)zone{
    @synchronized(self) {
        if(sharedModel == nil)  {
            sharedModel = [super allocWithZone:zone];
            return sharedModel;
        }
    }
    return nil;
}

+ (void)addDelegate:(id<SFCacheControllerDelegate>)delegate{
	[sharedModel.delegates addObject:delegate];
}

+ (void)removeDelegate:(id<SFCacheControllerDelegate>)delegate{
	[sharedModel.delegates removeObjectIdenticalTo:delegate];
}

- (id)initWithDelegate:(id<SFCacheControllerDelegate>)newDelegate{
    self = [super init];
	if(self){
        
		_delegates = [[NSMutableArray alloc] init];
		if(newDelegate)
			[_delegates addObject:newDelegate];
        
        __managedObjectContext = [self managedObjectContext];
		
	}
	return self;
}

#pragma mark - Model Accessors
- (NSArray *)distinctElementFromEntity:(NSString *)entityName PredicateFromat:(NSPredicate*)predicateFromat DistinctKey:(NSString *)distinctkey SortKey:(NSString *)sortkey {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:__managedObjectContext];
    request.entity = entity;
    request.propertiesToFetch = [NSArray arrayWithObject:[[entity propertiesByName] objectForKey:distinctkey]];
    request.returnsDistinctResults = YES;
    request.resultType = NSDictionaryResultType;
    
    if (predicateFromat!=nil) {
        NSPredicate *query = predicateFromat;
        [request setPredicate:query];
    }
    
    if (sortkey!=nil && ![sortkey isEqualToString:@""]) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortkey ascending:YES];
        [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    }
    
    NSError *error = nil;
    NSArray *distincResults = [__managedObjectContext executeFetchRequest:request error:&error];
    
    return distincResults;
}

- (NSArray*)selectElementFromEntity:(NSString*)entityName PredicateFromat:(NSPredicate*)predicateFromat SortKey:(NSString*)key Ascending:(BOOL)ascending {
    // Create a new fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    // Set the entity of the fetch request to be our Issues object
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:__managedObjectContext];
    [request setEntity:entity];
    
    // Set up a predicate limiting the results of the request
    // We only want the issue with the name provided
    if (predicateFromat!=nil) {
        NSPredicate *query = predicateFromat;
        [request setPredicate:query];
    }
    
    // Set up the request sorting
    if (key!=nil && ![key isEqualToString:@""]) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                            initWithKey:key
                                            ascending:ascending];
        
        [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    }
    
    NSError *error = nil;
    NSArray *fetchResults = [__managedObjectContext executeFetchRequest:request
                                                                  error:&error];
	if (fetchResults != nil) {
        if([fetchResults count] > 0)
            return fetchResults;
	}
    
    // Nothing found, return nil
    return nil;
}

- (NSManagedObject *)insertElementIntoEntity:(NSString*)entityName {
    
    NSManagedObject *newEntity = [NSEntityDescription insertNewObjectForEntityForName:entityName
                                  
                                                               inManagedObjectContext:__managedObjectContext];
    return newEntity;
}

- (BOOL)removeAllElements:(id)entity {
    for(id element in [self selectElementFromEntity:entity PredicateFromat:nil SortKey:nil Ascending:NO]){
        [__managedObjectContext deleteObject:element];
    }
    return [self saveContext];
}

- (BOOL)removeElement:(NSArray *)elements {
    // In most cases the reminders array will contain 1 object,
    // but by designing the model this way we make it possible for multiple
    // reminders to be deleted with only one save operation on the context
    for(id element in elements){
        [__managedObjectContext deleteObject:element];
    }
    return [self saveContext];
}

#pragma mark - Managed Object Context

- (BOOL)saveContext{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    
    // acceptable merge policies are listed above as id constants
    [managedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
    
    if (managedObjectContext != nil){
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]){
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             */

            return NO;
        }
    }
    else{
        return NO;
    }

    return YES;
}

#pragma mark - Undo/Redo Operations


- (void)undo{
    [__managedObjectContext undo];
    
}

- (void)redo{
    [__managedObjectContext redo];
}

- (void)rollback{
    [__managedObjectContext rollback];
}

- (void)reset{
    [__managedObjectContext reset];
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext{
    if (__managedObjectContext != nil){
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil){
        
        NSManagedObjectContext *moc = [[NSManagedObjectContext alloc]
                                       initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        [moc performBlockAndWait:^(void){
            // Set up an undo manager, not included by default
            NSUndoManager *undoManager = [[NSUndoManager alloc] init];
            [undoManager setGroupsByEvent:NO];
            [moc setUndoManager:undoManager];
            
            
            // Set persistent store
            [moc setPersistentStoreCoordinator:coordinator];
        }];
        
        
        __managedObjectContext = moc;
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:ManagedObjectModelFileName withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if (__persistentStoreCoordinator != nil){
        return __persistentStoreCoordinator;
    }
    
    // Set up persistent Store Coordinator
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    // Set up SQLite db and options dictionary
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",ManagedObjectModelFileName]];

    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];

    // Add the persistent store to the persistent store coordinator
    NSError *error = nil;
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                    configuration:nil
                                                              URL:storeURL
                                                          options:options
                                                            error:&error]){
        // Handle the error
        abort();
    }
    
    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (NSString*) stringWithUUID {
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString    *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuidString;
}

- (void)persistentStoreDidChange {
}

@end
