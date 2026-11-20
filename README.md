# Four-part Eclipse Temurin tags

Minimal reproduction for [renovatebot/renovate#47083](https://github.com/renovatebot/renovate/discussions/47083).
Before Renovate 44.257.3, the `workarounds:javaLTSVersions` preset, part of `config:recommended`, couldn't parse four-part Eclipse Temurin tags such as `21.0.12.1_1-jdk-noble`.
[renovatebot/renovate#48252](https://github.com/renovatebot/renovate/pull/48252) fixed it in 44.257.3, and [renovatebot/renovate#48254](https://github.com/renovatebot/renovate/discussions/48254) has a workaround for older versions.

Temurin gives its out-of-band releases a fourth version part.
Docker Hub has 11 earlier such versions, the latest being `17.0.20.1_1`, `21.0.12.1_1` and `25.0.4.1_1`.
The fixes for CVE-2026-114938 ("java4shell") are four-part too: Temurin `17.0.21.1+2`, `21.0.13.1+2` and `25.0.5.1+2`.
Their images, such as `21.0.13.1_2-jdk-noble`, have been on Docker Hub since 2026-11-20, from [adoptium/containers#1133](https://github.com/adoptium/containers/pull/1133) and the `docker-library/official-images` PRs [#22808](https://github.com/docker-library/official-images/pull/22808), [#22809](https://github.com/docker-library/official-images/pull/22809), [#22810](https://github.com/docker-library/official-images/pull/22810) and [#22811](https://github.com/docker-library/official-images/pull/22811).

The `Dockerfile` has two stages, one four-part step apart: `three-part` uses `eclipse-temurin:21.0.12_8-jdk-noble`, and `four-part` uses `eclipse-temurin:21.0.12.1_1-jdk-noble`.

## Before Renovate 44.257.3

- `three-part`: Renovate offered `21.0.13_9-jdk-noble` (patch) and `25.0.5_8-jdk-noble` (major), but never a four-part tag.
  Even with `allowedVersions` limited to `21.0.12`, it didn't offer `21.0.12.1_1-jdk-noble`.
  It kept offering `21.0.13_9-jdk-noble` even after the CVE images were out, instead of the image with the fix.
- `four-part`: Renovate rejected the current value (`skipReason: invalid-value`) and offered no updates at all.
  The Dependency Dashboard didn't list it either, because it leaves out dependencies with a `skipReason`.

## Since Renovate 44.257.3

Both stages are offered `21.0.13.1_2-jdk-noble` (patch), the image with the CVE-2026-114938 fix, and `25.0.5.1_2-jdk-noble` (major).
The Dependency Dashboard lists both.
The Mend-hosted Renovate app shows this here: [PR 4](https://github.com/MPV/renovate-java-four-part-reproduction/pull/4), [PR 2](https://github.com/MPV/renovate-java-four-part-reproduction/pull/2) and the [Dependency Dashboard](https://github.com/MPV/renovate-java-four-part-reproduction/issues/3).

## Run it

```sh
LOG_LEVEL=debug npx renovate --platform=local --dry-run=lookup
```

The `packageFiles with updates` debug message lists each stage's updates, or its `skipReason`.
To see the behavior before the fix, run `npx renovate@44.249.1` instead.
