#!/usr/bin/env sh
# litecore-node.json fails to run bitcoind server (does not pass config)
# so we have to start it manually before with our config
/root/insight/chaucha-insight/chauchad -conf=/root/insight/config/bitcoinf.conf
/root/insight/chaucha-insight/node_modules/litecore-node/bin/litecore-node start