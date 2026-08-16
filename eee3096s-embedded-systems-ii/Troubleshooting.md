---
type: note
status: active
project: uct
course: EEE3096S
tags: [uct, embedded, stm32, course]
---

# CubeIDE troubleshooting

Collected from the course Amathuba pages (2026).

## Build error in stm32cubeide 1.19.0

Linker error mentioning `libc_nano.a(libc_a-writer.o)` under `/opt/st/stm32cubeide_1.19.0/plugins/...`:

![[cubeide-build-error-log.jpeg]]

![[cubeide-build-error-log-2.jpeg]]

Fixes, in order of effort:

1. Rebuild the project again. Works and by far the easiest.
2. Downgrade the GCC version for the IDE. CubeIDE 1.18+ defaults to GCC 13.2; install the older GCC from Toolchain Manager in CubeIDE and rebuild:

![[cubeide-gcc-toolchain-fix.jpeg]]

## STM32Cube firmware version conflict

Happens when opening the `.ioc` file. Select **Continue** to maintain compatibility. You can then edit the IOC file and regenerate code without errors.

## Importing prac folders into your CubeIDE workspace

The Amathuba page only had a video (not downloadable). Watch it on the course page under the prac section if needed.
