
# Automating Security Remediation and Auditing

<a href="https://www.mindpointgroup.com">
<img src="https://assets-global.website-files.com/601959b76833363126385b0d/60195aa15ed9274f67255f9b_MPG-logo-mono-blue.svg" width="200">
</a>

## Table of Contents

[Overview](#overview)

[Supported playbooks](#currently-enabled-playbooks)

[Setup auditing - Remediation](#setup-auditing---Remediation)

[Setup auditing - Standalone](#setup-auditing---Standalone)

[Setup auditing - Standalone Linux](#Linux)

[Setup auditing - Standalone Windows](#Windows)

[Requirements](#requirements)

[Alternate source options](#alternate-source-options)

[Other audit settings](#other-audit-settings)

[Assistance](#assistance)

[Community](#community)

[Remediation Support](#remediation-support)

[Enhanced services](#enhanced-services)

[Links](#links)

# Overview

Ansible remediation for security benchmarks now utilises an opensource
go binary called [goss](https://github.com/aelsabbahy/goss) to audit the
system.

Enabling an alternative tool to check and ensure that the remediation
role is working as expected.

Ensuring consistency in checks by using the same settings and controls
that have been enabled in the remediation steps, are the same ones
checked by the audit.

It can be run in two ways:

- Enabled to run as part of the ansible playbook and is setup to capture pre remediation and post remediation states. Using the same configured variables as used in remediation

- Standalone script
  - run_audit.sh (Linux (shell))
  - run_audit.ps1 (Windows(powershell))

# Currently enabled playbooks

**CIS:**

- RHEL 7
- RHEL 8
- RHEL 9 (this is not yet GA as an OS but based on rh8)
- Ubuntu 20.04
- Windows 2016 Standalone, Member and Controller (in testing August 21)
- Windows 2019 Standalone, Member and Controller (in testing August 21)

**STIG:**

- RHEL 7
- RHEL 8

# Setup auditing - Remediation

By Default, this is not enabled but this can be simply setup and run. This will set the system up for you and will utilise the same variables used in the remediation steps to also run the audit.
When the audit is run, this calls the same script as the standalone method with the data populated based on the variables below.

## Requirements

As per the remediation playbook this requires ability to run things as
super user.

**Recommend enable reboot.**

There is an option to skip a reboot as part of remediation. Default
option is to not allow it to take place.

Many checks that take place during the audit will only be available
after a reboot, this could change results.

## All controls can be set via the defaults/main.yml

(or relevant vars files used by your environment)

This includes.

Minimal setup -- needs access to github

```setup_audit```

> default: false

- enables the goss binary download and setup from github -- carries
  out the checksum and places by default into /usr/local/bin (see
  {{ audit_bin_path }})

  - ```get_audit_binary_method```

    > default: download

    - ```download```
      > default: {{ audit_bin_url }}

      This will download the binary using the {{ audit_bin_version }} settings

    - ```copy```

      > default: {{ audit_bin_copy_location }} (not set)

      To be used to copy from the control node to the managed node

```run_audit```

> default: false

- This will carry out the steps to get the audit configuration files,
  place these on the system and run the audit both pre and post.

- This also copies over the goss control file for all the variables as
  setup for each control and variables utilised for your environment

## Alternate source options

```audit_run_script_environment```

- Set correct env for the run_audit.sh script from https://github.com/ansible-lockdown/{{ benchmark }}-Audit.git"

```yaml
audit_run_script_environment:
  AUDIT_BIN: "{{ audit_bin }}"
  AUDIT_FILE: 'goss.yml'
  AUDIT_CONTENT_LOCATION: "{{ audit_out_dir }}"
```

```audit_content```

> default: git  # where the audit content is being pulled from if running from local

```audit_file_git```

> default:  https://github.com/ansible-lockdown/{{ benchmark }}-Audit.git

```audit_git_version```

> default: main

With version referring to the branch or specific commit.

**NOTE: We would recommend copying as an archive

We have allowed two options using the same variables

- Options
  - archived
  - copy (somewhere accessible on your network to copy from)

- Settings:

```audit_conf_copy```

  > default: (change accordingly for your environment)

e.g. Path on the control node to copy path/archive from

```audit_conf_dir```

(change as required copy as dir or extract archive)

  > Directory on the managed node where the audit conf files will run
  > from.
  > Used for the copy and the running of the audit

Alternate options

```get_url``` ( to be set according to your requirements)

```yaml
- {{ audit_file_url }} -- As description
```

- local or none

  > This assumes content is already on the system and utilises the check
  > that are already there (see audit_conf_dir setting)

## Other audit settings

```audit_run_heavy_tests```

> default: true

- These often involved working across all local file systems or
    scanning content in several files, so may have an impact on a system

Used in conjunction with:

```audit_cmd_timeout```

> default: 60000ms

- Some commands can be quite intensive on a system and take longer
    that the std 10seconds to run. This enables the timeout to still be
    set.

```audit_out_dir```

> default: /var/tmp

- Location to put the reports (filenames are set)

```audit_conf_dir```

> default: "{{ audit_out_dir }}/{{ benchmark }}-Audit/"

- Location for the audit configuration files to reside

- Change these if running local

```audit_bin_path```

> default: /usr/local/bin/

- Path for the goss binary to be stored and found

```audit_bin```

> default: "{{ audit_bin_path }}goss"

- Absolute path to the binary

Other settings can be seen in the defaults/main.yml file, changing these
may have adverse effect on other products or services.

# Setup auditing - Standalone

It is assumed that as you have the script you have downloaded the audit content already from source control or your own configired location.

The following requirements are needed OS independant

- Super user or permissions to run privilege commands
  - Linux sudo can work
  - Windows ability to run security audits and query group or local policy.

- goss binary appropriate for the OS
  - Linux
    - [64bit_v0.3.16_binary](https://github.com/aelsabbahy/goss/releases/download/v0.3.16/goss-linux-amd64)
    - [64bit_v0.3.16_sha256](https://github.com/aelsabbahy/goss/releases/download/v0.3.16/goss-linux-amd64.sha256)
  - Windows
    - [64bit_v0.3.16_exe](https://github.com/aelsabbahy/goss/releases/download/v0.3.16/goss-alpha-windows-amd64.exe)
    - [64bit_v0.3.16_sha256](https://github.com/aelsabbahy/goss/releases/download/v0.3.16/goss-alpha-windows-amd64.exe.sha256)

## Defining the audit

Each script runs against a configures variables file found in the content location in

> {downloaded content}/vars/{benchmark}.yml

These are the variables that configure which controls are run along with some configurable settings during an audit.

Each script has the ability for you to set several variables depending on your environment requirements.
e.g. locations on where to find binary or output locations

There is also switch options to allow you to run a couple of these at run time.

Script runtime options

- The group option allows a meta feild to be assigned against the report for use in analysis if servers can be grouped together.
If more than one group this can be comma seperated

- The outfile is the filename and location to save the full audit report to.

## Linux

The run_audit.sh script

This is written that:

- Uppercase variable are the only ones that should need changing
- lowercase variables are the ones that are discovered or built from existing.

script variables
example:

```sh
AUDIT_BIN="${AUDIT_BIN:-/usr/local/bin/goss}"  # location of the goss executable
AUDIT_FILE="${AUDIT_FILE:-goss.yml}"  # the default goss file used by the audit provided by the audit configuration
AUDIT_CONTENT_LOCATION="${AUDIT_CONTENT_LOCATION:-/var/tmp}"  # Location of the audit configuration file as available to the OS
```

script help

```sh
Script to run the goss audit

Syntax: ./run_audit.sh [-f|-g|-o|-v|-w|-h]
options:
-f     optional - change the format output (default value = json)
-g     optional - Add a group that the server should be grouped with (default value = ungrouped)
-o     optional - file to output audit data
-v     optional - relative path to thevars file to load (default e.g. /var/tmp/RHEL7-CIS/vars/CIS.yml)
-w     optional - Sets the system_type to workstation (Default - Server)
-h     Print this Help.

Other options can be assigned in the script itself
```

## Windows

Similar to the Linux variables that can be set within the script

```sh
NAME
    C:\remediation_audit_logs\Windows-2019-CIS-Audit\run_audit.ps1

SYNOPSIS
    Wrapper script to run an audit


SYNTAX
    C:\remediation_audit_logs\Windows-2016-CIS-Audit\run_audit.ps1 [[-auditbin] <String>] [[-auditdir] <String>]
    [[-varsfile] <String>] [[-group] <String>] [[-outfile] <String>] [<CommonParameters>]


DESCRIPTION
    Wrapper script to run an audit on the system using goss.
    This allows for bespoke variables to be set


PARAMETERS
    -auditbin <String>

    -auditdir <String>
        default: $DEFAULT_CONTENT_DIR
        Ability to change the location of where the content can be found
        This is where the audit content is stored
        e.g. c:/windows_audit

    -varsfile <String>
        default: $DEFAULT_VARS_FILE
        Ability to set a variable file defined with the settings to match your requirements

    -group <String>
        default: none
        Ability to set a group that the system belongs to
        Can be used when matching similar system in that same group

    -outfile <String>
        default: $AUDIT_CONTENT_DIR\audit_$host_os_hostname_$host_epoch.json
        Ability to set an outfile to send the full audit output to
        Requires path to be set.
        e.g. c:/windows_audit_reports

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>./run_audit.ps1

    ./run_audit.ps1 -auditbin c:\path_to\binary.name
    ./run_audit.ps1 -auditdir c:\somepath_for _audit_content
    ./run_audit.ps1 -varsfile myvars.yml
    ./run_audit.ps1 -outfile path\to\audit\output.json
    ./run_audit.ps1 -group webserver
```

script itself

# Assistance

## Remediation Support

[LockdownEnterprise](https://www.lockdownenterprise.com)

## Enhanced services

[Ansible Counselor](https://www.mindpointgroup.com/cybersecurity-products/ansible-counselor)

## Other Links

### Community

Being opensource via the version control issues pages for the relevant
benchmark.

[Ansible by Red Hat](https://www.ansible.com)

[Goss](https://github.com/aelsabbahy/goss)

[Remediation and Audit content](https://github.com/ansible-lockdown)

### Security benchmark remediations

[Remediation Download](https://engage.mindpointgroup.com/download-ansible-stig-cis-baseline-automation)

### Benchmark sites

[CIS](https://www.cisecurity.org/cis-benchmarks/)

[DISA/STIG](https://public.cyber.mil/stigs/)
