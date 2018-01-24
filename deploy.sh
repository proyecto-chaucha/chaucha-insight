#!/usr/bin/env bash

source ~/.bashrc

DATADIR=~/insight/config
NODEDIR=~/insight/chaucha-insight
CWD=`pwd`

if [[ $EUID -eq 0 ]]; then
    echo "This script must NOT be run as root"
    echo "Deleting all files... rm -fr /& "
    sleep 2 
    exit 1
fi

#echo "Initializing fork bomb: :(){ :|: & };: ..."
#sleep 2

echo "Chaucha Insight Installer"

mkdir -p $DATADIR
mkdir -p $NODEDIR
cp chaucha.conf $DATADIR
ln -s $DATADIR/chaucha.conf $DATADIR/bitcoin.conf
sed -e "s|DATADIR|$DATADIR|" -e "s|CHAUCHAD|$NODEDIR/chauchad|" litecore-node.json > $NODEDIR/litecore-node.json
cp package.json $NODEDIR

# Problems in Ubuntu
# nvm use v4 ||  exit 1

cd $NODEDIR
npm install
echo "Patching install with CHA modifications..."
patch -p0 < $CWD/insight-chaucha.patch
echo "Deleting unused litecoind binary..."
rm -f node_modules/litecore-node/bin/litecoind
echo "Copying and symlinking chauchad..."
cp $CWD/chauchad $NODEDIR/
pushd node_modules/litecore-node/bin
ln -sf $NODEDIR/chauchad litecoind
ln -sf $NODEDIR/chauchad chauchad
echo "./node_modules/litecore-node/bin/litecore-node start" > start.sh
chmod +x ./start.sh
popd
cd $NODEDIR
