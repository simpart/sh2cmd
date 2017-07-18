#!/bin/bash

echo_usage () {
    echo "usage:"
    echo "./install.sh [command] [target]"
}

# check parameter
if [ $# -ne 2 ]; then
    echo "ERROR : too few parameter"
    echo_usage
    exit 1
fi

# check target exists
if [ ! -e $2 ]; then
    echo "ERROR : target is not found"
    echo_usage
    exit 1
fi


# change directory to script dir
#SCP_DIR=$(cd $(dirname $0);pwd);
#cd $SCP_DIR/../

cp $SCP_DIR/cmd.tmpl /usr/bin/$1
chmod 755 /usr/bin/$1

SED_PRM="s/@current/${$2//\//\\/}\/..\//g"
echo sed -i $SED_PRM /usr/bin/$1
sed -i $SED_PRM /usr/bin/$1

echo create $1 command
