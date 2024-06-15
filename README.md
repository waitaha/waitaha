# waitaha

waitaha is a recovery environment for Android devices with a close-to-mainline kernel and based on buildroot.

## Building

Clone the repository, initialize all submodules and then run

```
make $DEVICENAME  # For example, "make davinci"
```

The resulting recovery file is in `out/recovery.img` and can be flashed/booted via fastboot.

## Adding a device

See [ADDING_A_DEVICE.md](ADDING_A_DEVICE.md).

## License

waitaha is GPL-licensed.
