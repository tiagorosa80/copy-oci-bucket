#!/usr/bin/env bash
#
# copy-ocy-bucket.sh - Copy files to a OCI Bucket
#
# Site:       https://github.com/tiagorosa80/copy-oci-bucket
# Autor:      Tiago da Rosa
#
# ------------------------------------------------------------------------ #
#  This program is used to copy files to a Bucket on the Oracle Cloud.
#  It is an alternative to the oci cli.
#  My intention is to make copying multiple files easy.
#
#  Example:
#      $ ./copy-ocy-bucket.sh -c conf.cf
#      In this example the script will copy the files to Bucket that are
#      informed in the configuration file.
# ------------------------------------------------------------------------ #
# Development History:
#
#   v1.0 26/01/2020, Tiago da Rosa:
#       - Program Start
#
#
# ------------------------------------------------------------------------ #
# Tested on:
#   bash 5.0.17(1)-release
#   oci cli 2.20.0
#       - https://docs.oracle.com/en-us/iaas/tools/oci-cli/2.19.0/oci_cli_docs/index.html
#       - https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm
# ------------------------------------------------------------------------ #
# Thanks to:
#
#
# ------------------------------------------------------------------------ #

# ------------------------------- VARIÁVEIS ----------------------------------------- #
NOCOLOR="\033[0m"
GREEN="\033[32;1m"
RED="\033[31;1m"
USAGE="
     $(basename $0) - [OPTIONS]

     -h - Help
     -v - Version
     -t - Test oci-cli install
     -i - Install oci-cli
     -f - Use configuration file to upload/download files or list Buckets
     "
VERSION="v0.1"
TEST_INSTALL="0"
INSTALL_OCI_CLI="0"
CONFIGURATION_FILE="$2"
PROFILE="DEFAULT"
NAME_SPACE="0"
BUCKET_NAME="0"
FILE_NAME="0"
OPERATION="0"

# ------------------------------------------------------------------------ #

# ------------------------------- TESTS ----------------------------------------- #

# ------------------------------------------------------------------------ #

# ------------------------------- FUNCTIONS ----------------------------------------- #
Test () {
     [ ! -x "$(which oci 2> /dev/null)" ] && TEST_INSTALL=1
     if [ ${TEST_INSTALL} -eq 1 ];
        then echo -e "${RED}

The oci-cli is not installed or is not in user PATH !!!!
If you have already installed make sure you have added the directory to the path.
If you have not installed, install using:
./copy-oci-bucket.sh -i
${NOCOLOR}" && exit 0
        else
            echo -e "${GREEN} oci-cli Was successfully installed!! ${NOCOLOR}" && exit 0
     fi
}

Install () {
          echo -e " Attention: choose the default options, they are sufficient for the purpose of this script!
          Please: Press Y to update the python version, if possible on your operating system of course.
          After installing, run ${RED} oci setup config ${NOCOLOR} to configure the OCI access credentials.

          Press Enter to continue!
          " && read && bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)" && exec -l $SHELL && exit 0
}

File () {
  [ ! -r "$CONFIGURATION_FILE" ] && echo "ERROR: We don't have read access to the configuration file!" && exit 1
  [ ! -e "$CONFIGURATION_FILE" ] && echo "ERROR. File does not exist!"    && exit 1
  source ${CONFIGURATION_FILE} && oci os object put -ns ${NAME_SPACE} --bucket-name ${BUCKET_NAME} --file ${FILE_NAME} --no-multipart
}

# ------------------------------------------------------------------------ #

# ------------------------------- EXECUTION ----------------------------------------- #
case "$1" in
  -h) echo "$USAGE" && exit 0          ;;
  -v) echo "$VERSION" && exit 0        ;;
  -t) Test                             ;;
  -i) Install                          ;;
  -f) File                             ;;
   *) echo "$USAGE" && exit 0          ;;
esac

#----------------------------------------------------------
