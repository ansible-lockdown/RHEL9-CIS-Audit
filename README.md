
# RHEL 9 Syver config

## Overview

Based on CIS 3.0.0

Ability to audit a system using a lightweight binary to check the current state.

This is:

- very small
- lightweight
- self-contained

It works using a set of configuration files and directories to audit CIS benchmarks of RHEL 9 servers. These files/directories correlate to the CIS level and CIS control ID.

Tested on

- RHEL 9
- Rocky 9
- AlmaLinux 9
- Oracle Linux 9

## Requirements

You must have [syver](https://github.com/krameff/syver) >= 0.13.0 available on the host you would like to test. The audit
content uses the goss file format, which syver reads unchanged.

You must have sudo/root access to the system, as some commands require elevated privileges.

Assuming you have already cloned this repository, you can run syver from where you wish.

Please refer to the audit documentation for usage.

- [readthedocs](https://ansible-lockdown.readthedocs.io/en/latest/)

This also works alongside the [Ansible Lockdown RHEL9-CIS role](https://github.com/ansible-lockdown/RHEL9-CIS), which will:

- install
- audit
- remediate
- audit

## Join us

Join us on our [Discord Server](https://www.lockdownenterprise.com/discord) to ask questions, discuss features, or just chat with other Ansible-Lockdown users.

## Contributing

Bug reports and feature requests are welcome from everyone, please raise an issue.

Pull requests are accepted from approved contributors only. To be onboarded, join the [Discord Server](https://www.lockdownenterprise.com/discord) and request contributor access. See [CONTRIBUTING.md](CONTRIBUTING.md) for the full process.

Set of configuration files and directories to run the first stages of CIS of RHEL 9 servers.

This is configured in a directory structure level.

Syver is run based on the goss.yml file in the top level directory. This specifies the configuration.

## Further Information

- [Syver documentation](https://github.com/krameff/syver/blob/main/docs/index.md)
- [goss vs Syver](https://github.com/krameff/syver/blob/main/docs/goss-vs-syver.md)
- [CIS standards](https://www.cisecurity.org)
