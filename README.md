
# RHEL 9 Goss config

## Overview

based on CIS 1.0.0

Ability to audit a system using a lightweight binary to check the current state.

This is:

- very small 11MB
- lightweight
- self contained

It works using a set of configuration files and directories to audit STIG of RHEL/CentOS 7 servers. These files/directories correlate to the STIG Level and STIG_ID

Tested on

- RHEL9
- Rocky9
- AlmaLinux 9
- Oraclelinux 9

## Requirements

You must have [goss](https://github.com/goss-org/goss/) available to your host you would like to test.

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

## Join us

On our [Discord Server](https://www.lockdownenterprise.com/discord) to ask questions, discuss features, or just chat with other Ansible-Lockdown users

Set of configuration files and directories to run the first stages of CIS of RHEL 9 servers

This is configured in a directory structure level.

Goss is run based on the goss.yml file in the top level directory. This specifies the configuration.

## further information

- [goss documentation](https://github.com/aelsabbahy/goss/blob/master/docs/manual.md#patterns)
- [CIS standards](https://www.cisecurity.org)
