#! /bin/bash
# script to run audit while populating local host data
# 13th Sept 2021 - Initial
# 9th Nov 2021 - Added root user check - more posix compliant for multiple OS types
# 10 Dec 2021 - Enhanced so more linux OS agnostic, less input required
#             - added vars options for bespoke vars file
#             - Ability to run as script from remediation role increased consistency
# 17 Dec 2021 - Added system_type variable - default Server will change to workstations with -w switch
# 02 Mar 2022 - Updated benchmark variable naming
# 06 Apr 2022 - Added format option in output inline with goss options e.g. json documentation this is for fault finding
# 03 May 2022 - update for audit variables improvement added by @pavloos - https://github.com/ansible-lockdown/RHEL8-CIS-Audit/pull/29
# 10 Jun 2022 - added format output for different type - supports json,documentation or rspecish


#!/bin/bash


# Variables in upper case tend to be able to be adjusted
# lower case variables are discovered or built from other variables

# Goss host Variables
AUDIT_BIN="${AUDIT_BIN:-/usr/local/bin/goss}"  # location of the goss executable
AUDIT_FILE="${AUDIT_FILE:-goss.yml}"  # the default goss file used by the audit provided by the audit configuration
AUDIT_CONTENT_LOCATION="${AUDIT_CONTENT_LOCATION:-/opt}"  # Location of the audit configuration file as available to the OS


# Goss benchmark variables (these should not need changing unless new release)
BENCHMARK=CIS  # Benchmark Name aligns to the audit
BENCHMARK_VER=notofficial
BENCHMARK_OS=RHEL9

# help output
Help()
{
   # Display Help
   echo "Script to run the goss audit"
   echo
   echo "Syntax: $0 [-f|-g|-o|-v|-w|-h]"
   echo "options:"
   echo "-f     optional - change the format output (default value = json) other working options documentation, rspecish"
   echo "-g     optional - Add a group that the server should be grouped with (default value = ungrouped)"
   echo "-o     optional - file to output audit data"
   echo "-v     optional - relative path to thevars file to load (default e.g. $AUDIT_CONTENT_LOCATION/RHEL7-$BENCHMARK/vars/$BENCHMARK.yml)"
   echo "-w     optional - Sets the system_type to workstation (Default - Server)"
   echo "-h     Print this Help."
   echo
}


# Default vars that can be set
host_system_type=Server

## option statement
while getopts f:g:o:v::wh option; do
   case "${option}" in
        f ) FORMAT=${OPTARG} ;;
        g ) GROUP=${OPTARG} ;;
        o ) OUTFILE=${OPTARG} ;;
        v ) VARS_PATH=${OPTARG} ;;
        w ) host_system_type=Workstation ;;
        h ) # display Help
            Help
            exit;;
        ? ) # Invalid option
         echo "Invalid option: -${OPTARG}."
         Help
         exit;;
  esac
done

#### Pre-Checks

# check access need to run as root or privileges due to some configuration access
if [ $(/usr/bin/id -u) -ne 0 ]; then
  echo "Script need to run with root privileges"
  exit 1
fi

#### Main Script

# Discover OS version aligning with audit
# Define os_vendor variable
if [ `grep -c rhel /etc/os-release` != 0 ]; then
    os_vendor="RHEL"
else
    os_vendor=`hostnamectl | grep Oper | cut -d : -f2 | awk '{print $1}' | tr a-z A-Z`
fi

os_maj_ver=`grep -w VERSION_ID= /etc/os-release | awk -F\" '{print $2}' | cut -d '.' -f1`
audit_content_version=$os_vendor$os_maj_ver-$BENCHMARK-Audit
audit_content_dir=$AUDIT_CONTENT_LOCATION/$audit_content_version
audit_vars=vars/${BENCHMARK}.yml

# Set variable for format output
if [ -z $FORMAT ]; then
  export format="json"
else
  export format=$FORMAT
fi

# Set variable for autogroup
if [ -z $GROUP ]; then
  export auto_group="ungrouped"
else
  export auto_group=$GROUP
fi

# set default variable for varfile_path
if [ -z "$VARS_PATH" ]; then
     export varfile_path=$audit_content_dir/$audit_vars
   else
   # Check -v exists fail if not
   if [ -f "$VARS_PATH" ]; then
     export varfile_path=$VARS_PATH
   else
     echo "passed option '-v' $VARS_PATH does not exist"
     exit 1
   fi
fi


## System variables captured for metadata

host_machine_uuid=`if [ ! -z /sys/class/dmi/id/product_uuid ]; then cat /sys/class/dmi/id/product_uuid; else dmidecode -s system-uuid; fi`
host_epoch=`date +%s`
host_os_locale=`date +%Z`
host_os_name=`grep "^NAME=" /etc/os-release | cut -d '"' -f2 | sed 's/ //' | cut -d ' ' -f1`
host_os_version=`grep "^VERSION_ID=" /etc/os-release | cut -d '"' -f2`
host_os_hostname=`hostname`

## Set variable audit_out
if [ -z $OUTFILE ]; then
  export audit_out=$AUDIT_CONTENT_LOCATION/audit_${host_os_hostname}-${BENCHMARK}-${BENCHMARK_OS}_${host_epoch}.$format
else
  export audit_out=$OUTFILE
fi


## Set the AUDIT json string
audit_json_vars='{"benchmark_type":"'"$BENCHMARK"'","benchmark_os":"'"$BENCHMARK_OS"'","benchmark_version":"'"$BENCHMARK_VER"'","machine_uuid":"'"$host_machine_uuid"'","epoch":"'"$host_epoch"'","os_locale":"'"$host_os_locale"'","os_release":"'"$host_os_version"'","os_distribution":"'"$host_os_name"'","os_hostname":"'"$host_os_hostname"'","auto_group":"'"$host_auto_group"'","system_type":"'"$host_system_type"'"}'

## Run pre checks

echo
echo "## Pre-Checks Start"
echo

export FAILURE=0
if [ -s "$AUDIT_BIN" ]; then
   echo "OK Audit binary $AUDIT_BIN is available"
else
   echo "WARNING - The audit binary is not available at $AUDIT_BIN "; export FAILURE=1
fi

if [ -f "$audit_content_dir/$AUDIT_FILE" ]; then
   echo "OK $audit_content_dir/$AUDIT_FILE is available"
else
   echo "WARNING - the $audit_content_dir/$AUDIT_FILE is not available"; export FAILURE=2
fi


if [ `echo $FAILURE` != 0 ]; then
   echo "## Pre-checks failed please see output"
   exit 1
else
   echo
   echo "## Pre-checks Successful"
   echo
fi

# format output
#json, rspecish = grep -A 4 \"summary\": $audit_out
# tap junit no output as no summary
#documentation = tail -2 $audit_out

# defaults
output_summary="tail -2 $audit_out"
format_output="-f $format"

if [ $format = json ]; then
   format_output="-f json -o pretty"
   output_summary="grep -A 4 \"summary\": $audit_out"
elif [ $format = junit ] || [ $format = tap ]; then
   output_summary=""
fi



## Run commands
echo "#############"
echo "Audit Started"
echo "#############"
echo
$AUDIT_BIN -g $audit_content_dir/$AUDIT_FILE --vars $varfile_path  --vars-inline $audit_json_vars v $format_output > $audit_out

# create screen output
if [ `grep -c $BENCHMARK $audit_out` != 0 ] || [ $format = junit ] || [ $format = tap ]; then
echo " `$output_summary`
Completed file can be found at $audit_out"
echo "###############"
echo "Audit Completed"
echo "###############"

else
  echo "Fail Audit - There were issues when running the audit please investigate $audit_out"
fi
