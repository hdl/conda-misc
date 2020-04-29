@echo on

pkg-config --cflags python

make
make install PREFIX=%PREFIX%

make pylibfdt EXTRA_CFLAGS='-Wno-error=cast-qual -Wno-error=missing-prototypes -Wno-error=shadow'
make install_pylibfdt EXTRA_CFLAGS='-Wno-error=cast-qual -Wno-error=missing-prototypes -Wno-error=shadow' PREFIX=%PREFIX%
