# Three-part tag: Renovate offers updates, but never a four-part tag such as 17.0.4.1_1.
FROM eclipse-temurin:17.0.4_8-jdk-jammy AS three-part

# Four-part tag: Renovate rejects the current value as invalid and offers no updates at all.
FROM eclipse-temurin:17.0.4.1_1-jdk-jammy AS four-part
