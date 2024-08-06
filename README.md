# waitaha

waitaha is a recovery environment for Android devices with a close-to-mainline kernel and based on buildroot.

## Building

Clone the repository, initialize all submodules and then run:

```
make $DEVICENAME -j$(nproc)
```

For example, `make davinci -j$(nproc)` will build davinci and use all available CPU cores.

The resulting recovery file is in `out/recovery.img` and can be flashed/booted via fastboot.

## Adding a device

See [ADDING_A_DEVICE.md](ADDING_A_DEVICE.md).

## License

waitaha is GPL-licensed.

## The big ToDo-list

- [ ] Make SSH host keys not change on every reboot (set a fixed seed that is generated at build time?)
- [ ] Look into input event handling (power button somehow crashes the app?)
- [ ] Decent UI with a nice menu
  - [ ] Menu for configuring WiFi password
  - [ ] Menu for persistent settings (e.g. choose a partition to write settings to, as file or raw, cust is a great option here)
  - [ ] Menu for mounting partitions
