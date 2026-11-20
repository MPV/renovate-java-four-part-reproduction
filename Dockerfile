# Three-part tag: before Renovate 44.257.3, updated but never to a four-part tag such as 21.0.13.1_2.
FROM eclipse-temurin:21.0.12_8-jdk-noble AS three-part

# Four-part tag: before Renovate 44.257.3, rejected as invalid, with no updates at all.
FROM eclipse-temurin:21.0.12.1_1-jdk-noble AS four-part
