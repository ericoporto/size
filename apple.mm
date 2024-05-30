#import <Cocoa/Cocoa.h>

#include <stdio.h>

int freeDiskspace(const char path[PATH_MAX])
{
    @autoreleasepool {
        NSString* dirpath = @(path);
        NSError *error;
        NSDictionary* fileAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:dirpath
                                                                                               error:&error];
        unsigned long long freeSpace = [[fileAttributes objectForKey:NSFileSystemFreeSize] longLongValue];
        return (int)(freeSpace / (1024*1024));
    }
}
