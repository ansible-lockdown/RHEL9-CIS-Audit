# Changes to RHEL9-CIS-Audit

## Aug 2026 — QA pass: section 1.8 coverage, gate polarity and value alignment

- 1.8 gui based updates readdressed and fixed
- 2.4.3.x - seperated tests to a file each
- 5.3.3.3.3.yml layout fixed
- 5.1.16.yml updated test module
- vars updated defaults to match remediation - typos updated

## June 2026 — QA pass: audit alignment and hygiene fixes

- Fixed LICENSE copyright casing: Mindpoint -> MindPoint
- Added CONTRIBUTING.rst
- Fixed NFS/RPC/NIS server defaults to match remediation role: nfs_server, rpc_server, nis_server now false (were true)
- Added missing rhel9cis_rule_enable_repogpg toggle to vars/CIS.yml (1.2.1 GPG repo check)
- run_audit.sh:
  - replaced os_vendor/os_maj_ver runtime OS detection with direct BENCHMARK_OS variable
  - updated vars discovery
- Updated links that the audit comes from goss-org moved to krameff

## 2.0.0 - March 2026 — benchmark alignment

- title updates
- level alignments
- yaml headers
- common files updates

## 2.0.0 - based on CIS v2.0.0 - Feb26 QA updates

- README.md corrected: updated references from STIG/RHEL 7 to CIS/RHEL 9, fixed grammar and spelling
- Fixed spelling errors across repo: recieve->receive, seperate->separate, controling->controlling, setings->settings
- Fixed wrong CIS control IDs: 7.1.3 (was 6.1.3), 7.1.6 (was 7.1.7), including rule variable references and metadata
- Fixed incorrect title text: 1.5.2 (was ASLR, corrected to ptrace_scope), 5.4.1.4 (was warning days, corrected to hashing algorithm), 5.3.3.1.3 (was unlock time, corrected to root lockout)
- Fixed title formatting: added missing pipe separators, fixed spacing around pipes, standardized _user/_group to | user/| group format
- vars/CIS.yml: fixed comment typos (mincall->minclass, This are->These are, section number 5.4.2->5.4.3, extra space in 6.2.3.x)
- YAML lint fixes: removed leading blank lines, extra blank lines, fixed colon spacing, added missing document start markers
- Changelog.md: fixed historical typos and grammar
- removed rhel9cis_rule_5_3_3_2_8

## 1.0.7 - based on CIS v1.0.0 - Feb26 updates

License date updated
Thanks to @St0ne-dot-at
- 1.2.1.2 - fixed typo
- 7.1.11/12/13 - fixed tests

## 1.0.6

Thanks to @draygoX
- [#71](https://github.com/ansible-lockdown/RHEL9-CIS-Audit/issues/71)
- [#72](https://github.com/ansible-lockdown/RHEL9-CIS-Audit/issues/72)

## 1.0.5 - Updated to use goss > 0.4 - based on CIS v1.0.0

- updated ssh config to use more file module
- all file module test set to use new layout with path

## 1.0.4 updates and script - based on CIS v1.0.0

- multiple tests updates
- linting on spaces
- update of the run_audit script to include version check of goss binary

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
Aligned with remediation role

## 1.0 Based upon CIS 1.0.0 official release

Aligned with remediation role

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
- removed iptables (not valid on RHEL 9)
- logrotate extended as separate package
- 1.6.1.4 - selinux disabled via config file no longer valid checked via boot in 1.6.1.2

## Initial

- Development testing only - not yet GA
- Based on RH8 CIS 1.0.1
