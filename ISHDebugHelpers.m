//
//  ISHDebugHelpers.m
//  Cashier
//
//  Created by Felix Schneider on 26.11.12.
//  Copyright (c) 2012 iosphere GmbH. All rights reserved.
//

#import "ISHDebugHelpers.h"

@implementation ISHDebugHelpers

+ (NSString *)debugHelpersBasePath {
    return [NSTemporaryDirectory () stringByAppendingPathComponent:@"current"];
}

+ (NSString *)debugHelpersScreenshotPath {
    return [[self debugHelpersBasePath] stringByAppendingPathComponent:@"Screenshots"];
}

+ (NSString *)debugHelpersArchivePath {
    return [[self debugHelpersBasePath] stringByAppendingPathComponent:@"current.zip"];
}

+ (void)debugHelpersSetup {
    NSString *debugUUID = [[[NSProcessInfo processInfo] environment] objectForKey:@"ISH_DEBUG_UUID"];

    if (![debugUUID length]) {
        debugUUID = [NSString stringWithFormat:@"%ld", time(NULL)];
    }

    [[NSUserDefaults standardUserDefaults] setObject:debugUUID forKey:@"ISHDebugUUID"];

    NSLog(@"debug UUID= %@", debugUUID);
    NSString *dumpBasePath = [NSString stringWithFormat:@"%@/testing/", NSTemporaryDirectory()];

#if !TARGET_IPHONE_SIMULATOR
        [[NSFileManager defaultManager] removeItemAtPath:dumpBasePath error:nil];
        [[NSFileManager defaultManager] removeItemAtPath:[NSTemporaryDirectory () stringByAppendingString:@"/current.zip"] error:nil];
#endif

    NSString *targetDir = [dumpBasePath stringByAppendingPathComponent:[[NSUserDefaults standardUserDefaults] objectForKey:@"ISHDebugUUID"]];
    [[NSFileManager defaultManager] createDirectoryAtPath:dumpBasePath withIntermediateDirectories:YES attributes:nil error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:[dumpBasePath stringByAppendingPathComponent:@"current"] error:nil];
    [[NSFileManager defaultManager] createDirectoryAtPath:[targetDir stringByAppendingPathComponent:@"Screenshots"] withIntermediateDirectories:YES attributes:nil error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:[NSTemporaryDirectory () stringByAppendingPathComponent:@"current"] error:nil];
    [[NSFileManager defaultManager] createSymbolicLinkAtPath:[NSTemporaryDirectory () stringByAppendingPathComponent:@"current"] withDestinationPath:targetDir error:nil];
}

@end
