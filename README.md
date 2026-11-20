# Four-part Eclipse Temurin tags

Minimal reproduction for `renovatebot/renovate#47083`.
The `workarounds:javaLTSVersions` preset, part of `config:recommended`, can't parse four-part Eclipse Temurin tags such as `17.0.4.1_1-jdk-jammy`.

Temurin gives its out-of-band releases a fourth version part.
The November 2026 fixes for CVE-2026-114938 are such releases: `17.0.21.1+2`, `21.0.13.1+2` and `25.0.5.1+2`.

## Current behavior

The `Dockerfile` has two stages:

- `three-part` uses `eclipse-temurin:17.0.4_8-jdk-jammy`.
  Renovate offers `17.0.21_9-jdk-jammy` (patch) and `25.0.5_8-jdk-jammy` (major), but never a four-part tag.
  Even with `allowedVersions` limited to `17.0.4`, it doesn't offer `17.0.4.1_1-jdk-jammy`.
- `four-part` uses `eclipse-temurin:17.0.4.1_1-jdk-jammy`.
  Renovate rejects the current value (`skipReason: invalid-value`) and offers no updates at all.

## Expected behavior

- `three-part`: four-part tags count as versions, so a release such as `17.0.21.1_2-jdk-jammy` is offered once it is on Docker Hub.
- `four-part`: Renovate offers the same updates as for `three-part`: `17.0.21_9-jdk-jammy` (patch) and `25.0.5_8-jdk-jammy` (major).

## Run it

```sh
LOG_LEVEL=debug npx renovate --platform=local --dry-run=lookup
```

The `packageFiles with updates` debug message lists each stage's updates, or its `skipReason`.
