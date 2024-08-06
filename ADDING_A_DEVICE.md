# Adding a new device

The steps for adding a new device are as follows:

* Add a directory for your device in `waitaha-br2-external/board` with the codename, e.g. `davinci`
* Inside the directory, add a file called `configs` which contains a list of config fragments to use, like so:
```
sm7150
davinci
```
* Then, add the config fragments in `waitaha-br2-external/configs`. The names must be the same as in your `configs` file, but suffixed with `_defconfig`
* Optionally, create a firmware package in `waitaha-br2-external/package`

## Debugging

You may add the `debug` fragment to your `configs` file to install some utilities for debugging into the initramfs.

## Kernel requirements

Qualcomm kernels should take note to enable `CONFIG_QRTR` and support the in-kernel pd-mapper implementation. WiFi requires both the in-kernel `qrtr-ns` and `pd-mapper`.
