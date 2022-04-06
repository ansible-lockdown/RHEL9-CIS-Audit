# Development Only

## RHEL 9 CIS (predicted) - ALPHA - CIS baselines or OS not yet GA

## Testing if you have access to the RH developer branches

---

# RHEL 8 Goss config

## Overview

based on RedHat 8 CIS 2.0.0

Set of configuration files and directories to run the first stages of CIS of RHEL 9 servers

This is configured in a directory structure level.

This could do with further testing but sections 1.x should be complete

Goss is run based on the goss.yml file in the top level directory. This specifies the configuration.

## Requirements

You must have [goss](https://github.com/aelsabbahy/goss/) available to your host you would like to test.

You must have sudo/root access to the system as some commands require privilege information.

Assuming you have already clone this repository you can run goss from where you wish.

Please refer to the audit documentation for usage.

- [Audit Documents](https://github.com/ansible-lockdown/RHEL9-CIS-Audit/docs/Security_remediation_and_auditing.md)

This also works alongside the [Ansible Lockdown RHEL9-CIS role](https://github.com/ansible-lockdown/RHEL9-CIS)

Which will:

- install
- audit
- remediate
- audit

## variables

file: vars/CIS.yml

Please refer to the file for all options and their meanings

CIS listed variable for every control/benchmark can be turned on/off or section

- other controls
enable_selinux
run_heavy_tasks

- bespoke options
If a site has specific options e.g. password complexity these can also be set.

## Usage

You must have [goss](https://github.com/aelsabbahy/goss/) available to your host you would like to test.

You must have root access to the system as some commands require privilege information.

- Run as root not sudo due to sudo and shared memory access

Assuming you have already clone this repository you can run goss from where you wish.

- full check

```sh
# {{path to your goss binary}} --vars {{ path to the vars file }} -g {{path to your clone of this repo }}/goss.yml --validate

```

example:

```sh
# /usr/local/bin/goss --vars ../vars/cis.yml -g /home/bolly/rh8_cis_goss/goss.yml validate
......FF....FF................FF...F..FF.............F........................FSSSS.............FS.F.F.F.F.........FFFFF....

Failures/Skipped:

Title: 1.6.1 Ensure core dumps are restricted (Automated)_sysctl
Command: suid_dumpable_2: exit-status:
Expected
    <int>: 1
to equal
    <int>: 0
Command: suid_dumpable_2: stdout: patterns not found: [fs.suid_dumpable = 0]


Title: 1.4.2 Ensure filesystem integrity is regularly checked (Automated)
Service: aidecheck: enabled:
Expected
    <bool>: false
to equal
    <bool>: true
Service: aidecheck: running:
Expected
    <bool>: false
to equal
    <bool>: true

< ---------cut ------- >

Title: 1.1.22 Ensure sticky bit is set on all world-writable directories
Command: version: exit-status:
Expected
    <int>: 0
to equal
    <int>: 123

Total Duration: 5.102s
Count: 124, Failed: 21, Skipped: 5

```

- running a particular section of tests

```sh
# /usr/local/bin/goss -g /home/bolly/rh8_cis_goss/section_1/cis_1.1/cis_1.1.22.yml  validate
............

Total Duration: 0.033s
Count: 12, Failed: 0, Skipped: 0

```

- changing the output

```sh
# /usr/local/bin/goss -g /home/bolly/rh8_cis_goss/section_1/cis_1.1/cis_1.1.22.yml  validate -f documentation
Title: 1.1.20 Check for removeable media nodev
Command: floppy_nodev: exit-status: matches expectation: [0]
Command: floppy_nodev: stdout: matches expectation: [OK]
< -------cut ------- >
Title: 1.1.20 Check for removeable media noexec
Command: floppy_noexec: exit-status: matches expectation: [0]
Command: floppy_noexec: stdout: matches expectation: [OK]


Total Duration: 0.022s
Count: 12, Failed: 0, Skipped: 0
```

## Extra settings

Ability to add your own requirements is available in several sections

## further information

- [goss documentation](https://github.com/aelsabbahy/goss/blob/master/docs/manual.md#patterns)
- [CIS standards](https://www.cisecurity.org)
