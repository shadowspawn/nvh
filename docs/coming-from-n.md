# Coming from `tj/n`

There are a lot of changes from `tj/n`. Taking advantage of a fresh start.

Some tips on the things that are gone.

## Changed

- `n <version>` --> `nvh i[nstall] <version>`
- `n --lts` --> `nvh lsr lts`
- `n --latest` --> `nvh lsr latest`
- `n use` and `n as` --> `nvh run`
- always install, even if installed version appears to match
- allow removing installed version
- using `rsync` rather than `cp` for installs

## Removed

- `n bin` alias
- `n -` alias
- `stable` version label
- explicit iojs support
- `--download` option
- `--arch` option
