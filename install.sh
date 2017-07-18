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


SCP_DIR=$(cd $(dirname $0);pwd);
cp $SCP_DIR/cmd.tmpl /usr/bin/$1
if [ $? -ne 0 ]; then
    echo "ERROR : failed copy cmd.tmpl"
    exit 1
fi

chmod 755 /usr/bin/$1
if [ $? -ne 0 ]; then
    echo "ERROR : failed change mode"
    exit 1
fi

TGT=$2
SED_PRM="s/@target/${TGT//\//\\/}\/..\//g"
echo sed -i $SED_PRM /usr/bin/$1
sed -i $SED_PRM /usr/bin/$1
if [ $? -ne 0 ]; then
    echo "ERROR : failed sed command"
    exit 1
fi

echo create $1 command
