# Three-part tag: Renovate offers updates, but never a four-part tag such as 21.0.12.1_1.
FROM eclipse-temurin:21.0.12_8-jdk-noble AS three-part

# Four-part tag: Renovate rejects the current value as invalid and offers no updates at all.
FROM eclipse-temurin:21.0.12.1_1-jdk-noble AS four-part
