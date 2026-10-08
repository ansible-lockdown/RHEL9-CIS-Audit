# Changes to RHEL9-CIS-Audit

## Sept 2026 - benchmark v3.0.0

- BENCHMARK_VER 3.0.0
- run_audit.sh uses syver v0.13.0 by default
- README describes syver
- 5.1.3-5.1.7, 5.1.9, 5.1.18 sshd -T directive match case-insensitive
- .gitignore aligned to the Lockdown reference set
- goss files renumbered and moved to the v3.0.0 section folders
- retired control files removed
- new control files added
- goss.yml and standalone.yml globs rewritten for the v3.0.0 layout
- section 4 firewalld only
- journald 6.1.1.x tests added
- 6.2.3.x audit rule tests split per control
- 3.3.x sysctl tests use the effective systemd-sysctl value
- sshd tests assert sshd -T output only
- 1.7.x combined banner file split per control
- vars - rule toggles regenerated in v3.0.0 order
- vars - rhel9cis_syslog, nis and xinetd variables removed
- vars - cockpit, rsyslog TLS and rhel9cis_system_is_log_server added
- vars - rhel9cis_aide_scan timer
- 2.1.11, 2.2.3, 2.2.4 workstation meta corrected
- 6.1.2.3 accepts grep exit 2 when /etc/rsyslog.d is empty
- tests the role is told not to remediate report skipped - disruption_high, allow_authselect_updates, authselect_pkg_update, crypto_policy_ansiblemanaged, selinux_enforce, config_aide
- 5.4.1.1, 5.4.1.2 existing-user tests skipped unless force_user_maxdays / force_user_mindays
- 1.1.2.1.2-4 check tmp.mount when rhel9cis_tmp_svc
- 5.4.2.7 excludes rhel9cis_system_users_shell accounts
- vars - 10 remediation gate variables added
- 5.3.3.3.3 system-auth test indentation fixed
- LICENSE company name MindPoint Group - A Quantum Sky Company
- meta NIST800-53R5 aligned to the remediation role
- meta NIST800-53R5 NA placeholders replaced
- meta CCI added from the v3.0.0 benchmark references
- 1.1.2.1.2-4 check the persistent /tmp options from the source systemd reports
- vars - rhel9cis_tmp_svc removed

## Based on CIS Benchmark v2.0.0
## Oct 2026 - backlog fixes

- company name MindPoint Group - A Quantum Sky Company
- 5.1.9-5.1.22 sshd -T checks case-insensitive
- 2.1.8 cyrus-imapd package name corrected
- 5.4.1.2 user check reports only accounts with min days below 1
- 6.2.3.3 checks ForwardToSyslog=yes and accepts the grep exit codes
- 5.1.3 public key perms check echoes the right variable
- 5.1.2 private key group check parentheses escaped for find
- 7.2.4-7.2.7 duplicate checks sort before uniq
- 1.2.1.3 repo check reads /etc/yum.repos.d

## Sept 2026 - QA pass

- 1.7.x combined tests now gate on either paired toggle, not just the first
- 1.7.4, 1.7.5, 1.7.6 titles aligned to the v2.0.0 benchmark wording
- vars - rhel9cis_pass_min_days 1 -> 7 and rhel9cis_authselect_custom_profile_create false -> true to match remediation defaults
- 1.2.1.3 gate now matches the remediation gate - rule toggle AND enable_repogpg AND not rhel_default_repo
- vars - rhel9cis_rhel_default_repo added
- 4.3.3 exit-status accepts 0 or 1 - the test could never pass, a correctly hardened host made grep exit 1

## Aug 2026 — QA pass: section 1.8 coverage, gate polarity and value alignment

- 1.8 gui based updates readdressed and fixed
- 2.4.3.x - seperated tests to a file each
- 5.3.3.3.3.yml layout fixed
- 5.1.16.yml updated test module
- vars updated defaults to match remediation - typos updated
- README updates and updated contributing and contributors

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
