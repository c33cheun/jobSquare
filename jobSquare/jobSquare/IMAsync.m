//
//  IMAsync.m
//  Imaggle
//
//  Created by David Liu on 3/19/14.
//  Copyright (c) 2014 Imaggle. All rights reserved.
//

#import "IMAsync.h"
#import <GoogleMaps/GoogleMaps.h>
#import "UIImageView+AFNetworking.h"

@implementation IMAsync

#pragma mark - Parse
+ (BFTask *) callCloudFunction:(NSString *)functionName withParameteres:(NSDictionary *)parameters
{
    if (functionName.length) {
        BFTaskCompletionSource *task = [BFTaskCompletionSource taskCompletionSource];
        [PFCloud callFunctionInBackground:functionName
                           withParameters:parameters ? parameters : @{}
                                    block:^(id object, NSError *error) {
                                        if (!error) {
                                            [task setResult:object];
                                        }
                                        else {
                                            [task setError:error];
                                        }
                                    }];
        return task.task;
    }
    return [BFTask taskWithResult:nil];
}


+ (BFTask *) refreshAsync:(PFObject *)object {
    if (object) {
        BFTaskCompletionSource *task = [BFTaskCompletionSource taskCompletionSource];
        [object refreshInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!error) {
                [task setResult:object];
            } else {
                [task setError:error];
            }
        }];
        return task.task;
    }
    return [BFTask taskWithResult:nil];
}

+ (BFTask *) fetchIfNeededAsync:(PFObject *)object {
    if (object) {
        BFTaskCompletionSource *task = [BFTaskCompletionSource taskCompletionSource];
        [object fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!error) {
                [task setResult:object];
            } else {
                [task setError:error];
            }
        }];
        return task.task;
    }
    return [BFTask taskWithResult:nil];
}

+ (BFTask *) fetchAllIfNeededAsync:(NSArray *)objects {
    if (objects.count) {
        BFTaskCompletionSource *task = [BFTaskCompletionSource taskCompletionSource];
        [PFObject fetchAllIfNeededInBackground:objects
                                         block:^(NSArray *objects, NSError *error) {
                                             if (!error) {
                                                 [task setResult:objects];
                                             } else {
                                                 [task setError:error];
                                             }
                                         }];
        return task.task;
    }
    return [BFTask taskWithResult:nil];
}

+ (BFTask *) findObjectsAsync:(PFQuery *)query {
    if (query) {
        BFTaskCompletionSource *task = [BFTaskCompletionSource taskCompletionSource];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                [task setResult:objects];
            } else {
                [task setError:error];
            }
        }];
        return task.task;
    }
    return [BFTask taskWithResult:nil];
}

+ (BFTask *) findObjectsWithPaginationAsync:(PFQuery *)query
{
    if (query) {
        NSMutableArray *ma = [NSMutableArray arrayWithCapacity:query.limit];
        return [IMAsync continueTofindObjectsAsync:query
                                  andInsertToArray:ma
                             continueFromQueryTask:[IMAsync findObjectsAsync:query]];
    }
    return [BFTask taskWithResult:nil];
}

+ (BFTask *) continueTofindObjectsAsync:(PFQuery *)query andInsertToArray:(NSMutableArray *)objects continueFromQueryTask:(BFTask *)queryTask
{
    return [queryTask continueWithSuccessBlock:^id(BFTask *task) {
        NSArray *r = task.result;
        [objects addObjectsFromArray:r];
        if (r.count < query.limit) {
            return [BFTask taskWithResult:objects];
        }
        else {
            query.skip = objects.count;
            return [[IMAsync findObjectsAsync:query] continueWithSuccessBlock:^id(BFTask *task) {
                return [IMAsync continueTofindObjectsAsync:query
                                          andInsertToArray:objects
                                     continueFromQueryTask:task];
            }];
        }
    }];
}

+ (BFTask *) getFirstObjectAsync:(PFQuery *)query {
    if (query) {
        BFTaskCompletionSource *task = [BFTaskCompletionSource taskCompletionSource];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (error) {
                [task setError:error];
            }
            else {
                [task setResult:object];
            }
        }];
        return task.task;
    }
    return [BFTask taskWithResult:nil];
}

+ (BFTask *) getObjectAsync:(PFQuery *)query withObjectId:(NSString *)objectId {
    if (query && objectId.length) {
        BFTaskCompletionSource *task = [BFTaskCompletionSource taskCompletionSource];
        [query getObjectInBackgroundWithId:objectId block:^(PFObject *object, NSError *error) {
            if (!error) {
                [task setResult:object];
            } else {
                [task setError:error];
            }
        }];
        return task.task;
    }
    return [BFTask taskWithResult:nil];
}

+ (BFTask *) saveObjectAsync: (PFObject *)object
{
    if (object) {
        BFTaskCompletionSource *task = [BFTaskCompletionSource taskCompletionSource];
        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                [task setResult:object];
            }
            else {
                [task setError:error];
            }
        }];
        return task.task;
    }
    return [BFTask taskWithResult:nil];
}

+ (BFTask *) getData:(PFFile *)file
{
    if (file) {
        BFTaskCompletionSource *task = [BFTaskCompletionSource taskCompletionSource];
        [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (error) {
                [task setError:error];
            }
            else {
                [task setResult:data];
            }
        }];
        return task.task;
    }
    return [BFTask taskWithResult:nil];
}

+ (BFTask *) saveFile:(PFFile *)file
{
    if (file) {
        BFTaskCompletionSource *task = [BFTaskCompletionSource taskCompletionSource];
        [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                [task setError:error];
            }
            else {
                [task setResult:file];
            }
        }];
        return task.task;
    }
    else {
        return [BFTask taskWithResult:nil];
    }
}
+ (BFTask *) saveAllObjects:(NSArray *)objects
{
    if (objects.count) {
        BFTaskCompletionSource *task = [BFTaskCompletionSource taskCompletionSource];
        [PFObject saveAllInBackground:objects block:^(BOOL succeeded, NSError *error) {
            if (error) {
                [task setError:error];
            }
            else {
                [task setResult:objects];
            }
        }];
        return task.task;
    }
    return [BFTask taskWithResult:nil];
}
+ (BFTask *) countOfObjectsAsync:(PFQuery *)query
{
    if (query) {
        BFTaskCompletionSource *task = [BFTaskCompletionSource taskCompletionSource];
        [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
            if (error) {
                [task setError:error];
            }
            else {
                [task setResult:@(number)];
            }
        }];
        return task.task;
    }
    return [BFTask taskWithResult:nil];
}
+ (BFTask *) deleteObjectAsync:(PFObject *)object
{
    if (object) {
        BFTaskCompletionSource *task = [BFTaskCompletionSource taskCompletionSource];
        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                [task setError:error];
            }
            else {
                [task setResult:nil];
            }
        }];
    }
    return [BFTask taskWithResult:nil];
}

#pragma mark - Others
//+ (BFTask *) downloadDataFromURL:(NSURL *)url withCachePath:(NSString *)cachePath
//{
//    if (url && cachePath.length) {
//        BFTaskCompletionSource *task = [BFTaskCompletionSource taskCompletionSource];
//        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
//        NSURLSessionDownloadTask *imgTask = [manager downloadTaskWithRequest:request
//                                                                    progress:nil
//                                                                 destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//                                                                     NSURL *cachesDirectoryURL = [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject]; // iOS Caches directory
//                                                                     return [cachesDirectoryURL URLByAppendingPathComponent:cachePath];
//                                                                 } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//                                                                     NSLog(@"File downloaded to: %@", filePath);
//                                                                     NSData *newData = [NSData dataWithContentsOfFile:[filePath path]];
//                                                                     if (newData.length == 0) {
//                                                                         NSLog(@"Data did not download successfully.");
//                                                                         [task setError:error];
//                                                                     }
//                                                                     else {
//                                                                         [task setResult:newData];
//                                                                     }
//                                                                 }];
//        [imgTask resume];
//        return task.task;
//    }
//    return [BFTask taskWithResult:nil];
//}


@end
