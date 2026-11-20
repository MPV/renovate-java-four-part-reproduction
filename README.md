# Four-part Eclipse Temurin tags

Minimal reproduction for `renovatebot/renovate#47083`.
The `workarounds:javaLTSVersions` preset, part of `config:recommended`, can't parse four-part Eclipse Temurin tags such as `21.0.12.1_1-jdk-noble`.

Temurin gives its out-of-band releases a fourth version part.
Docker Hub has 11 such versions so far, the latest being `17.0.20.1_1`, `21.0.12.1_1` and `25.0.4.1_1`.
The fixes for CVE-2026-114938 ("java4shell") are next: Temurin `17.0.21.1+2`, `21.0.13.1+2` and `25.0.5.1+2`.
Their images, such as `17.0.21.1_2-jdk-jammy` and `25.0.5.1_2-jdk-resolute`, are in [adoptium/containers#1133](https://github.com/adoptium/containers/pull/1133) and wait on the `docker-library/official-images` PRs [#22808](https://github.com/docker-library/official-images/pull/22808), [#22809](https://github.com/docker-library/official-images/pull/22809), [#22810](https://github.com/docker-library/official-images/pull/22810) and [#22811](https://github.com/docker-library/official-images/pull/22811).

## Current behavior

The `Dockerfile` has two stages, one four-part step apart:

- `three-part` uses `eclipse-temurin:21.0.12_8-jdk-noble`.
  Renovate offers `21.0.13_9-jdk-noble` (patch) and `25.0.5_8-jdk-noble` (major), but never a four-part tag.
  Even with `allowedVersions` limited to `21.0.12`, it doesn't offer `21.0.12.1_1-jdk-noble`.
- `four-part` uses `eclipse-temurin:21.0.12.1_1-jdk-noble`.
  Renovate rejects the current value (`skipReason: invalid-value`) and offers no updates at all.
  The Dependency Dashboard doesn't list it either, because it leaves out dependencies with a `skipReason`.

## Expected behavior

- `three-part`: four-part tags count as versions, so a release such as `21.0.13.1_2-jdk-noble` is offered once it is on Docker Hub.
- `four-part`: Renovate offers the same updates as for `three-part`: `21.0.13_9-jdk-noble` (patch) and `25.0.5_8-jdk-noble` (major).

## Run it

```sh
LOG_LEVEL=debug npx renovate --platform=local --dry-run=lookup
```

The `packageFiles with updates` debug message lists each stage's updates, or its `skipReason`.
