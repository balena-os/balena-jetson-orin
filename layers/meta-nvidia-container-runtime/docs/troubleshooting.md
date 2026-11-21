# Troubleshooting

## Extension installed but nothing merged after reboot

This is the failure mode the layer is most designed against, because **the install
exits 0 and nothing looks wrong**.

```sh
journalctl -b | grep -i mobynit     # "No extensions compatible with running kernel"
                                    #  => module content leaked into the image
journalctl -u balena-nvidia-setup   # the boot oneshot
balena-engine images                # is the extension image still there?
balena-engine ps -a                 # is the extension container present?
```

If mobynit reports incompatibility, kernel module content reached the rootfs. See
[rootfs-assembly.md](rootfs-assembly.md#strip_kernel_modules). The build should have
caught it — `assert_no_kernel_modules` exists precisely so this fails loudly at
build time.

## Runtime present but containers see no GPU

```sh
grep -A3 '"nvidia"' /etc/docker/daemon.json
grep runtimes /run/nvidia-container-runtime/config.toml   # must list balena-runc
grep mode /run/nvidia-container-runtime/config.toml       # must be csv
balena-engine info | grep -i -A3 runtime
```

- Missing `balena-runc` in the candidate list → the hook fails with
  `no runtime binary found from candidate list: [docker-runc runc crun]`.
- `mode` not `csv` → the CSVs are never read and nothing is mounted. `auto`
  resolves to NVML because the extension ships `libnvidia-ml`.

## Camera capture fails

Check in this order — the container-side error is actively misleading:

```sh
ls -l /dev/video0                             # kernel-side: is the sensor there at all?
systemctl is-active nvargus-daemon
journalctl -u nvargus-daemon                  # the only place the real cause appears
ls /var/nvidia/nvcam/settings/*.nito          # ISP tuning data survived the /var strip
```

`Connection refused` on the Argus socket from inside a container usually means
`nvargus-daemon` **crashed and was restarted** — most often because
`/var/nvidia/nvcam/settings` is missing, which makes it SIGABRT on client connect.

All four camera fixes must be present together; none produces a visible change
alone. See [rootfs-assembly.md](rootfs-assembly.md#the-four-camera-fixes).

## Known traps

- **`/etc/nvidia-container-runtime/host-files-for-container.d/` is read-only on
  balenaOS 7.0+.** CSVs cannot be patched at runtime; change them in the recipe.
- **A green build is not evidence your change ran.** `do_image` does not always
  re-run after a recipe-function edit. Force it with
  `-b "-C do_rootfs"` and verify the artifact's timestamp before concluding a fix
  did not work.
- **Side-loaded extensions vanish after a HUP.** Expected — see
  [os-version.md](os-version.md).

## Looks identical to a bricked device, but is not

balenaOS has an upstream systemd ordering cycle that can drop `var-volatile.mount`
on any boot:

```sh
journalctl -b | grep "deleted to break"
```

Check that before blaming the extension.
