#include <iostream>
#include <string>


#if defined(_WIN32)
// desktop win32 software
#include "Windows.h"

int GetFreeSizeInMB(const std::string &path)
{
    const uint64_t MB = 1024 * 1024;
    uint64_t freeBytes;
    LPCSTR p = path.c_str();
    if(GetDiskFreeSpaceExA (p, (PULARGE_INTEGER)&freeBytes,
                                   nullptr,
                                   nullptr) != 0)
    {
        return static_cast<int>(freeBytes / MB);
    }

    return 0;
}
#elif defined(__APPLE__)
// I am assuming macOS here
extern int AppleGetFreeSizeInMB(const char path[PATH_MAX]);

int GetFreeSizeInMB(const std::string &path)
{
    return AppleGetFreeSizeInMB(path.c_str());
}
#else
// assume Linux for now
#include <unistd.h>
#include <sys/statvfs.h>

unsigned long rounddiv(unsigned long num, unsigned long divisor) {
    return (num + (divisor/2)) / divisor;
}

int GetFreeSizeInMB(const std::string &path)
{
    struct statvfs diskData{};
    statvfs(path.c_str(), &diskData);
    unsigned long available = diskData.f_bavail * diskData.f_bsize;
    if(access(path.c_str(), W_OK) == 0) {
        // only returns value in writeable dir
        return static_cast<int>(rounddiv(available, 1024*1024));
    } else {
        return 0;
    }
}
#endif

int main(int argc, char *argv[]) {
    std::string path = ".";
    if (argc > 1) { path = argv[1]; }
    int freeSizeMb = GetFreeSizeInMB(path);
    std::string val = std::to_string(freeSizeMb);

    std::cout << "Free size is: " << val<< " MB.\n" << "In path: '" << path << "'." << std::endl;
    return 0;
}
