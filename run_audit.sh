#! /bin/bash
# script to run audit while populating local host data
# 13th Sept 2021 - Initial
# 9th Nov 2021 - Added root user check - more posix compliant for multiple OS types
# 10 Dec 2021 - Enhanced so more linux OS agnostic, less input required
#             - added vars options for bespoke vars file
#             - Ability to run as script from remediation role increased consistency
# 17 Dec 2021 - Added system_type variable - default Server will change to workstations with -w switch

#!/bin/bash


# Variables in upper case tend to be able to be adjusted
# lower case variables are discovered or built from other variables

# Goss Variables
BENCHMARK=CIS  # Benchmark Name aligns to the audit
AUDIT_BIN=/usr/local/bin/goss  # location of the goss executable
AUDIT_FILE=goss.yml  # the default goss file used by the audit provided by the audit configuration
AUDIT_CONTENT_LOCATION=/var/tmp  # Location of the audit configuration file as available to the OS

# help output
Help()
{
   # Display Help
   echo "Script to run the goss audit"
   echo
   echo "Syntax: $0 [-g|-o|-v|-w|-h]"
   echo "options:"
   echo "-g     optional - Add a group that the server should be grouped with (default value = ungrouped)"
   echo "-o     optional - file to output audit data"
   echo "-v     optional - relative path to thevars file to load (default e.g. $AUDIT_CONTENT_LOCATION/RHEL7-$BENCHMARK/vars/$BENCHMARK.yml)"
   echo "-w     optional - Sets the system_type to workstation (Default - Server)"
   echo "-h     Print this Help."
   echo
}


# Default vars that can be set
system_type=Server

## option statement
while getopts g:o:v::wh option; do
   case "${option}" in
        g ) GROUP=${OPTARG} ;;
        o ) OUTFILE=${OPTARG} ;;
        v ) VARS_PATH=${OPTARG} ;;
        w ) system_type=Workstation ;;
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

machine_uuid=`if [ ! -z /sys/class/dmi/id/product_uuid ]; then cat /sys/class/dmi/id/product_uuid; else dmidecode -s system-uuid; fi`
epoch=`date +%s`
os_locale=`date +%Z`
os_name=`grep "^NAME=" /etc/os-release | cut -d '"' -f2 | sed 's/ //' | cut -d ' ' -f1`
os_version=`grep "^VERSION_ID=" /etc/os-release | cut -d '"' -f2`
os_hostname=`hostname`

## Set variable audit_out
if [ -z $OUTFILE ]; then
  export audit_out=$AUDIT_CONTENT_LOCATION/audit_$os_hostname_$epoch.json
else
  export audit_out=$OUTFILE
fi


## Set the AUDIT json string
audit_json_vars='{"benchmark":"'"$BENCHMARK"'","machine_uuid":"'"$machine_uuid"'","epoch":"'"$epoch"'","os_locale":"'"$os_locale"'","os_release":"'"$os_version"'","os_distribution":"'"$os_name"'","os_hostname":"'"$os_hostname"'","auto_group":"'"$auto_group"'","system_type":"'"$system_type"'"}'

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


## Run commands
echo "#############"
echo "Audit Started"
echo "#############"
echo
$AUDIT_BIN -g $audit_content_dir/$AUDIT_FILE --vars $varfile_path  --vars-inline $audit_json_vars v -f json -o pretty > $audit_out

# create screen output
if [ `grep -c $BENCHMARK $audit_out` != 0 ]; then
echo "
`tail -7 $audit_out`

Completed file can be found at $audit_out"
echo "###############"
echo "Audit Completed"
echo "###############"

else
  echo "Fail Audit - There were issues when running the audit please investigate $audit_out"
fi