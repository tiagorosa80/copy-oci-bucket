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
# Histórico:
#
#   v1.0 26/01/2020, Tiago da Rosa:
#       - Program Start
#
#
# ------------------------------------------------------------------------ #
# Tested on:
#   bash 5.0.17(1)-release
#   oci cli 2.19.0
#       - https://docs.oracle.com/en-us/iaas/tools/oci-cli/2.19.0/oci_cli_docs/index.html
#       - https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm
# ------------------------------------------------------------------------ #
# Thanks to:
#
#
# ------------------------------------------------------------------------ #

# ------------------------------- VARIÁVEIS ----------------------------------------- #
SEMCOR="\033[0m"
VERDE="\033[32;1m"
VERMELHO="\033[31;1m"
MENSAGEM_USO="
     $(basename $0) - [OPÇÕES]

     -h - Help
     -v - Version
     -t - Test oci-cli install
     -i - Install oci-cli
     "
VERSAO="v0.1"
TEST_INSTALL="0"
INSTALL_OCI_CLI="0"

# ------------------------------------------------------------------------ #

# ------------------------------- TESTS ----------------------------------------- #


# ------------------------------------------------------------------------ #

# ------------------------------- FUNCTIONS ----------------------------------------- #
Test () {
     [ ! -x "$(which oci 2> /dev/null)" ] && TEST_INSTALL=1
     if [ ${TEST_INSTALL} -eq 1 ];
        then echo -e "${VERMELHO}

The oci-cli is not installed or is not in user PATH !!!!
If you have already installed make sure you have added the directory to the path.
If you have not installed, install using:
./copy-oci-bucket.sh -i
${SEMCOR}" && exit 0
        else
            echo -e "${VERDE} oci-cli Was successfully installed!! ${SEMCOR}" && exit 0
     fi
}

Install () {
          echo -e "${VERMELHO} Attention: choose the default options!
          They are sufficient for the purpose of this script!
          After installing, run '"oci setup config"' to configure the OCI access credentials.

          Press Enter to continue!
          ${SEMCOR}" && read && bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)" && exec -l $SHELL && exit 0
}

# ------------------------------------------------------------------------ #

# ------------------------------- EXECUTION ----------------------------------------- #
case "$1" in
  -h) echo "$MENSAGEM_USO" && exit 0          ;;
  -v) echo "$VERSAO" && exit 0                ;;
  -t) Test                                    ;;
  -i) Install                                 ;;
   *) echo "$MENSAGEM_USO" && exit 0          ;;
esac


#----------------------------------------------------------
