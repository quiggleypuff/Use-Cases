ifeq ($(origin CC),default)
	CC="x86_64-w64-mingw32-gcc"
endif

build:
	$(CC) -o DisableCorProfiler.dll -shared dllmain.c

clean:
	rm -f DisableCorProfiler.dll
