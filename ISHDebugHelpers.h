//
//  ISHDebugHelpers.h
//  Cashier
//
//  Created by Felix Schneider on 26.11.12.
//  Copyright (c) 2012 iosphere GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#if defined DEBUG || RUN_KIF_TESTS 
@interface ISHDebugHelpers : NSObject
+ (NSString *)debugHelpersBasePath;
+ (NSString *)debugHelpersScreenshotPath;
+ (NSString *)debugHelpersArchivePath;
+ (void)debugHelpersSetup;
@end
#endif
