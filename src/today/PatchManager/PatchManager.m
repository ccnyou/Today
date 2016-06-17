//
//  PatchManager.m
//  today
//
//  Created by ervinchen on 16/6/17.
//  Copyright © 2016年 ccnyou. All rights reserved.
//

#import "PatchManager.h"
#import "JPEngine.h"
#import "Constant.h"
#import "AFNetworking.h"

@implementation PatchManager

+ (id)sharedInstance {
    static PatchManager* sharedInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedInstance = [[PatchManager alloc] init];
    });
    
    return sharedInstance;
}

- (void)initialize {
    [self _startEngine];
    [self _executeCachedPatch];
    [self _updatePatchCache];
}

- (void)_startEngine {
    [JPEngine startEngine];
}

- (NSString *)_documentPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

- (void)_executeCachedPatch {
    NSString* patchFilePath = [self _patchFilePath];
    NSString* script = [NSString stringWithContentsOfFile:patchFilePath encoding:NSUTF8StringEncoding error:nil];
    if (script.length > 0) {
        [JPEngine evaluateScript:script];
    }
}

- (NSString *)_patchFilePath {
    NSString* documentPath = [self _documentPath];
    NSString* patchFilePath = [documentPath stringByAppendingPathComponent:@"patch.js"];
    return patchFilePath;
}

- (void)_updatePatchCache {
    NSInteger random = arc4random_uniform(10);
    NSString* build = [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey];
    NSString* version = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    NSString* patchUrl = [NSString stringWithFormat:@"%@/jspatch/%@/%@.js?v=%@", SERVER_URL, version, build, @(random)];
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    AFHTTPResponseSerializer* serializer = [AFHTTPResponseSerializer serializer];
    NSSet* set = serializer.acceptableContentTypes;
    set = [set setByAddingObject:@"text/plain"];
    serializer.acceptableContentTypes = set;
    manager.responseSerializer = serializer;
    
    [manager GET:patchUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData* data = responseObject;
        if ([data isKindOfClass:[NSData class]]) {
            NSString* patchFilePath = [self _patchFilePath];
            [data writeToFile:patchFilePath atomically:YES];
            NSLog(@"%s %d path js updated", __FUNCTION__, __LINE__);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%s %d error = %@", __FUNCTION__, __LINE__, error);
    }];
}

@end
