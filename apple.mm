#import <Cocoa/Cocoa.h>

#include <stdio.h>

int AppleGetFreeSizeInMB(const char path[PATH_MAX])
{
    @autoreleasepool {
        NSString* dirpath = @(path);
        NSError *error;
        unsigned long long freeSpace = 0;

        if (@available(macOS 10.13, iOS 11.0, *)) {
            NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:dirpath];
            NSDictionary *results = [fileURL resourceValuesForKeys:@[NSURLVolumeAvailableCapacityForImportantUsageKey] error:&error];
            if(results) {
                NSNumber *availableImportantSpace  = results[NSURLVolumeAvailableCapacityForImportantUsageKey];
                freeSpace = availableImportantSpace.longLongValue;
            }
        }

        if(freeSpace == 0) {
            NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:dirpath
                                                                                                   error:&error];
            freeSpace = [[fileAttributes objectForKey:NSFileSystemFreeSize] longLongValue];
        }
        return (int)(freeSpace / (1024*1024));
    }
}
