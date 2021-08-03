#include <windows.h>
#define WIN32_LEAN_AND_MEAN

BOOL WINAPI DllMain(
    HINSTANCE hinstDLL,  // handle to DLL module
    DWORD fdwReason,     // reason for calling function
    LPVOID lpReserved )  // reserved
{
    // Initialize once for each new process.
    if ( fdwReason ==  DLL_PROCESS_ATTACH ) 
    {
        // disbale COR_PROFILER by setting environment variable
        SetEnvironmentVariable("COR_ENABLE_PROFILING","0");
    }
    return TRUE;
}
