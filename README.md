# fluent-bit-in-mem2

Core [in_mem](https://github.com/fluent/fluent-bit/tree/master/plugins/in_mem) modified to include MemAvailable (from /proc/meminfo)


the `sysinfo` syscall exposes `si_meminfo` from the kernel but `MemAvailable` is calculated by `si_mem_available` and not exposed in any syscall, only in `/proc/meminfo` ([kernel meminfo src](https://github.com/torvalds/linux/blob/master/fs/proc/meminfo.c#L58)

The `free` command, part of procps, parses `/proc/meminfo` - [free](https://gitlab.com/procps-ng/procps/-/blob/master/free.c#L349) calls [meminfo](https://gitlab.com/procps-ng/procps/-/blob/master/proc/sysinfo.c#L698) function that [parses it](https://gitlab.com/procps-ng/procps/-/blob/master/proc/sysinfo.c#L748)

To avoid adding libprocps as dependency, I chose to copy&paste [busybox implementation](https://github.com/mirror/busybox/blob/master/procps/free.c) - also parses `/proc/meminfo` but the piece of code that does the parsing is small and easy to port.

## Note

[Pending pull-request](https://github.com/fluent/fluent-bit/pull/3092)
