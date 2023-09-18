# Changes to RHEL9-CIS-Audit

## 1.0.5 updated to use goss > 0.4. - based on CIS v1.0.0

- updated ssh config to use more file module
- all file module test set to use new layout with path

## 1.0.4 updates and script - based on CIS v1.0.0

- multiple tests updates
- linting on spaces
- update of the run_audit script include version check of goss binary

## 1.0.3 sept23_updates - based on CIS v1.0.0

- [#22](https://github.com/ansible-lockdown/RHEL9-CIS-Audit/issues/22)
- [#23](https://github.com/ansible-lockdown/RHEL9-CIS-Audit/issues/23)
- [#24](https://github.com/ansible-lockdown/RHEL9-CIS-Audit/issues/24)

## 1.0.2

- Oracle linux support added
- updates to 5.3.7 sugroup
- vars 5.1.9 added thanks to @tpaiii3 [#18](https://github.com/ansible-lockdown/RHEL9-CIS-Audit/issues/18)
  - run_audit typo script resolved

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
