//
//  IMAsync.h
//  Imaggle
//
//  Created by David Liu on 3/19/14.
//  Copyright (c) 2014 Imaggle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <AFNetworking/AFNetworking.h>
#import <Bolts.h>

@interface IMAsync : NSObject

#pragma mark - Parse
+ (BFTask *) callCloudFunction:(NSString *)functionName withParameteres:(NSDictionary *)parameters;
+ (BFTask *) refreshAsync:(PFObject *)object;
+ (BFTask *) fetchIfNeededAsync:(PFObject *)object;
+ (BFTask *) fetchAllIfNeededAsync:(NSArray *)objects;
+ (BFTask *) findObjectsAsync:(PFQuery *)query;
+ (BFTask *) findObjectsWithPaginationAsync:(PFQuery *)query;
+ (BFTask *) getFirstObjectAsync:(PFQuery *)query;
+ (BFTask *) getObjectAsync:(PFQuery *)query withObjectId:(NSString *)objectId;
+ (BFTask *) saveObjectAsync: (PFObject *)object;
+ (BFTask *) getData:(PFFile *)file;
+ (BFTask *) saveFile:(PFFile *)file;
+ (BFTask *) saveAllObjects:(NSArray *)objects;
+ (BFTask *) countOfObjectsAsync:(PFQuery *)query;
+ (BFTask *) deleteObjectAsync:(PFObject *)object;

#pragma mark - Others
+ (BFTask *) downloadDataFromURL:(NSURL *)url withCachePath:(NSString *)cachePath;

@end
