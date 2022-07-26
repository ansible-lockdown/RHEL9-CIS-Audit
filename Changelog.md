# Changes to RHEL9-CIS-Audit

## 0.3

- many updates and fixes
  - mountpoint updates
  - regex and search improvements
  - greater consistency on control report
  - tested and working on rockylinux


## 0.2

- not all controls work with rhel8 releases any longer
  - selinux disabled 1.6.1.4
  - logrotate - 4.3.x

- aligned with rh8 v2.0
- removed iptables (npt valid on rhel9)
- logrotate extended as seperate package
- 1.6.1.4 - selinux disabled via config file no longer valid checked via boot in 1.6.1.2

## Initial

- Development testing only - not yet GA
- Based on RH8 CIS 1.0.1
