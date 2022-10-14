# Development Only

***RHEL 9 CIS (predicted) - ALPHA - CIS baselines or OS not yet GA***

***Testing if you have access to the RH developer branches***

---

## RHEL 9 Goss config

## Overview

based on RedHat 8 CIS 2.0.0

Set of configuration files and directories to run the first stages of CIS of RHEL 9 servers

This is configured in a directory structure level.

Goss is run based on the goss.yml file in the top level directory. This specifies the configuration.

## Requirements

You must have [goss](https://github.com/aelsabbahy/goss/) available to your host you would like to test.

You must have sudo/root access to the system as some commands require privilege information.

Assuming you have already clone this repository you can run goss from where you wish.

Please refer to the audit documentation for usage.

- [readthedocs](https://ansible-lockdown.readthedocs.io/en/latest/)

This also works alongside the [Ansible Lockdown RHEL9-CIS role](https://github.com/ansible-lockdown/RHEL9-CIS)

Which will:

- install
- audit
- remediate
- audit

## further information

- [goss documentation](https://github.com/aelsabbahy/goss/blob/master/docs/manual.md#patterns)
- [CIS standards](https://www.cisecurity.org)
