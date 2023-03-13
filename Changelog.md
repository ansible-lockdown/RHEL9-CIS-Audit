# Changes to RHEL9-CIS-Audit

## 1.0.2

- Oracle linux support added
- updates to 5.3.7 sugroup

## 1.0.1 improvements to sshd

Allow option to set sshd_config file
aligned with remediate

## 1.0 Based upon CIS 1.0.0 official release

aligned with remediate

## 0.3 CIS - v1.0.0

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
